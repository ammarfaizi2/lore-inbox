Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbTIOQU6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTIOQU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:20:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38872 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261530AbTIOQU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:20:57 -0400
Date: Mon, 15 Sep 2003 18:20:47 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.0-test5-mm2: let PM_DISK_PARTITION depend on PM_DISK
Message-ID: <20030915162047.GL126@fs.tum.de>
References: <20030914234843.20cea5b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914234843.20cea5b3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 11:48:43PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.0-test5-mm1:
>...
> -test4-pm1.patch
> +test5-pm2.patch
> +test5-pm2-fix.patch
> 
>  New power management code from Pat.
>...

PM_DISK_PARTITION should only be asked when PM_DISK is enabled:

--- linux-2.6.0-test5-mm2/kernel/power/Kconfig.old	2003-09-15 18:05:40.000000000 +0200
+++ linux-2.6.0-test5-mm2/kernel/power/Kconfig	2003-09-15 18:06:08.000000000 +0200
@@ -66,6 +66,7 @@
 config PM_DISK_PARTITION
 	string "Default resume partition"
 	default ""
+	depends on PM_DISK
 	---help---
 	  The default resume partition is the partition that the pmdisk suspend-
 	  to-disk implementation will look for a suspended disk image. 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

