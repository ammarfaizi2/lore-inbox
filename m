Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVDESNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVDESNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVDESMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:12:37 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:55523 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261848AbVDESHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:07:41 -0400
Subject: Re: pktcddvd -> immediate crash
From: Soeren Sonnenburg <kernel@nn7.de>
To: Nix <nix@esperi.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <87fyy5jgt6.fsf@amaterasu.srvr.nix>
References: <1112640251.5410.30.camel@localhost>
	 <87fyy5jgt6.fsf@amaterasu.srvr.nix>
Content-Type: multipart/mixed; boundary="=-4esXcHUUIwGB9Ouxdze5"
Date: Tue, 05 Apr 2005 20:06:24 +0200
Message-Id: <1112724384.5410.61.camel@localhost>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4esXcHUUIwGB9Ouxdze5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-04-05 at 18:04 +0100, Nix wrote:
> On 5 Apr 2005, Soeren Sonnenburg whispered secretively:
> > I wonder whether anyone could use the pktcddvd device without killing
> > random jobs (due to sudden out of memory or better memory leaks in
> > pktcddvd) and finally a complete freeze of the machine ?
> 
> I'm using it without difficulty.
> 
> > To reproduce just create an udf filesystem on some dvdrw, mount it rw
> > and copy some large file to the mount point.
> 
> Well, I copied a 502Mb file to a CD/RW yesterday as part of my
> regular backups. No problems.
>
> I think we need more details (a .config would be nice, and preferably
> a cat of /proc/slabinfo and a dmesg dump when the problem starts).

.config is attached (gzipped) and dmesg see below. unfortunately I
cannot provide a cat of /proc/slabinfo after the problem started...

however this machine has like 1.5G mem 2G swap and was doing no serious
stuff, i.e. no high load no high memory requirements (I guess <500M)

Soeren

pktcdvd: inserted media is DVD+RW
pktcdvd: write speed 2822kB/s
pktcdvd: 4590208kB available on disc
UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 2005/03/27 18:49 (103c)
rtc: lost some interrupts at 1024Hz.
rtc: lost some interrupts at 1024Hz.
rtc: lost some interrupts at 1024Hz.
rtc: lost some interrupts at 1024Hz.
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16

Free pages:       28944kB (896kB HighMem)
Active:46742 inactive:158822 dirty:666 writeback:114320 unstable:0 free:7236 slab:18648 mapped:44732 pagetables:845
DMA free:3960kB min:584kB low:728kB high:876kB active:1996kB inactive:1104kB present:16384kB pages_scanned:3747 all_unreclaimable? yes
lowmem_reserve[]: 0 880 1519
Normal free:24088kB min:32180kB low:40224kB high:48268kB active:5780kB inactive:167540kB present:901120kB pages_scanned:29844 all_unreclaimable? no
lowmem_reserve[]: 0 0 5119
HighMem free:896kB min:512kB low:640kB high:768kB active:179192kB inactive:466644kB present:655344kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 1*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3960kB
Normal: 0*4kB 1*8kB 1*16kB 0*32kB 0*64kB 0*128kB 2*256kB 0*512kB 1*1024kB 1*2048kB 5*4096kB = 24088kB
HighMem: 62*4kB 7*8kB 5*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 896kB
Swap cache: add 35451, delete 35184, find 371/482, race 0+0
Free swap  = 1838852kB
Total swap = 1975976kB
Out of Memory: Killed process 18330 (cat).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16

Free pages:       35628kB (832kB HighMem)
Active:51650 inactive:151150 dirty:48 writeback:112458 unstable:0 free:8907 slab:18596 mapped:45563 pagetables:830
DMA free:3996kB min:584kB low:728kB high:876kB active:0kB inactive:1108kB present:16384kB pages_scanned:1587 all_unreclaimable? yes
lowmem_reserve[]: 0 880 1519
Normal free:30800kB min:32180kB low:40224kB high:48268kB active:16732kB inactive:147212kB present:901120kB pages_scanned:342208 all_unreclaimable? yes
lowmem_reserve[]: 0 0 5119
HighMem free:832kB min:512kB low:640kB high:768kB active:189868kB inactive:456280kB present:655344kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 9*4kB 1*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3996kB
Normal: 284*4kB 696*8kB 2*16kB 0*32kB 0*64kB 0*128kB 2*256kB 0*512kB 1*1024kB 1*2048kB 5*4096kB = 30800kB
HighMem: 0*4kB 38*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 832kB
Swap cache: add 38465, delete 35875, find 1174/1602, race 0+0
Free swap  = 1837744kB
Total swap = 1975976kB
Out of Memory: Killed process 18326 (cat).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16

Free pages:       35632kB (832kB HighMem)
Active:51606 inactive:151149 dirty:48 writeback:112458 unstable:0 free:8908 slab:18596 mapped:45514 pagetables:826
DMA free:4000kB min:584kB low:728kB high:876kB active:4kB inactive:1104kB present:16384kB pages_scanned:495 all_unreclaimable? no
lowmem_reserve[]: 0 880 1519
Normal free:30800kB min:32180kB low:40224kB high:48268kB active:16732kB inactive:147212kB present:901120kB pages_scanned:342208 all_unreclaimable? yes
lowmem_reserve[]: 0 0 5119
HighMem free:832kB min:512kB low:640kB high:768kB active:189688kB inactive:456280kB present:655344kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 10*4kB 1*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4000kB
Normal: 284*4kB 696*8kB 2*16kB 0*32kB 0*64kB 0*128kB 2*256kB 0*512kB 1*1024kB 1*2048kB 5*4096kB = 30800kB
HighMem: 0*4kB 38*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 832kB
Swap cache: add 38465, delete 35875, find 1174/1602, race 0+0
Free swap  = 1837744kB
Total swap = 1975976kB
Out of Memory: Killed process 18327 (vdr).


-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

--=-4esXcHUUIwGB9Ouxdze5
Content-Disposition: attachment; filename=config.gz
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64

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


--=-4esXcHUUIwGB9Ouxdze5--

