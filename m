Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbTIGVse (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTIGVse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:48:34 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:16775 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261560AbTIGVrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:47:42 -0400
Date: Sun, 7 Sep 2003 23:47:36 +0200 (MEST)
Message-Id: <200309072147.h87Llajl020895@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bunk@fs.tum.de
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Cc: linux-kernel@vger.kernel.org, robert@schwebel.de, rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Sep 2003 19:51:50 +0200, Adrian Bunk wrote:
>> >In 2.6 selecting M486 means that only the 486 is supported.
>> 
>> Can you prove your claim about 2.6?
>> 
>> There is to the best of my knowledge nothing in 2.6.0-test4
>> that prevents a kernel compiled for CPU type N from working
>> with CPU types >N. Just to prove it, I built a CONFIG_M486
>> 2.6.0-test4 and booted it w/o problems on P4, PIII, and K6-III.
>
>Look at X86_L1_CACHE_SHIFT in arch/i386/Kconfig.

I have. All it does is change how much space the kernel
allocates to spinlocks and some other structures. This is
merely an optimisation primarily for SMP. This does not
prevent code from executing correctly on CPUs having a
different actual L1 cache line size.

>> (In case 2 configure for PIII and use that on PIII and P4.)
>> 
>> Maybe I'm missing something but I don't see any problem here.
>
>In current 2.6 this is only legal with X86_GENERIC enabled.

No. You're over-interpreting X86_GENERIC. All it does is
change some optimisation defaults. It is not required for
correctness.

/Mikael
