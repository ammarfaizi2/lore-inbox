Return-Path: <linux-kernel-owner+w=401wt.eu-S1751128AbXALPDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbXALPDv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 10:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbXALPDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 10:03:50 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:55789 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751128AbXALPDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 10:03:50 -0500
Date: Fri, 12 Jan 2007 10:03:49 -0500
To: Sunil Naidu <akula2.shark@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Choosing a HyperThreading/SMP/MultiCore kernel ?
Message-ID: <20070112150349.GI17269@csclub.uwaterloo.ca>
References: <8355959a0701120525m5d1a7904i56b8a8f7316883d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8355959a0701120525m5d1a7904i56b8a8f7316883d6@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 06:55:32PM +0530, Sunil Naidu wrote:
> There are 2 cases:-
> 
> #1 Intel Pentium 4 Workstation with HyperThreading
> 
> Since kernel takes HT as 2 processors, I did say in KConfig as:
> 
> CONFIG_SMP= y
> CONFIG_NR_CPUS=2
> CONFIG_SCHED_MC=not set
> CONFIG_MPENTIUM4=y (Or should I say CONFIG_X86_PC=y)
> CONFIG_SCHED_SMT=y
> CONFIG_SCHED_MC=not set
> RESOURCES_64BIT=not set
> HOTPLUG_CPU=not set
> 
> 
> Pl correct me if am wrong.
> 
> 
> #2 Intel Core2Duo Processor - Laptop
> 
> CONFIG_SMP= y
> CONFIG_NR_CPUS=4 ??
> CONFIG_SCHED_MC=y
> CONFIG_X86_PC=y ?  (if wrong, what should I set for Xeon QuadCore)
> CONFIG_SCHED_SMT=not set
> CONFIG_SCHED_MC=y
> RESOURCES_64BIT=not set
> HOTPLUG_CPU=not set
> 
> I didn't start this yet (still with Mac, will install in weekend), is
> this correct one?
> 
> [OT] I don't know if I can ask about a suggested distro here or not?
> Anyway, me read that Fedore & Yellow Dog suits well for this?

I would expect any distribution should work on these (as long as the
kernel they use isn't too old.).  Of course if it is a Mac, you need a
distribution that supports their firmware (which is of course not a PC
bios).  As long as you can boot it, any i386 or amd64 kernel with smp
enabled should use all the processors present (well amd64 on the
core2duo and on the p4 if it is em64t enabled).

I believe the closest optimization for a Core2 is probably the Pentium M
(certainly not the P4/netburst).  Not entirely sure though.

--
Len Sorensen
