Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUCVMx1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 07:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbUCVMx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 07:53:27 -0500
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:32342 "EHLO
	nebula.ghetto") by vger.kernel.org with ESMTP id S261920AbUCVMxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 07:53:23 -0500
Date: Mon, 22 Mar 2004 13:53:05 +0100
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.5-rc1-mm1
Message-ID: <20040322125305.GA2306@larroy.com>
Reply-To: piotr@larroy.com
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20040316015338.39e2c48e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316015338.39e2c48e.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I think I have an abnormal memory situation, seems all my ram got exhausted
and I don't see it used by userland processes.


top - 13:48:59 up  9:50,  1 user,  load average: 0.25, 1.26, 1.64
Tasks: 112 total,   1 running, 111 sleeping,   0 stopped,   0 zombie
 Cpu0 :  0.0% us,  0.0% sy,  0.0% ni, 99.0% id,  1.0% wa,  0.0% hi,  0.0%
si
 Cpu1 :  0.0% us,  1.0% sy,  0.0% ni, 99.0% id,  0.0% wa,  0.0% hi,  0.0%
si
Mem:   1036272k total,  1029316k used,     6956k free,      176k buffers
Swap:  1183688k total,    74740k used,  1108948k free,    87116k cached
Change delay from 1.0 to:
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  823 piotr     15   0 26648 4232  23m S  0.0  0.4   0:45.21 kdeinit
  813 piotr     15   0 26472 2784  23m S  0.0  0.3   0:15.21 kdeinit
  817 piotr     16   0 24744 2428  21m S  0.0  0.2   0:03.13 kdeinit
  809 piotr     15   0 24408 2372  21m S  0.0  0.2   0:02.78 kdeinit
  693 root      15   0 92692 2288  79m S  0.0  0.2   1:10.60 XFree86


Mar 22 13:36:57 nebula kernel: SysRq : Show Memory
Mar 22 13:36:57 nebula kernel: Mem-info:
Mar 22 13:36:57 nebula kernel: DMA per-cpu:
Mar 22 13:36:57 nebula kernel: cpu 0 hot: low 2, high 6, batch 1
Mar 22 13:36:57 nebula kernel: cpu 0 cold: low 0, high 2, batch 1
Mar 22 13:36:57 nebula kernel: cpu 1 hot: low 2, high 6, batch 1
Mar 22 13:36:57 nebula kernel: cpu 1 cold: low 0, high 2, batch 1
Mar 22 13:36:57 nebula kernel: Normal per-cpu:
Mar 22 13:36:57 nebula kernel: cpu 0 hot: low 32, high 96, batch 16
Mar 22 13:36:57 nebula kernel: cpu 0 cold: low 0, high 32, batch 16
Mar 22 13:36:57 nebula kernel: cpu 1 hot: low 32, high 96, batch 16
Mar 22 13:36:57 nebula kernel: cpu 1 cold: low 0, high 32, batch 16
Mar 22 13:36:57 nebula kernel: HighMem per-cpu:
Mar 22 13:36:57 nebula kernel: cpu 0 hot: low 14, high 42, batch 7
Mar 22 13:36:57 nebula kernel: cpu 0 cold: low 0, high 14, batch 7
Mar 22 13:36:57 nebula kernel: cpu 1 hot: low 14, high 42, batch 7
Mar 22 13:36:57 nebula kernel: cpu 1 cold: low 0, high 14, batch 7
Mar 22 13:36:57 nebula kernel:
Mar 22 13:36:57 nebula kernel: Free pages:        4660kB (252kB HighMem)
Mar 22 13:36:57 nebula kernel: Active:239794 inactive:6995 dirty:0
writeback:0 unstable:0 free:1165
Mar 22 13:36:57 nebula kernel: DMA free:2160kB min:16kB low:32kB high:48kB
active:20kB inactive:10856kB present:16384kB
Mar 22 13:36:57 nebula kernel: protections[]: 8 476 540
Mar 22 13:36:57 nebula kernel: Normal free:2248kB min:936kB low:1872kB
high:2808kB active:834960kB inactive:12712kB present:
901120kB
Mar 22 13:36:57 nebula kernel: protections[]: 0 468 532
Mar 22 13:36:57 nebula kernel: HighMem free:252kB min:128kB low:256kB
high:384kB active:124196kB inactive:4412kB present:130
560kB
Mar 22 13:36:57 nebula kernel: protections[]: 0 0 64
Mar 22 13:36:57 nebula kernel: DMA: 0*4kB 0*8kB 5*16kB 1*32kB 0*64kB
0*128kB 0*256kB 0*512kB 0*1024kB 1*2048kB 0*4096kB = 21
60kB
Mar 22 13:36:57 nebula kernel: Normal: 10*4kB 12*8kB 8*16kB 4*32kB 1*64kB
0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB
 = 2248kB
Mar 22 13:36:57 nebula kernel: HighMem: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB
1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB
= 252kB
Mar 22 13:36:57 nebula kernel: Swap cache: add 5092465, delete 5088319,
find 1479790/3420811, race 3+141
Mar 22 13:36:57 nebula kernel: Free swap:       1087816kB
Mar 22 13:36:57 nebula kernel: 262016 pages of RAM
Mar 22 13:36:57 nebula kernel: 32624 pages of HIGHMEM
Mar 22 13:36:57 nebula kernel: 2965 reserved pages
Mar 22 13:36:57 nebula kernel: 28380 pages shared
Mar 22 13:36:57 nebula kernel: 4146 pages swap cached


procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
wa
 0  1  74600   4580    476  88172  292   58   449    90   17   165  2  3 49
45

It's with
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y


Where would kernel leaked ram be accounted?

Regards.
-- 
Pedro Larroy Tovar | Linux & Network consultant |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
