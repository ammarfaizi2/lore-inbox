Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbTE1LXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 07:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264687AbTE1LXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 07:23:45 -0400
Received: from mxout2.netvision.net.il ([194.90.9.21]:18051 "EHLO
	mxout2.netvision.net.il") by vger.kernel.org with ESMTP
	id S264685AbTE1LXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 07:23:40 -0400
Date: Wed, 28 May 2003 14:36:55 +0300
From: Nir Livni <nirl@cyber-ark.com>
Subject: fork() crashes on child but returns success on parent
To: linux-kernel@vger.kernel.org
Message-id: <E1298E981AEAD311A98D0000E89F45134B5694@ORCA>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now I know for sure that the child crashes (SIGSEGV) before fork() returns.
I could see it in the UML debugger.
It does not use the signal handler I have set up of the SIGSEGV. It simply
crashes and exits.

Could this be any kernel problem ?
Any ideas what should I do next to track this problem ?

> Subject: fork() returns on parent but not returns on child
> 
> 
> Hi all,
> I am experiencing a problem, where fork() returns succesfully 
> on parent, but does not return on child. The child process 
> simply "disappears". I believe it might have got a SIGSEGV 
> (if it makes any sence) before fork() has returned.
> 
> I would like to track down this problem.
> What I did so far is:
> 1. I tried first to make sure there are no memory overruns 
> using few tools. 2. I tried to look at strace output, but the 
> problem does not occur if I use strace 3. I make a 
> UserModeLinux machine and now I would like to breakpoint the 
> created child before it crashes (assuming it really crashes)
> 
> How do I do that ?
> 
> Thanks,
> Nir
> 
