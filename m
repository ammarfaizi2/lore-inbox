Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVBRQ4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVBRQ4H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 11:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVBRQ4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 11:56:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:1489 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261407AbVBRQzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 11:55:53 -0500
To: Andries Brouwer <aebr@win.tue.nl>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.6.10-ac12 + kernbench == oom-killer: (OSDL) 
In-reply-to: <20050209013617.GC2686@pclin040.win.tue.nl> 
References: <20050208145707.1ebbd468@es175> <20050209013617.GC2686@pclin040.win.tue.nl>
Comments: In-reply-to Andries Brouwer <aebr@win.tue.nl>
   message dated "Wed, 09 Feb 2005 02:36:17 +0100."
Date: Fri, 18 Feb 2005 08:55:47 -0800
From: Cliff White <cliffw@osdl.org>
Message-Id: <E1D2BPv-0006T3-Q6@es175>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Feb 08, 2005 at 02:57:07PM -0800, cliff white wrote:
> 
> > Running 2.6.10-ac10 on the STP 1-CPU machines, we don't seem to be able to 
> complete
> > a kernbench run without hitting the OOM-killer. ( kernbench is multiple ker
> nel compiles,
> > of course ) Machine is 800 mhz PIII with 1GB memory. We reduce memory for s
> ome of the runs.
> > 
> > Typical results:
> > 
> > Out of Memory: Killed process 14970 (cc1).
> > -------------------------
> > It looks like some oom-related stuff went into -ac10, will try retest with 
> > -ac9 and -ac10, see what happens. Lemme know if we can do more
> 
> I am always curious to hear how things are when you set
> /proc/sys/vm/overcommit_memory to 2
> (and possibly /proc/sys/vm/overcommit_ratio to something
> appropriate).

Okay, with just vm.overcommit=2, things are still bad:
http://khack.osdl.org/stp/300854/logs/TestRunFailed.console.log.txt

Suggestion for vm.overcommit_ratio ?
Or should i repeat with later -ac ?
cliffw

-----------Some output---------------
Free pages:        8872kB (0kB HighMem)

Active:14865 inactive:4118 dirty:0 writeback:629 unstable:0 free:2218 slab:11489 mapped:32027 pagetables:13800

DMA free:1224kB min:128kB low:160kB high:192kB active:552kB inactive:196kB present:16384kB pages_scanned:401 all_unreclaimable? no

protections[]: 0 0 0

Normal free:7648kB min:1920kB low:2400kB high:2880kB active:58908kB inactive:16276kB present:245760kB pages_scanned:1395 all_unreclaimable? no

protections[]: 0 0 0

HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no

protections[]: 0 0 0

DMA: 240*4kB 17*8kB 2*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1224kB

Normal: 1348*4kB 46*8kB 54*16kB 6*32kB 1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 7648kB

HighMem: empty

Swap cache: add 23226854, delete 23224756, find 324015/2933249, race 2549+2365

Out of Memory: Killed process 14667 (rpm).

oom-killer: gfp_mask=0xd2

DMA per-cpu:

cpu 0 hot: low 2, high 6, batch 1

cpu 0 cold: low 0, high 2, batch 1

Normal per-cpu:

cpu 0 hot: low 30, high 90, batch 15

cpu 0 cold: low 0, high 30, batch 15

HighMem per-cpu: empty

------------------
cliffw



> 
> Andries
> 
