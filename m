Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268330AbUJQTVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268330AbUJQTVp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUJQTVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:21:45 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:29724 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S268330AbUJQTVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:21:43 -0400
X-BrightmailFiltered: true
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Buddy Lucas'" <buddy.lucas@gmail.com>,
       "'Lars Marowsky-Bree'" <lmb@suse.de>,
       "'David Schwartz'" <davids@webmaster.com>,
       "'Linux-Kernel@Vger. Kernel. Org'" <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sun, 17 Oct 2004 12:21:38 -0700
Organization: Cisco Systems
Message-ID: <012901c4b47e$865c9570$b83147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <5d6b65750410170840c80c314@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is a distraction. If the call to select() had been substituted
> > with a call to recvmsg(), it would have blocked. Instead, 
> select() is
> > returning 'yes, you can read', and then recvmsg() is blocking. The
> > select() lied. The information is all sitting in the kernel packet
> 
> No. A million things might happen between select() and recvmsg(), both
> in kernel and application. For a consistent behaviour throughout all
> possibilities, you *have* to assume that any read on a blocking fd may
> block.

Care to provide a real example?

UDP isn't one. It was done for performance reasons as David admitted and it
could very well be done otherwise: do the checksum before select returns.

David has admitted the only reason Linux chose to do so is performance.

It might be the case that a million things might happen between select and
recvmsg, but none of them, as I can see, *have* to force Linux to work this
way. The only reason as I can see is performance and imlementation
convenience.

Hua

