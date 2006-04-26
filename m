Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWDZPbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWDZPbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWDZPbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:31:42 -0400
Received: from ntwklan-62-233-162-146.devs.futuro.pl ([62.233.162.146]:48887
	"EHLO mail.softwaremind.pl") by vger.kernel.org with ESMTP
	id S932479AbWDZPbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:31:41 -0400
From: Marcin Hlybin <marcin.hlybin@swmind.com>
To: linux-kernel@vger.kernel.org
Subject: 3ware 8006-2LP on Linux 2.6 drive error, seagate disks
Date: Wed, 26 Apr 2006 17:32:31 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261732.31327.marcin.hlybin@swmind.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Recently I've come across a lot of problems with 3ware controller on Linux 
2.6.15.4. Everything is in the Thomas-Krenn SR2400 server running on Debian.

3WARE DEVICE:
driver: 1.26.02.001
model: 8006-2LP
firmware: FE8S 1.05.00.068
bios: BE7X 1.08.00.048

DISKS:
2x Seagate ST3300831AS SATA 300GB

I used tw_cli (AMCC/3ware CLI (version 2.00.03.013)) to create RAID1 unit. 
After running cfdisk raid degraded and it can't be rebuilded. 
Next I tried to make JBOD units for testing. A 3ware driver was compiled into 
the kernel and also as a module. 

ERRORS:
Apr 26 15:07:10 krenn kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, 
flags = 0xc, unit #0.
Apr 26 15:07:14 krenn kernel: 3w-xxxx: scsi2: AEN: ERROR: Drive error: Port 
#0.
Apr 26 15:07:15 krenn kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, 
flags = 0xc, unit #0.
Apr 26 15:07:20 krenn kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, 
flags = 0xc, unit #0.
Apr 26 15:07:25 krenn kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, 
flags = 0xc, unit #0.
Apr 26 15:07:30 krenn kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, 
flags = 0xc, unit #0.
Apr 26 15:07:35 krenn kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, 
flags = 0xc, unit #0.
Apr 26 15:07:38 krenn kernel: sd 2:0:0:0: WARNING: Command (0x28) timed out, 
resetting card.

It looks like some incompatibility with driver. Cables and disks are new, no 
badblocks. Tommorow I will try to compile driver from 3ware website with 2.4 
kernel. 

Thanks in advance. 

-- 
 Marcin Hlybin, marcin.hlybin@swmind.com
 Sys/Net Administrator, tel. +48 12 2523 402

 SoftwareMind, www.softwaremind.pl | Where quality meets the future
