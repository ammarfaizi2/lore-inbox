Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTARIDc>; Sat, 18 Jan 2003 03:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbTARIDc>; Sat, 18 Jan 2003 03:03:32 -0500
Received: from franka.aracnet.com ([216.99.193.44]:31620 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263321AbTARIDb>; Sat, 18 Jan 2003 03:03:31 -0500
Date: Sat, 18 Jan 2003 00:12:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <420180000.1042877550@titus>
In-Reply-To: <20030118070808.GA789@holomorphy.com>
References: <200301171535.21226.efocht@ess.nec.de> <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain> <20030118070808.GA789@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> agreed, i've attached the -B0 patch that does this. The balancing rates
>> are 1 msec, 2 msec, 200 and 400 msec (idle-local, idle-global, busy-local,
>> busy-global).
> 
> I suspect some of these results may be off on NUMA-Q (or any PAE box)
> if CONFIG_MTRR was enabled. Michael, Martin, please doublecheck
> /proc/mtrr and whether CONFIG_MTRR=y. If you didn't enable it, or if
> you compile times aren't on the order of 5-10 minutes, you're unaffected.
> 
> The severity of the MTRR regression in 2.5.59 is apparent from:
> $ cat /proc/mtrr
> reg00: base=0xc0000000 (3072MB), size=1024MB: uncachable, count=1
> reg01: base=0x00000000 (   0MB), size=4096MB: write-back, count=1

Works for me, I have MTRR on.

larry:~# cat /proc/mtrr
reg00: base=0xe0000000 (3584MB), size= 512MB: uncachable, count=1
reg01: base=0x00000000 (   0MB), size=16384MB: write-back, count=1


