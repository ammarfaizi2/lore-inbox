Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTFHKeH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 06:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbTFHKeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 06:34:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60613 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261414AbTFHKeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 06:34:05 -0400
Date: Sun, 8 Jun 2003 12:47:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: pavel@suse.cz, acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, andrew.grover@intel.com,
       trivial@rustcorp.com.au
Subject: [2.5 patch] remove unused reset_videobios_after_s3
Message-ID: <20030608104737.GA16164@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

reset_videobios_after_s3 is used nowhere inside 2.5.70-mm6. Unless there 
are plans to use it in the near future I suggest the patch below to 
remove it.

I've tested the compilation with 2.5.70-mm6.

cu
Adrian


--- linux-2.5.70-mm6/arch/i386/kernel/dmi_scan.c.old	2003-06-08 12:42:41.000000000 +0200
+++ linux-2.5.70-mm6/arch/i386/kernel/dmi_scan.c	2003-06-08 12:43:01.000000000 +0200
@@ -482,12 +482,6 @@
 	return 0;
 }
 
-static __init int reset_videobios_after_s3(struct dmi_blacklist *d)
-{
-	extern long acpi_video_flags;
-	acpi_video_flags |= 1;
-	return 0;
-}
 #endif
 
 /*
