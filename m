Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTH2Q17 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbTH2Q16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:27:58 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:699 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261427AbTH2Q1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:27:52 -0400
Date: Fri, 29 Aug 2003 18:27:49 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>
Message-ID: <Pine.GSO.4.21.0308291820540.3919-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Aug 2003, Jamie Lokier wrote:
> I'd appreciate if folks would run the program below on various
> machines, especially those whose caches aren't automatically coherent
> at the hardware level.

Are you also interested in m68k? ;-)

cassandra:/tmp# time ./test
Test separation: 4096 bytes: FAIL - store buffer not coherent
Test separation: 8192 bytes: FAIL - store buffer not coherent
Test separation: 16384 bytes: FAIL - store buffer not coherent
Test separation: 32768 bytes: FAIL - store buffer not coherent
Test separation: 65536 bytes: FAIL - store buffer not coherent
Test separation: 131072 bytes: FAIL - store buffer not coherent
Test separation: 262144 bytes: FAIL - store buffer not coherent
Test separation: 524288 bytes: FAIL - store buffer not coherent
Test separation: 1048576 bytes: FAIL - store buffer not coherent
Test separation: 2097152 bytes: FAIL - store buffer not coherent
Test separation: 4194304 bytes: FAIL - store buffer not coherent
Test separation: 8388608 bytes: FAIL - store buffer not coherent
Test separation: 16777216 bytes: FAIL - store buffer not coherent
VM page alias coherency test: failed; will use copy buffers instead

real	0m0.478s
user	0m0.110s
sys	0m0.190s
cassandra:/tmp# cat /proc/cpuinfo 
CPU:		68040
MMU:		68040
FPU:		68040
Clocking:	24.8MHz
BogoMips:	16.53
Calibration:	82688 loops
cassandra:/tmp# 


callisto$ time ./test
Test separation: 4096 bytes: pass
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

real	0m0.329s
user	0m0.270s
sys	0m0.050s
callisto$ cat /proc/cpuinfo 
cpu		: 604r
clock		: 200MHz
revision	: 18.3 (pvr 0009 1203)
bogomips	: 398.13
machine		: CHRP IBM,LongTrail-2
memory bank 0	: 32 MB SDRAM
memory bank 1	: 32 MB SDRAM
memory bank 2	: 32 MB SDRAM
memory bank 3	: 32 MB SDRAM
board l2	: 512 KB Pipelined Synchronous (Write-Through)
callisto$

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

