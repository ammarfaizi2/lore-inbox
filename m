Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTH2Rjs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTH2Rjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:39:48 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:44768 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S261797AbTH2Rjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:39:45 -0400
Date: Fri, 29 Aug 2003 10:39:43 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030829103943.A18608@home.com>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>; from jamie@shareable.org on Fri, Aug 29, 2003 at 06:35:10AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 06:35:10AM +0100, Jamie Lokier wrote:
> Anyway, please lots of people run the program and post the output +
> /proc/cpuinfo.  Compile with optimisation, -O or -O2 is fine.  (You
> can add -DHAVE_SYSV_SHM too if you like):
> 
> 	gcc -o test test.c -O2
> 	time ./test
> 	cat /proc/cpuinfo

PPC440GX, non cache coherent, L1 icache is VTPI, L1 dcache is PTPI

-----

440gx-1:~/cachetest# gcc -o test test.c -O2
440gx-1:~/cachetest# time ./test
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

real	0m0.193s
user	0m0.140s
sys	0m0.010s
440gx-1:~/cachetest# cat /proc/cpuinfo
cpu		: 440GX Rev. A
revision	: 24.80 (pvr 51b2 1850)
bogomips	: 624.23
vendor		: IBM
machine		: PPC440GX EVB (Ocotea)
440gx-1:~/cachetest# 

-- 
Matt Porter
mporter@kernel.crashing.org
