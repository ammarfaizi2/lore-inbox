Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTEGTr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTEGTr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:47:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10189 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264331AbTEGTrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:47:24 -0400
Date: Wed, 7 May 2003 21:59:51 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.69-ac1: ps2esdi.c doesn't compile
Message-ID: <20030507195950.GG9794@fs.tum.de>
References: <200305062203.h46M37g25953@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305062203.h46M37g25953@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following part of -ac1 is bogus (it breaks the static compilation 
of the driver):


--- linux-2.5.69/drivers/block/ps2esdi.c	2003-05-06 16:52:07.000000000 +0100
+++ linux-2.5.69-ac1/drivers/block/ps2esdi.c	2003-05-06 20:05:31.000000000 +0100
@@ -107,7 +107,7 @@
 static int ps2esdi_slot = -1;
 static int tp720esdi = 0;	/* Is it Integrated ESDI of ThinkPad-720? */
 static int intg_esdi = 0;       /* If integrated adapter */
-struct ps2esdi_i_struct {
+struct ps2_esdi_i_struct {
 	unsigned int head, sect, cyl, wpcom, lzone, ctl;
 };
 static spinlock_t ps2esdi_lock = SPIN_LOCK_UNLOCKED;



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

