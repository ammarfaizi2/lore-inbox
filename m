Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWDILbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWDILbM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 07:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWDILbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 07:31:12 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21508 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750728AbWDILbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 07:31:11 -0400
Date: Sun, 9 Apr 2006 13:31:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, gregkh@suse.de, johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: [-mm patch] drivers/w1/w1.c: fix a compile error
Message-ID: <20060409113110.GA8454@stusta.de>
References: <20060408031405.5e5131da.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408031405.5e5131da.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error:

<--  snip  -->

...
  CC      drivers/w1/w1.o
drivers/w1/w1.c:197: error: static declaration of 'w1_bus_type' follows non-static declaration
drivers/w1/w1.h:217: error: previous declaration of 'w1_bus_type' was here
make[2]: *** [drivers/w1/w1.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm2-full/drivers/w1/w1.h.old	2006-04-09 11:21:48.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/w1/w1.h	2006-04-09 11:21:57.000000000 +0200
@@ -214,7 +214,6 @@
 }
 
 extern struct device_driver w1_master_driver;
-extern struct bus_type w1_bus_type;
 extern struct device w1_master_device;
 extern int w1_max_slave_count;
 extern int w1_max_slave_ttl;

