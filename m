Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266334AbUGAWWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUGAWWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266348AbUGAWWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:22:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:65511 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266334AbUGAWWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:22:05 -0400
Date: Fri, 2 Jul 2004 00:21:57 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] ip2main.c: remove outdated set_modem_info declaration
Message-ID: <20040701222157.GC28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following warning in 2.6.7-mm5:

<--  snip  -->

...
  CC [M]  drivers/char/ip2main.o
...
drivers/char/ip2main.c:205: warning: `set_modem_info' declared `static' but never defined
...

<--  snip  -->

The following patch removes this outdated declaration:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm5-modular/drivers/char/ip2main.c.old	2004-07-01 23:48:49.000000000 +0200
+++ linux-2.6.7-mm5-modular/drivers/char/ip2main.c	2004-07-01 23:49:55.000000000 +0200
@@ -202,7 +202,6 @@
 static void ip2_wait_until_sent(PTTY,int);
 
 static void set_params (i2ChanStrPtr, struct termios *);
-static int set_modem_info(i2ChanStrPtr, unsigned int, unsigned int *);
 static int get_serial_info(i2ChanStrPtr, struct serial_struct *);
 static int set_serial_info(i2ChanStrPtr, struct serial_struct *);
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

