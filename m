Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWHMMoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWHMMoo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 08:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWHMMoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 08:44:44 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:6036 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751153AbWHMMoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 08:44:44 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm1
Date: Sun, 13 Aug 2006 14:43:14 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org>
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608131443.14461.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 10:24, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> 
> - Warning: all the Serial ATA Kconfig options have been renamed.  If you
>   blindly run `make oldconfig' you won't have any disks.

Something like the appended patch is needed for the SATA/PATA options to show
up in the menu.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/ata/Kconfig |    8 ++++++++
 1 files changed, 8 insertions(+)

Index: linux-2.6.18-rc4-mm1/drivers/ata/Kconfig
===================================================================
--- linux-2.6.18-rc4-mm1.orig/drivers/ata/Kconfig
+++ linux-2.6.18-rc4-mm1/drivers/ata/Kconfig
@@ -1,3 +1,9 @@
+#
+# SATA/PATA driver configuration
+#
+
+menu "Serial and Parallel ATA (SATA/PATA) drivers"
+	depends on SCSI
 
 config ATA
 	tristate "ATA device support"
@@ -481,3 +487,5 @@ config PATA_WINBOND
 
 	  If unsure, say N.
 
+endmenu
+
