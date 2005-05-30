Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVE3Qzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVE3Qzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 12:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVE3Qzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 12:55:39 -0400
Received: from mail.gmx.de ([213.165.64.20]:23512 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261650AbVE3Qzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 12:55:33 -0400
Date: Mon, 30 May 2005 18:55:22 +0200 (MEST)
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, roland@redhat.com, akpm@osdl.org, mtk-lkml@gmx.net,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.4.58.0505261617360.2307@ppc970.osdl.org>
Subject: Re: waitid() fails with EINVAL for SA_RESTART signals
X-Priority: 3 (Normal)
X-Authenticated: #2864774
Message-ID: <8295.1117472122@www60.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 26 May 2005, David S. Miller wrote:
> > 
> > > Other machines are subject to the same risk and should have a
> > > prevent_tail_call definition too.  The asm-i386/linkage.h version
> > > probably
> > > works fine for every machine.  It might as well be generic, I'd say.
> > 
> > Sparc, for one, doesn't need it.  We pass the pt_regs in via a pointer
> > to the trap level stack frame which won't be released by a tail-call
> > in C code.
> 
> x86 has largely tried to move in that direction too, ie a lot of the 
> asm-calls have been turned into FASTCALL() with %eax pointing to the 
> stack.
> 
> Roland, I applied the patch, but if there was some particular case that 
> triggered this, maybe it's worth trying to re-write that one.

Did I miss something.  Did this patch come through the 
list?  (I didn't see it.)

Cheers,

Michael

-- 
5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
+++ GMX - die erste Adresse für Mail, Message, More +++
