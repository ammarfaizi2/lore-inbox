Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWIUR4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWIUR4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 13:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWIUR4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 13:56:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27615 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751402AbWIUR4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 13:56:21 -0400
Date: Thu, 21 Sep 2006 10:56:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, f1@vcc.de
Cc: "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>
Subject: Re: [Bugme-new] [Bug 7177] New: Mylex DAC960 driver is not working
 with Kernel newer than 2.6.11 !
Message-Id: <20060921105612.ff8c54f0.akpm@osdl.org>
In-Reply-To: <200609211508.k8LF8qAY029812@fire-2.osdl.org>
References: <200609211508.k8LF8qAY029812@fire-2.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 08:08:52 -0700
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=7177

Is anyone else out there using dac960 on recentish kernels?

>            Summary: Mylex DAC960 driver is not working with Kernel newer
>                     than 2.6.11 !
>     Kernel Version: >2.6.11
>             Status: NEW
>           Severity: blocking
>              Owner: scsi_drivers-other@kernel-bugs.osdl.org
>          Submitter: f1@vcc.de
> 
> 
> Most recent kernel where this bug did not occur: 2.6.18
> Distribution: gentoo
> Hardware Environment: SIEMENS Model: STM/L Quad Xeon P3 500MHz 2GIG Ram
> Software Environment: 
> Problem Description:
> drivers/block/DAC960.c
> Steps to reproduce: Just reboot with kernel newer than 2.6.11 eg 2.6.18
> 
> ...
> FDC 0 is a National Semiconductor PC87306
> loop: loaded (max 8 devices)
> DAC960: ***** DAC960 RAID Driver Version 2.5.48 of 14 May 2006 *****
> DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
> 
> and here the kernel stops and nothing happends !
> 
> under 2.6.11 the output is much longer:
> 
> ...
> FDC 0 is a National Semiconductor PC87306
> loop: loaded (max 8 devices)
> DAC960: ***** DAC960 RAID Driver Version 2.5.47 of 14 November 2002 *****
> DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
> DAC960#0: Configuring Mylex DAC960PJ PCI RAID Controller
> DAC960#0:   Firmware Version: 4.08-0-37, Channels: 3, Memory Size: 64MB
> DAC960#0:   PCI Bus: 3, Device: 13, Function: 1, I/O Address: Unassigned
> DAC960#0:   PCI Address: 0xFE600000 mapped at 0xF8810000, IRQ Channel: 161
> DAC960#0:   Controller Queue Depth: 124, Maximum Blocks per Command: 128
> DAC960#0:   Driver Queue Depth: 123, Scatter/Gather Limit: 33 of 33 Segments
> DAC960#0:   Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 255/63
> DAC960#0:   SAF-TE Enclosure Management Enabled
> DAC960#0:   Physical Devices:
> DAC960#0:     0:0  Vendor: SEAGATE   Model: ST39102LC         Revision: 7505
> DAC960#0:          Serial Number: LJ46608500002910J0LZ
> DAC960#0:          Disk Status: Standby, 17782784 blocks
> DAC960#0:     0:1  Vendor: SEAGATE   Model: ST39102LC         Revision: 7503
> DAC960#0:          Serial Number: LJL1072800002938HQ5K
> DAC960#0:          Disk Status: Online, 17780736 blocks
> DAC960#0:     0:2  Vendor: SEAGATE   Model: ST39102LC         Revision: 7503
> DAC960#0:          Serial Number: LV263431000010091BE1
> DAC960#0:          Disk Status: Online, 17780736 blocks
> DAC960#0:     0:3  Vendor: SEAGATE   Model: ST39102LC         Revision: 7503
> DAC960#0:          Serial Number: LJL04413000019400HC3
> DAC960#0:          Disk Status: Online, 17780736 blocks
> DAC960#0:     0:8  Vendor: SIEMENS   Model: STM/L S1          Revision: 4.1b
> DAC960#0:     1:0  Vendor: SEAGATE   Model: ST39102LC         Revision: 7503
> DAC960#0:          Serial Number: LJK896890000194006WC
> DAC960#0:          Disk Status: Online, 17780736 blocks
> DAC960#0:     1:1  Vendor: SEAGATE   Model: ST39173LC         Revision: 6246
> DAC960#0:          Serial Number: LM90387100001834F0GP
> DAC960#0:          Disk Status: Online, 17780736 blocks
> DAC960#0:     1:2  Vendor: SEAGATE   Model: ST39102LC         Revision: 7503
> DAC960#0:          Serial Number: LJL0800100002938K4D8
> DAC960#0:          Disk Status: Online, 17780736 blocks
> DAC960#0:     1:3  Vendor: SEAGATE   Model: ST39102LC         Revision: 7505
> DAC960#0:          Serial Number: LJM15325000019220JG2
> DAC960#0:          Disk Status: Online, 17780736 blocks
> DAC960#0:     1:8  Vendor: SIEMENS   Model: STM/L S2          Revision: 4.1b
> DAC960#0:   Logical Drives:
> DAC960#0:     /dev/rd/c0d0: RAID-5, Online, 106659840 blocks, Write Thru
>  /dev/rd/host0/target0: p1 p2 p3
> e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
> e100: Copyright(c) 1999-2004 Intel Corporation
> ...
> 
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug, or are watching someone who is.
