Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130721AbRCTSlX>; Tue, 20 Mar 2001 13:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130733AbRCTSlN>; Tue, 20 Mar 2001 13:41:13 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:14603
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130721AbRCTSk6>; Tue, 20 Mar 2001 13:40:58 -0500
Date: Tue, 20 Mar 2001 10:39:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: William Park <parkw@better.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA686B + 2.2.18 (was: VIA686A chipset crash under 2.4.2-ac20)
In-Reply-To: <20010316145030.A7907@better.net>
Message-ID: <Pine.LNX.4.10.10103200924550.27372-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, William Park wrote:

> I'm running 2.2.18 on VIA686B (ABit VP6).  Some time ago, you mentioned
> that you got ~80Mb/s from 'hdparm -t /dev/hda'.  Please tell us how?
> Which hdparm/kernel options did you enable?

Nope not w/ 'hdparm' with DiskPerf and correcting for CR3's on memcpy's.

[root@via DiskPerf-1.0.3]# ./DiskPerf /dev/hda
Device: IBM-DTLA-307030 Serial Number: YKDYKM37674
LBA 0 DMA Read Test                      = 56.62 MB/Sec (4.42 Seconds)
Outer Diameter Sequential DMA Read Test  = 35.46 MB/Sec (7.05 Seconds)
Inner Diameter Sequential DMA Read Test  = 17.72 MB/Sec (14.10 Seconds)

When you adjust for memory delays (of 35-40%) then you get those number.
and those numbers are valid inside for kernel-kernel access, not
kernel-user-space.

Cheers,

Andre Hedrick
Linux ATA Development


