Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbTIITVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbTIITUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:20:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46558 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264322AbTIITTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:19:14 -0400
Date: Tue, 9 Sep 2003 21:19:05 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>, chas@cmf.nrl.navy.mil
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, jgarzik@pobox.com
Subject: [2.6 patch] ATM Ambassador no longer BROKEN_ON_SMP
Message-ID: <20030909191904.GA25679@fs.tum.de>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 01:32:05PM -0700, Linus Torvalds wrote:
>...
> Summary of changes from v2.6.0-test4 to v2.6.0-test5
> ============================================
>...
> Chas Williams:
>   o [ATM]: Clean up the code making use of sti/cli (from
>     vinay-rc@naturesoft.net)
>...

This fixed the compilation on SMP.

The following patch removes the BROKEN_ON_SMP:

--- linux-2.6.0-test5+tr-full/drivers/atm/Kconfig.old	2003-09-09 20:55:37.000000000 +0200
+++ linux-2.6.0-test5+tr-full/drivers/atm/Kconfig	2003-09-09 20:56:43.000000000 +0200
@@ -241,7 +241,7 @@
 
 config ATM_AMBASSADOR
 	tristate "Madge Ambassador (Collage PCI 155 Server)"
-	depends on PCI && ATM && BROKEN_ON_SMP
+	depends on PCI && ATM
 	help
 	  This is a driver for ATMizer based ATM card produced by Madge
 	  Networks Ltd. Say Y (or M to compile as a module named ambassador)


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

