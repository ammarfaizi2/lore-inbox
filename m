Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUGOA0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUGOA0C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUGOAYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:24:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:56811 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266004AbUGOAJJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:09:09 -0400
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
In-Reply-To: <10898500301403@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Jul 2004 17:07:10 -0700
Message-Id: <10898500302358@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.13.8, 2004/07/09 14:47:23-07:00, khali@linux-fr.org

[PATCH] I2C: remove Documentation for i2c-pport

> > This also raises a question about Documentation/i2c/i2c-pport.
> > Should we keep a document about a driver which is not in the kernel
> > tree (and hasn't even been ported to 2.6 yet)?
>
> No we should not.

Signed-off-by: Jean Delvare <khali at linux-fr dot org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/i2c/i2c-pport |   45 --------------------------------------------
 1 files changed, 45 deletions(-)


diff -Nru a/Documentation/i2c/i2c-pport b/Documentation/i2c/i2c-pport
--- a/Documentation/i2c/i2c-pport	2004-07-14 16:59:45 -07:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,45 +0,0 @@
-Primitive parallel port is driver for i2c bus, which exploits 
-features of modern bidirectional parallel ports. 
-
-Bidirectional ports have particular bits connected in following way:
-   
-                        |
-            /-----|     R
-         --o|     |-----|
-      read  \-----|     /------- Out pin
-                      |/
-                   - -|\
-                write   V
-                        |
-                       ---  
-
-
-It means when output is set to 1 we can read the port. Therefore 
-we can use 2 pins of parallel port as SDA and SCL for i2c bus. It 
-is not necessary to add any external - additional parts, we can 
-read and write the same port simultaneously.
-	I only use register base+2 so it is possible to use all 
-8 data bits of parallel port for other applications (I have 
-connected EEPROM and LCD display). I do not use bit Enable Bi-directional
- Port. The only disadvantage is we can only support 5V chips.
-
-Layout:
-
-Cannon 25 pin
-
-SDA - connect to pin 14 (Auto Linefeed)
-SCL - connect to pin 16 (Initialize Printer)
-GND - connect to pin 18-25
-+5V - use external supply (I use 5V from 3.5" floppy connector)
-      
-no pullups  requied
-
-Module parameters:
-
-base = 0xXXX
-XXX - 278 or 378
-
-That's all.
-
-Daniel Smolik
-marvin@sitour.cz

