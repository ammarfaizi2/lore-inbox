Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTFGNf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 09:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTFGNf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 09:35:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4822 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263187AbTFGNfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 09:35:25 -0400
Date: Sat, 7 Jun 2003 15:48:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: jffs-dev@axis.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] JFFS_PROC_FS must depend on JFFS_FS
Message-ID: <20030607134820.GK15311@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.70-mm5 compilation fails if JFFS_PROC_FS and !PROC. The 
following dependency in the Kconfig file is needed:

--- linux-2.5.70-mm5/fs/Kconfig.old	2003-06-07 15:42:10.000000000 +0200
+++ linux-2.5.70-mm5/fs/Kconfig	2003-06-07 15:42:32.000000000 +0200
@@ -1043,7 +1043,7 @@
 
 config JFFS_PROC_FS
 	bool "JFFS stats available in /proc filesystem"
-	depends on JFFS_FS
+	depends on JFFS_FS && PROC
 	help
 	  Enabling this option will cause statistics from mounted JFFS file systems
 	  to be made available to the user in the /proc/fs/jffs/ directory.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

