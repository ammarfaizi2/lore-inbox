Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbTFUOri (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264852AbTFUOri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:47:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52719 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264851AbTFUOrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:47:35 -0400
Date: Sat, 21 Jun 2003 17:01:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: oliver@neukum.org
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] remove an unused label from kaweth.c
Message-ID: <20030621150132.GB23337@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes to kaweth added an unused label. The following patch 
removes it.

I've tested the compilation with 2.5.72-mm2.

--- linux-2.5.72-mm2/drivers/usb/net/kaweth.c.old	2003-06-21 16:57:36.000000000 +0200
+++ linux-2.5.72-mm2/drivers/usb/net/kaweth.c	2003-06-21 16:59:01.000000000 +0200
@@ -1092,7 +1092,6 @@
 
 err_intfdata:
 	usb_set_intfdata(intf, NULL);
-err_all:
 	usb_buffer_free(kaweth->dev, KAWETH_BUF_SIZE, (void *)kaweth->rx_buf, kaweth->rxbufferhandle);
 err_all_but_rxbuf:
 	usb_buffer_free(kaweth->dev, INTBUFFERSIZE, (void *)kaweth->intbuffer, kaweth->intbufferhandle);


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

