Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbVKGVrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbVKGVrL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVKGVrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:47:11 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:65255 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965004AbVKGVrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:47:09 -0500
In-Reply-To: <7e77d27c0511070646o7b8686aes@mail.gmail.com>
To: Yan Zheng <yzcorp@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH][MCAST]Clear MAF_GSQUERY flag when process MLDv1 general query
 messages.
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF7136C7EC.A2BD07E5-ON882570B2.00768CF6-882570B2.0077AB0D@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Mon, 7 Nov 2005 13:47:23 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 11/07/2005 14:47:24,
	Serialize complete at 11/07/2005 14:47:24
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yan Zheng <yzcorp@gmail.com> wrote on 11/07/2005 06:46:20 AM:

> If the first query message receive after expiration is MLDv2 general
> query and MAF_GSQUERY flag is set. The report message only contains
> sources marked by last MLDv2 Multicast Address and Source Specific
> Queries . Although this circumstance happens  rare, I think it's
> better have it fixed

        Do you have a test case that demonstrates this? It appears to
me that an MLDv2 general query doesn't execute that code (short circuited
above) and an MLDv1 general query (what that code is handling) will
have a timer expiring before switching back to MLDv2 mode (so it'll send
a v1 report, without any sources). Unless I'm missing something, I can't
see any way for the scenario you've described to happen.
        That said, I also can't see anything it would hurt, so I don't 
object,
but it looks unnecessary to me.

                                                        +-DLS

