Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbUKSTer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbUKSTer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 14:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUKSTeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 14:34:10 -0500
Received: from sd291.sivit.org ([194.146.225.122]:15015 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261550AbUKSTdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 14:33:16 -0500
Date: Fri, 19 Nov 2004 20:33:50 +0100
From: Stelian Pop <stelian@popies.net>
To: mdharm-usb@one-eyed-alien.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] usb-storage should enable scsi disk in Kconfig
Message-ID: <20041119193350.GE2700@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	mdharm-usb@one-eyed-alien.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As $subject says, usb-storage storage should automatically enable
scsi disk support in Kconfig.

Please apply.

Stelian.

Signed-off-by: Stelian Pop <stelian@popies.net>

===== drivers/usb/storage/Kconfig 1.9 vs edited =====
--- 1.9/drivers/usb/storage/Kconfig	2004-06-13 17:24:10 +02:00
+++ edited/drivers/usb/storage/Kconfig	2004-11-19 16:44:16 +01:00
@@ -6,6 +6,7 @@
 	tristate "USB Mass Storage support"
 	depends on USB
 	select SCSI
+	select BLK_DEV_SD
 	---help---
 	  Say Y here if you want to connect USB mass storage devices to your
 	  computer's USB port. This is the driver you need for USB floppy drives,
-- 
Stelian Pop <stelian@popies.net>
