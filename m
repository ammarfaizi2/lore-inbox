Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135460AbRDMJ6u>; Fri, 13 Apr 2001 05:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135459AbRDMJ6b>; Fri, 13 Apr 2001 05:58:31 -0400
Received: from netlab-83.netlab.is.tsukuba.ac.jp ([130.158.83.243]:16132 "HELO
	pixy.netlab.is.tsukuba.ac.jp") by vger.kernel.org with SMTP
	id <S135458AbRDMJ60>; Fri, 13 Apr 2001 05:58:26 -0400
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Can't mount 2048 hardware sectors SCSI disk
X-Mailer: Mew version 1.94.1 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010413185816C.yokota@netlab.is.tsukuba.ac.jp>
Date: Fri, 13 Apr 2001 18:58:16 +0900
From: Yokota Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem: Can't mount 2048 hardware sectors SCSI disk on 2.4 kernel.

[2.] Full description of the problem/report:
 I have SCSI optical disk drive. It's supports 512 and 2048 bytes hardware
sectors media.


 In 2.2.19 kernel, I can use both 512/2048 hardware sectors media.

 In 2.4.3 kernel, I can mount 512 bytes hardware sector media correctly, 
but I can't mount MSDOS/VFAT/UMSDOS/HFS filesystem in 2048 bytes hardware
sectors media (reports "wrong fs type"). But I can use dd/mtools/hfstools
correctory .


 I tested "Workbit NinjaSCSI-3" and "Adaptec APA-1480" SCSI host adapter.
Both of them reports same error.


 I turns on "CONFIG_SCSI_LOGGING" option to debug.

 Log reports SCSI disk driver (linux/drivers/scsi/sd.c) wants to read
non-existant sector. (set very big sector number to SCSI packet)

 I think something wrong in SCSI driver or filesystem driver in 2.4 kernel.

[3.] Keywords (i.e., modules, networking, kernel): SCSI disk

[4.] Kernel version (from /proc/version): 2.4.3


---
YOKOTA Hiroshi
E-mail: yokota@netlab.is.tsukuba.ac.jp
WWW:    http://www.netlab.is.tsukuba.ac.jp/~yokota/
