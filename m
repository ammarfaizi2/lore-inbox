Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbUAMBwJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbUAMBwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:52:08 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21712 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263468AbUAMBwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:52:05 -0500
Date: Tue, 13 Jan 2004 02:52:02 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: ralf@gnu.org
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix DECSTATION depends
Message-ID: <20040113015202.GE9677@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

it seems the following is required in Linus' tree to get correct depends 
for DECSTATION:

--- linux-2.6.1-mm2/arch/mips/Kconfig.old	2004-01-13 02:33:53.000000000 +0100
+++ linux-2.6.1-mm2/arch/mips/Kconfig	2004-01-13 02:36:04.000000000 +0100
@@ -51,7 +51,7 @@
 
 config DECSTATION
 	bool "Support for DECstations"
-	depends on MIPS32 || EXPERIMENTAL
+	depends on MIPS32 && EXPERIMENTAL
 	---help---
 	  This enables support for DEC's MIPS based workstations.  For details
 	  see the Linux/MIPS FAQ on <http://oss.sgi.com/mips/> and the


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

