Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTH2Lv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 07:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTH2Lv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 07:51:58 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:15118 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S264540AbTH2Lvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 07:51:47 -0400
Date: Fri, 29 Aug 2003 21:51:30 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>
Message-ID: <Mutt.LNX.4.44.0308292149060.29499-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the result for sparc64 (Ultrasparc II):

$ gcc -o test test.c -O2
$ time ./test
Test separation: 8192 bytes: FAIL - cache not coherent
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
VM page alias coherency test: minimum fast spacing: 16384 (2 pages)

real    0m0.194s
user    0m0.160s
sys     0m0.040s
$ gcc -o test test.c -O2 -DHAVE_SYSV_SHM
$ time ./test
Test separation: 8192 bytes: FAIL - cache not coherent
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
VM page alias coherency test: minimum fast spacing: 16384 (2 pages)

real    0m0.162s
user    0m0.140s
sys     0m0.020s

$ cat /proc/cpuinfo

cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU
promlib         : Version 3 Revision 23
prom            : 3.23.1
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
Cpu0Bogo        : 591.46
Cpu0ClkTck      : 0000000011a4f2ed
Cpu2Bogo        : 591.46
Cpu2ClkTck      : 0000000011a4f2ed
MMU Type        : Spitfire
State:
CPU0:           online
CPU2:           online



-- 
James Morris
<jmorris@intercode.com.au>

