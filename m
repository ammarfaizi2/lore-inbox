Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269377AbUI3Rx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269377AbUI3Rx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269374AbUI3Rx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:53:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16334 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269377AbUI3RxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:53:12 -0400
Date: Thu, 30 Sep 2004 13:52:47 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: PATCH: Kconfig for EDD
Message-ID: <20040930175247.GA31128@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EDD fails with ACARD scsi devices present (hang on the 16bit bios call at boot)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/drivers/firmware/Kconfig linux-2.6.9rc3/drivers/firmware/Kconfig
--- linux.vanilla-2.6.9rc3/drivers/firmware/Kconfig	2004-09-30 15:36:07.507035472 +0100
+++ linux-2.6.9rc3/drivers/firmware/Kconfig	2004-09-30 16:33:46.422200440 +0100
@@ -14,8 +14,9 @@
 	  Services real mode BIOS calls to determine which disk
 	  BIOS tries boot from.  This information is then exported via sysfs.
 
-	  This option is experimental, but believed to be safe,
-	  and most disk controller BIOS vendors do not yet implement this feature.
+	  This option is experimental and is known to fail to boot on some
+          obscure configurations. Most disk controller BIOS vendors do 
+          not yet implement this feature.
 
 config EFI_VARS
 	tristate "EFI Variable Support via sysfs"
