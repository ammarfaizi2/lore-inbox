Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTE2Pmj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTE2Pmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:42:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39891 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262312AbTE2Pmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:42:36 -0400
Date: Thu, 29 May 2003 17:55:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5 patch] Let EMBEDDED depend on EXPERIMENTAL
Message-ID: <20030529155543.GF5643@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch lets EMBEDDED depend on EXPERIMENTAL to make it less 
likely someone accidentially selects EMBEDDED:


--- linux-2.5.70-full/init/Kconfig.old	2003-05-29 17:47:29.000000000 +0200
+++ linux-2.5.70-full/init/Kconfig	2003-05-29 17:49:43.000000000 +0200
@@ -111,6 +111,8 @@
 
 menuconfig EMBEDDED
 	bool "Remove kernel features (for embedded systems)"
+	default n
+	depends on EXPERIMENTAL
 	help
 	  This option allows certain base kernel features to be removed from
 	  the build.  This is for specialized environments which can tolerate


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

