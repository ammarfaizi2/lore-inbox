Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268901AbRHFRNs>; Mon, 6 Aug 2001 13:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268902AbRHFRNi>; Mon, 6 Aug 2001 13:13:38 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:34352
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S268901AbRHFRN0>; Mon, 6 Aug 2001 13:13:26 -0400
From: Larry McVoy <lm@bitmover.com>
Date: Mon, 6 Aug 2001 10:13:36 -0700
Message-Id: <200108061713.f76HDaj16575@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: SIS 630E perf problems?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use bookpcs - all in one, really nice form factor - for build machines,
firewalls (with a USB ethernet), etc.  I used the first generation which
had intel i810 graphics (sucked) but had fairly typical performance, 
competitive for kernel builds with other current platforms at the time.

I recently bought a couple of the second generation of these boxes, these
have an SIS 630E based motherboard.  This has a much better graphics interface,
quite reasonable at 1280x1024, and all the other bits work fine under RH 7.1
without tweaking.

Performance sucks, however.  I did an LMbench run to try and figure out why
and it's obvious - the memory latencies are 430 ns - that's 2x more than
what is reasonable.  I tweaked the various bios settings a bit and could
not get it to change much, maybe 20ns but not the 200ns I was looking for.
The fact that this system is running a celeron with a dinky cache makes it
feel really slow.  These boxes with a 633Mhz celeron feel slower than the
old boxes with a 400Mhz celeron.

All I want to know is if this is in fact the real memory latency for these
motherboards.  Anyone know for sure?

Here's what I could dig out of /proc:

PCI bus devices:
    Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 32).
    IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 208).
    ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 0).
    Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 129).
    USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 7).
    USB Controller: Silicon Integrated Systems [SiS] 7001 (#2) (rev 7).
    PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (rev 0).
    Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 16).
    Communication controller: C-Media Electronics Inc CM8738 (rev 16).
    VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D (rev 32).

