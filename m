Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbTAKGVT>; Sat, 11 Jan 2003 01:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbTAKGVT>; Sat, 11 Jan 2003 01:21:19 -0500
Received: from mail.mediaways.net ([193.189.224.113]:5596 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S267097AbTAKGVR>; Sat, 11 Jan 2003 01:21:17 -0500
Subject: choice of raid5 checksumming algorithm wrong ?
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042266405.14440.54.camel@sun>
Mime-Version: 1.0
Date: 11 Jan 2003 07:26:45 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I really do wonder whether the displayed message is wrong or why it
always chooses the slowest checksumming function (happens with 2.4.19 -
21pre3)

2.4.20:
Jan  7 18:32:22 sun kernel: raid5: measuring checksumming speed
Jan  7 18:32:22 sun kernel: 8regs     :  3054.400 MB/sec
Jan  7 18:32:22 sun kernel: 32regs    :  2696.800 MB/sec
Jan  7 18:32:22 sun kernel: pIII_sse  :  1614.000 MB/sec
Jan  7 18:32:22 sun kernel: pII_mmx   :  4672.000 MB/sec
Jan  7 18:32:22 sun kernel: p5_mmx    :  5984.000 MB/sec
Jan  7 18:32:22 sun kernel: raid5: using function: pIII_sse (1614.000 MB/sec)

21pre2:
Jan  5 19:18:47 sun kernel: raid5: measuring checksumming speed
Jan  5 19:18:47 sun kernel: 8regs     :  3054.000 MB/sec
Jan  5 19:18:47 sun kernel: 32regs    :  2697.200 MB/sec
Jan  5 19:18:47 sun kernel: pIII_sse  :  2574.000 MB/sec
Jan  5 19:18:47 sun kernel: pII_mmx   :  4671.600 MB/sec
Jan  5 19:18:47 sun kernel: p5_mmx    :  5984.000 MB/sec
Jan  5 19:18:47 sun kernel: raid5: using function: pIII_sse (2574.000 MB/sec)
Jan  5 19:18:47 sun kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27


21pre3:
Jan  7 21:38:12 sun kernel: raid5: measuring checksumming speed
Jan  7 21:38:12 sun kernel: 8regs     :  3055.200 MB/sec
Jan  7 21:38:12 sun kernel: 32regs    :  2697.200 MB/sec
Jan  7 21:38:12 sun kernel: pIII_sse  :  5658.400 MB/sec
Jan  7 21:38:12 sun kernel: pII_mmx   :  4672.400 MB/sec
Jan  7 21:38:12 sun kernel: p5_mmx    :  5984.800 MB/sec
Jan  7 21:38:12 sun kernel: raid5: using function: pIII_sse (5658.400 MB/sec)

it is always the same system...athlon xp2.4+...
Soeren.

