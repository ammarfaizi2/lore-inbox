Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbTFASbU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbTFASbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:31:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17619 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264701AbTFASbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:31:18 -0400
Date: Sun, 1 Jun 2003 20:44:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] SECURITY_ROOTPLUG must depend on USB
Message-ID: <20030601184436.GD29425@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch lets SECURITY_ROOTPLUG depend on USB (otherwise
there are link errors since Root Plug Support needs
usb_bus_list{,_lock}):


--- linux-2.5.70-mm3/security/Kconfig.old	2003-06-01 20:40:40.000000000 +0200
+++ linux-2.5.70-mm3/security/Kconfig	2003-06-01 20:41:00.000000000 +0200
@@ -33,7 +33,7 @@
 
 config SECURITY_ROOTPLUG
 	tristate "Root Plug Support"
-	depends on SECURITY!=n
+	depends on USB && SECURITY!=n
 	help
 	  This is a sample LSM module that should only be used as such.
 	  It prevents any programs running with egid == 0 if a specific


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

