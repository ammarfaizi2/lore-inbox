Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUFXXK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUFXXK4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUFXXKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:10:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15339 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264686AbUFXXKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:10:42 -0400
Date: Fri, 25 Jun 2004 01:10:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Martin.Bligh@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] add required dependencies to X86_NUMAQ
Message-ID: <20040624231033.GF26669@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you select another option, you have to ensure that the dependencies 
of the selected options are met.

The following patch adds to X86_NUMAQ the required dependencies for the 
selected NUMA:

--- linux-2.6.7-mm2-full/arch/i386/Kconfig.old	2004-06-24 22:42:32.000000000 +0200
+++ linux-2.6.7-mm2-full/arch/i386/Kconfig	2004-06-24 22:44:53.000000000 +0200
@@ -65,6 +65,7 @@
 
 config X86_NUMAQ
 	bool "NUMAQ (IBM/Sequent)"
+	depends on SMP && HIGHMEM64G
 	select DISCONTIGMEM
 	select NUMA
 	help


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

