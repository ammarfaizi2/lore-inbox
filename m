Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSFIU7c>; Sun, 9 Jun 2002 16:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSFIU7b>; Sun, 9 Jun 2002 16:59:31 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:53232 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S315200AbSFIU7a>; Sun, 9 Jun 2002 16:59:30 -0400
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200206092059.g59KxUAf000925@twopit.underworld>
Subject: [SysRq-M] Memory error in 2.4.19-pre9-ac3
To: linux-kernel@vger.kernel.org
Date: Sun, 9 Jun 2002 21:59:30 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running 2.4.19-pre9-ac3 on a dual PIII (SMP, 1.25 GB memory,
devfs, ext3, ALSA-CVS, lm-sensors-2.6.3) and I am getting memory
errors after a few days of uptime. This error has happened after only
4 days, for example. I have managed to obtain "SysRq-M" output before
the box had a chance to oops or crash, but I don't know how useful
this might be. Does anyone have any other suggestions for tracking
this problem down? I am already compiling with CONFIG_DEBUG_HIGHMEM.

Cheers,
Chris

Jun  9 19:59:27 twopit kernel: Trying to vfree() nonexistent vm area (f8872000)
Jun  9 20:27:31 twopit kernel: SysRq : Show Memory
Jun  9 20:27:31 twopit kernel: Mem-info:
Jun  9 20:27:31 twopit kernel: Free pages:      140936kB (  2272kB HighMem)
Jun  9 20:27:31 twopit kernel: Zone:DMA freepages: 13552kB min:  4224kB low:  4352kB high:  4480kB
Jun  9 20:27:31 twopit kernel: Zone:Normal freepages:125112kB min:  3576kB low: 16636kB high: 23676kB
Jun  9 20:27:31 twopit kernel: Zone:HighMem freepages:  2272kB min:  1020kB low:  6136kB high:  9204kB
Jun  9 20:27:31 twopit kernel: Free pages:      140936kB (  2272kB HighMem)
Jun  9 20:27:31 twopit kernel: ( Active: 94312, inactive_dirty: 167988, inactive_clean: 4989, free: 35234 )
Jun  9 20:27:31 twopit kernel: 100*4kB 98*8kB 89*16kB 62*32kB 32*64kB 12*128kB 1*256kB 0*512kB 1*1024kB 2*2048kB = 13552kB)
Jun  9 20:27:31 twopit kernel: 1038*4kB 1158*8kB 317*16kB 214*32kB 133*64kB 83*128kB 27*256kB 24*512kB 14*1024kB 23*2048kB = 125112kB)
Jun  9 20:27:31 twopit kernel: 16*4kB 94*8kB 15*16kB 2*32kB 2*64kB 2*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 2272kB)
Jun  9 20:27:31 twopit kernel: Swap cache: add 0, delete 0, find 0/0, race 0+0
Jun  9 20:27:31 twopit kernel: Free swap:       498004kB
Jun  9 20:27:31 twopit kernel: 327648 pages of RAM
Jun  9 20:27:31 twopit kernel: 98272 pages of HIGHMEM
Jun  9 20:27:31 twopit kernel: 5096 reserved pages
Jun  9 20:27:31 twopit kernel: 244072 pages shared
Jun  9 20:27:31 twopit kernel: 0 pages swap cached
Jun  9 20:27:31 twopit kernel: 0 pages in page table cache
Jun  9 20:27:31 twopit kernel: Buffer memory:    62560kB
Jun  9 20:27:31 twopit kernel: Cache memory:   877552kB
Jun  9 20:27:31 twopit kernel:     CLEAN: 182972 buffers, 731888 kbyte, 184 used (last=182969), 0 locked, 0 dirty
Jun  9 20:27:31 twopit kernel:     DIRTY: 4 buffers, 16 kbyte, 4 used (last=4), 0 locked, 4 dirty

Jun  9 20:28:52 twopit kernel: SysRq : Show Memory
Jun  9 20:28:52 twopit kernel: Mem-info:
Jun  9 20:28:52 twopit kernel: Free pages:      216512kB ( 67528kB HighMem)
Jun  9 20:28:52 twopit kernel: Zone:DMA freepages: 13552kB min:  4224kB low:  4352kB high:  4480kB
Jun  9 20:28:52 twopit kernel: Zone:Normal freepages:135432kB min:  3576kB low: 16636kB high: 23676kB
Jun  9 20:28:52 twopit kernel: Zone:HighMem freepages: 67528kB min:  1020kB low:  6136kB high:  9204kB
Jun  9 20:28:52 twopit kernel: Free pages:      216512kB ( 67528kB HighMem)
Jun  9 20:28:52 twopit kernel: ( Active: 77325, inactive_dirty: 167921, inactive_clean: 3476, free: 54128 )
Jun  9 20:28:52 twopit kernel: 100*4kB 98*8kB 89*16kB 62*32kB 32*64kB 12*128kB 1*256kB 0*512kB 1*1024kB 2*2048kB = 13552kB)
Jun  9 20:28:52 twopit kernel: 2*4kB 1034*8kB 521*16kB 219*32kB 133*64kB 87*128kB 28*256kB 26*512kB 16*1024kB 27*2048kB = 135432kB)
Jun  9 20:28:52 twopit kernel: 1562*4kB 1872*8kB 786*16kB 298*32kB 126*64kB 44*128kB 19*256kB 9*512kB 1*1024kB 0*2048kB = 67528kB)
Jun  9 20:28:52 twopit kernel: Swap cache: add 0, delete 0, find 0/0, race 0+0
Jun  9 20:28:52 twopit kernel: Free swap:       498004kB
Jun  9 20:28:52 twopit kernel: 327648 pages of RAM
Jun  9 20:28:52 twopit kernel: 98272 pages of HIGHMEM
Jun  9 20:28:52 twopit kernel: 5096 reserved pages
Jun  9 20:28:52 twopit kernel: 229908 pages shared
Jun  9 20:28:52 twopit kernel: 0 pages swap cached
Jun  9 20:28:52 twopit kernel: 0 pages in page table cache
Jun  9 20:28:52 twopit kernel: Buffer memory:    62572kB
Jun  9 20:28:52 twopit kernel: Cache memory:   876624kB
Jun  9 20:28:52 twopit kernel:     CLEAN: 182906 buffers, 731624 kbyte, 179 used (last=182847), 0 locked, 0 dirty
Jun  9 20:28:52 twopit kernel:     DIRTY: 13 buffers, 52 kbyte, 8 used (last=11), 0 locked, 13 dirty
