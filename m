Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135897AbRDZT02>; Thu, 26 Apr 2001 15:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135899AbRDZT0Q>; Thu, 26 Apr 2001 15:26:16 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:8462 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135897AbRDZT0M>; Thu, 26 Apr 2001 15:26:12 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200104261925.VAA15706@green.mif.pg.gda.pl>
Subject: [PATCH] SysRq
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 26 Apr 2001 21:25:23 +0200 (CEST)
Cc: andre@suse.com (Andre M. Hedrick),
        linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   The following patch add more disk devices to the SysRq sync list (in both:
-pre and -ac trees). Were the extra IDE devices intentionally omitted here?

BTW, it would be probably nice to add some mon-x86 disk devices here...

Andrzej

diff -uNr drivers/char/sysrq.c~ drivers/char/sysrq.c
--- drivers/char/sysrq.c~	Sun Apr 22 14:48:18 2001
+++ drivers/char/sysrq.c	Wed Apr 25 02:36:12 2001
@@ -114,6 +114,12 @@
 	case IDE1_MAJOR:
 	case IDE2_MAJOR:
 	case IDE3_MAJOR:
+	case IDE4_MAJOR:
+	case IDE5_MAJOR:
+	case IDE6_MAJOR:
+	case IDE7_MAJOR:
+	case IDE8_MAJOR:
+	case IDE9_MAJOR:
 	case SCSI_DISK0_MAJOR:
 	case SCSI_DISK1_MAJOR:
 	case SCSI_DISK2_MAJOR:
@@ -122,6 +128,7 @@
 	case SCSI_DISK5_MAJOR:
 	case SCSI_DISK6_MAJOR:
 	case SCSI_DISK7_MAJOR:
+	case XT_DISK_MAJOR:
 		return 1;
 	default:
 		return 0;


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
