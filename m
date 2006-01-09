Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbWAIAU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWAIAU6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965356AbWAIAU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:20:58 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35247
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965010AbWAIAU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:20:57 -0500
Date: Sun, 08 Jan 2006 16:20:17 -0800 (PST)
Message-Id: <20060108.162017.97708180.davem@davemloft.net>
To: davidel@xmailserver.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] POLLHUP tinkering ...
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.63.0601081610130.6925@localhost.localdomain>
References: <Pine.LNX.4.63.0601081528170.6925@localhost.localdomain>
	<20060108.160802.103497642.davem@davemloft.net>
	<Pine.LNX.4.63.0601081610130.6925@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Libenzi <davidel@xmailserver.org>
Date: Sun, 8 Jan 2006 16:11:10 -0800 (PST)

> On Sun, 8 Jan 2006, David S. Miller wrote:
> 
> > The extra last read is always necessary, it's an error synchronization
> > barrier.  Did you know that?
> >
> > If a partial read or write hits an error, the successful amount of
> > bytes read or written before the error occurred is returned.  Then any
> > subsequent read or write will report the error immediately.
> 
> Sorry for the missing info, but I was clearly talking about O_NONBLOCK 
> here.

What I said still applies to O_NONBLOCK.
