Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265826AbUAKLQM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 06:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbUAKLQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 06:16:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57355 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265826AbUAKLQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 06:16:11 -0500
Date: Sun, 11 Jan 2004 11:16:07 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] mark ide-cs broken
Message-ID: <20040111111607.A1931@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After receiving this bug report: http://bugme.osdl.org/show_bug.cgi?id=1457
and talking to Arjan, it would appear that IDECS is known to be broken.
Arjan has confirmed that he sees the same behaviour with his PCMCIA CDROM
using both 2.6 and 2.4.2x kernels.

Therefore, I suggest that we mark it broken.  The patch below is for 2.6.1
kernels.

If anyone wants to know the details of why it's broken, please don't mail
me - I don't know - the best I can do is refer you to the above URL.

As far as bug 1457 goes - I'll reassign it to "Drivers - Other" later today
since we don't have an IDE component in bugme.

--- orig/drivers/ide/Kconfig	Fri Jan  9 22:39:21 2004
+++ linux/drivers/ide/Kconfig	Sun Jan 11 11:00:11 2004
@@ -173,7 +173,7 @@
 
 config BLK_DEV_IDECS
 	tristate "PCMCIA IDE support"
-	depends on PCMCIA
+	depends on PCMCIA && BROKEN
 	help
 	  Support for outboard IDE disks, tape drives, and CD-ROM drives
 	  connected through a  PCMCIA card.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
