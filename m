Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266298AbUGAVpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266298AbUGAVpM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266297AbUGAVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:45:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61673 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266300AbUGAVoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:44:38 -0400
Date: Thu, 1 Jul 2004 23:44:30 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove unused variable in esp.c
Message-ID: <20040701214430.GA28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following warning in 2.6.7-mm5:

<--  snip  -->

...
  CC [M]  drivers/char/esp.o
drivers/char/esp.c: In function `esp_tiocmset':
drivers/char/esp.c:1783: warning: unused variable `arg'
...

<--  snip  -->

Since the variable is in fact unused, the following patch simply removes 
it:

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm5-modular/drivers/char/esp.c.old	2004-07-01 23:39:03.000000000 +0200
+++ linux-2.6.7-mm5-modular/drivers/char/esp.c	2004-07-01 23:39:11.000000000 +0200
@@ -1780,7 +1780,6 @@
 			unsigned int set, unsigned int clear)
 {
 	struct esp_struct * info = (struct esp_struct *)tty->driver_data;
-	unsigned int arg;
 
 	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
 		return -ENODEV;


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

