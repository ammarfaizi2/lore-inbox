Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317797AbSGVUlE>; Mon, 22 Jul 2002 16:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317806AbSGVUlE>; Mon, 22 Jul 2002 16:41:04 -0400
Received: from phobos.hpl.hp.com ([192.6.19.124]:50927 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317797AbSGVUlC>;
	Mon, 22 Jul 2002 16:41:02 -0400
Date: Mon, 22 Jul 2002 13:44:09 -0700
From: Christopher Hoover <ch@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: ch@murgatroid.com
Subject: [PATCH] 2.5.24+ Exports needed for modular IDE build
Message-ID: <20020722134409.A11556@friction.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.5.24-rmk1/drivers/ide/device.c	Thu Jun 20 15:53:50 2002
+++ linux-2.5.24-rmk1-ch2/drivers/ide/device.c	Fri Jul 12 14:28:05 2002
@@ -79,6 +79,8 @@
 		ch->maskproc(drive);
 }
 
+EXPORT_SYMBOL(ata_mask);
+
 /*
  * Spin until the drive is no longer busy.
  *
@@ -231,6 +233,8 @@
 	OUT_BYTE(rf->low_cylinder, ch->io_ports[IDE_LCYL_OFFSET]);
 	OUT_BYTE(rf->high_cylinder, ch->io_ports[IDE_HCYL_OFFSET]);
 }
+
+EXPORT_SYMBOL(ata_out_regfile);
 
 /*
  * Input a complete register file.
