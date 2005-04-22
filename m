Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVDVVMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVDVVMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 17:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVDVVMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 17:12:46 -0400
Received: from 70-56-217-9.albq.qwest.net ([70.56.217.9]:32398 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262133AbVDVVMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 17:12:43 -0400
Date: Fri, 22 Apr 2005 15:15:20 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Aaron P. Martinez" <ml@proficuous.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic and then oops
In-Reply-To: <1114152455.5272.30.camel@aaron.proficuous.com>
Message-ID: <Pine.LNX.4.61.0504221513060.26462@montezuma.fsmlabs.com>
References: <1114152455.5272.30.camel@aaron.proficuous.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2005, Aaron P. Martinez wrote:

> I am running Centos 4 with the latest kernel (updated yesterday)
> 2.6.9-5.0.5.EL on a P4 2.4 machine w/1 Gb ram and for the last couple
> weeks the machine has just been randomly hanging.  I did upgrade the
> memory from a 512m stick to 2 1 gig sticks because the machine was
> regularly using 100% of the swap and would simply crawl.  I know the
> thing to look at here obviously is the memory but i've already run
> memtest86+ and it reported that there was nothing wrong with the memory.
> I have tried running with a single stick of the 1Gb for the last couple
> days and tomorrow will be putting the 512 back in just for testing.
> 
> I searched the archives for the error, but as far as kernel debugging
> goes, i'm very new to it.  I saw a lot of errors that looked similar but
> as i'm not exactly sure how to read all of the data from a crash I hoped
> i could get some help from the experts.
> 
> Generally when the machine hangs i get __nothing__ in the logs as far as
> a crash trace goes...the machine just seems to hang (sometimes i can
> ping it..other times not) and a hard reset is forced.  When it comes
> up..the log is void of any info.  Today the machine reset, I wasn't
> onsite, but as it was hanging i got the onsite person to give me the
> error:
> 
> <0> kernel panic not syncing: fatal exception in interrupt
> <0> kernel panic not syncing: arch/i386/kernel/irq.c:590 spin_is_locked
> on
> initialized spinlock C03a5098
> 
> 
> I'm sure there was other messages but this is all i got from him before
> he needed to get the machine running again.  He reset the machine and
> about 2 minutes later the following messages showed up in the log:
> 
> 
> Unable to handle kernel paging request at virtual address b9e91c8a
> Apr 21 16:12:44 wolverine kernel:  printing eip:
> Apr 21 16:12:44 wolverine kernel: f88aed9a
> Apr 21 16:12:44 wolverine kernel: *pde = 00000000
> Apr 21 16:12:44 wolverine kernel: Oops: 0002 [#1]
> Apr 21 16:12:44 wolverine kernel: Modules linked in: md5 ipv6 autofs4

It's highly likely that you may have faulty memory, i suggest running for 
an extended period in the previous 512M configuration. If that works, try 
installing the new memory and resetting the BIOS so that you end up with 
conservative RAM timing settings.

	Zwane

