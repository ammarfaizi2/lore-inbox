Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbTCEWCk>; Wed, 5 Mar 2003 17:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbTCEWCk>; Wed, 5 Mar 2003 17:02:40 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44778 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265578AbTCEWCi>; Wed, 5 Mar 2003 17:02:38 -0500
Date: Wed, 5 Mar 2003 23:13:02 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@codemonkey.org.uk>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: [2.5 patch] remove EXPORT_NO_SYMBOLS from amd7xx_tco
Message-ID: <20030305221302.GN20423@fs.tum.de>
References: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 07:48:33PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.63 to v2.5.64
> ============================================
>...
> Dave Jones <davej@codemonkey.org.uk>:
>...
>   o [WATCHDOG] Merge AMD 766/768 TCO Timer/Watchdog driver from 2.4
>...


amd7xx_tco.c contains the obsolete EXPORT_NO_SYMBOLS. The following 
patch corrects this bug:


--- linux-2.5.64-notfull/drivers/char/watchdog/amd7xx_tco.c.old	2003-03-05 23:07:47.000000000 +0100
+++ linux-2.5.64-notfull/drivers/char/watchdog/amd7xx_tco.c	2003-03-05 23:08:19.000000000 +0100
@@ -369,5 +369,4 @@
 MODULE_AUTHOR("Zwane Mwaikambo <zwane@commfireservices.com>");
 MODULE_DESCRIPTION("AMD 766/768 TCO Timer Driver");
 MODULE_LICENSE("GPL");
-EXPORT_NO_SYMBOLS;
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

