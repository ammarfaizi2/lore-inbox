Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268978AbUJQA3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268978AbUJQA3j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268980AbUJQA3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:29:39 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:59400 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S268978AbUJQA33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:29:29 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <aebr@win.tue.nl>
Cc: <mark@mark.mielke.cc>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sat, 16 Oct 2004 17:28:22 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEONPAAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20041016182544.GC3379@pclin040.win.tue.nl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 16 Oct 2004 17:05:03 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 16 Oct 2004 17:05:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Oct 15, 2004 at 09:58:38PM -0700, David Schwartz wrote:
>
> > Linux's behavior is correct in the literal sense that it is
> > doing something
> > that is allowed. It's incorrect in the sense that it's sub-optimal.
>
> "Allowed" by whom? By you?

	I clearly explained what I meant in context that you snipped. In summary, I
mean 'allowed' in the sense that it's not prohibited by the standard and
arguing that it's not allowed leads to direct logical contradictions.
Nothing prohibits an implementation from dropping a UDP packet after it has
been received. Nothing in POSIX requires that a subsequent operation
actually does not block.

	Would you argue that an implementation cannot drop a UDP packet after it
has indicated a read hit on 'select' because of that packet? If so, where
does POSIX say this? And if not, then it can drop a corrupt packet on a call
to 'recvmsg' as well.

	DS



