Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264452AbSIVSCO>; Sun, 22 Sep 2002 14:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264453AbSIVSCO>; Sun, 22 Sep 2002 14:02:14 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:6784 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S264452AbSIVSCN>;
	Sun, 22 Sep 2002 14:02:13 -0400
Date: Sun, 22 Sep 2002 13:07:18 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Jurriaan <thunder7@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi problems (identical) in 2.5.38 and 2.4.20-pre7-ac3:
 CoD != 0 in idescsi_pc_intr
In-Reply-To: <20020922065504.GA1009@middle.of.nowhere>
Message-ID: <Pine.LNX.4.44.0209221252490.909-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Sep 2002, Jurriaan wrote:

> selected parts of dmesg:
> 
> hdg: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
> ide-cd: passing drive hdg to ide-scsi emulation.
> scsi1 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: LITE-ON   Model: LTR-40125W        Rev: WS05
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> sr3: scsi3-mmc drive: 12x/12x writer cd/rw xa/form2 cdda tray
> 
> After writing for a while, it says:
> ide-scsi: CoD != 0 in idescsi_pc_intr
> hdg: ATAPI reset complete

I could not duplicate this error in 2.5.38-bk.

However, I did notice some other anomalies during testing.  My testing 
consisted of dd if=/dev/cdrom of=cd.iso under 2.4.18-10 and 2.5.38-bk.  I 
tried both a small mail spool (2 MB) cd and a large document cd (637 MB).  
The small file copied fine under both, but 2.5.38-bk read two fewer 
sectors than 2.4.18-10 (32404 vs. 32406).  On disk, the files created 
were:

-rw-r--r--    1 root     root     668475392 Sep 22 12:01 cd2.iso
-rw-r--r--    1 root     root     668479488 Sep 22 11:51 cd.iso

from the same source cd.

