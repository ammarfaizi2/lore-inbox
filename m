Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbTEEOUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTEEOUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:20:11 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:25793 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262266AbTEEOUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:20:03 -0400
Subject: 2.5.68-mm4 broke ide cdrw
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1052145150.2349.6.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 May 2003 10:32:30 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am unable to record a cd in 2.5.68-mm4 and 2.5.69-mm1 but it works in
2.5.68-mm2 and 2.5.69. So it might have broken in -mm3 but I did not try
it. I am also backing out the dev_t from the -mm kernels. The problem is
cdrecord is unable to find the drive or at least a 'cdrecord
-dev=/dev/hdc -inq' hangs for a while and then only comes up with some
other, 'FAKE' ide drive, that doesn't work. This is using cdrecord
version 2.0 on a UP x86 box with preempt.

ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
hdc: LG CD-RW CED-8120B, ATAPI CD/DVD-ROM drive
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA

and it is plugged in here..

VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1

2.5.68-mm4: (Not working)   
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Using libscg version 'schily-0.7'
Device type    : Disk
Version        : 2
Response Format: 2
Capabilities   : 
Vendor_info    : 'ADAPTEC '
Identifikation : 'ACB-5500        '
Revision       : 'FAKE'
Device seems to be: Adaptec 5500.

2.5.68-mm2 (Working)
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Using libscg version 'schily-0.7'
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : 
Vendor_info    : 'LG      '
Identifikation : 'CD-RW CED-8120B '
Revision       : '1.03'
Device seems to be: Generic mmc CD-RW.

I tried a few different versions of cdrtools, and they were the same.

Regards,

Shane






