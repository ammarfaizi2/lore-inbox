Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTFHMhg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 08:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTFHMhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 08:37:36 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37572 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261710AbTFHMhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 08:37:35 -0400
Date: Sun, 8 Jun 2003 14:51:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: perex@suse.cz
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [2.5 patch] add returntypes to two funxtions in isapnp.h
Message-ID: <20030608125107.GD16164@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds the missing return types (that give compile 
warnings) to two dummy functions in isapp.h for !CONFIG_PROC_FS. I've 
tested the compilation with 2.5.70-mm6.


--- linux-2.5.70-mm6/include/linux/isapnp.h.old	2003-06-08 14:25:27.000000000 +0200
+++ linux-2.5.70-mm6/include/linux/isapnp.h	2003-06-08 14:25:35.000000000 +0200
@@ -115,8 +115,8 @@
 int isapnp_proc_init(void);
 int isapnp_proc_done(void);
 #else
-static inline isapnp_proc_init(void) { return 0; }
-static inline isapnp_proc_done(void) { return 0; }
+static inline int isapnp_proc_init(void) { return 0; }
+static inline int isapnp_proc_done(void) { return 0; }
 #endif
 
 /* init/main.c */


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

