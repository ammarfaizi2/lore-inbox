Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbTEGTHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTEGTHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:07:07 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6019 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264206AbTEGTHE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:07:04 -0400
Date: Wed, 7 May 2003 15:22:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <Pine.LNX.4.50.0305071137330.2208-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.53.0305071517100.13724@chaos>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]>
 <Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com>
 <Pine.LNX.4.53.0305071424290.13499@chaos>
 <Pine.LNX.4.50.0305071137330.2208-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Davide Libenzi wrote:

> On Wed, 7 May 2003, Richard B. Johnson wrote:
>
> > No, No. That is a process stack. Every process has it's own, entirely
> > seperate stack. This stack is used only in user mode. The kernel has
> > it's own stack. Every time you switch to kernel mode either by
> > calling the kernel or by a hardware interrupt, the kernel's stack
> > is used.
>
> Is it your understanding that does not exist a per task kernel stack ?
>

It is my understanding that there is one kernel stack. If there
is a stack allocated for some "transition", and I guess there
may be, because of the mail I'm getting, then it has absolutely
no purpose whatsoever and is wasted valuable non-paged RAM.

The reason why system-call parameters are passed in registers
is so that we didn't have the overhead of copying stuff from a
user stack to a kernel stack.

Does anybody know (not guess) if this was stuff added for the
new non-interrupt 0x80 syscall code? I want to know how a
simple kernel got corrupted into this twisted thing.

Anybody who has a copy of any of the Intel manuals since '386
knows that there needs to be only one kernel stack.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

