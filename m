Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263616AbUJ3Fws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUJ3Fws (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 01:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbUJ3Fws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 01:52:48 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15377 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263616AbUJ3Fwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 01:52:40 -0400
Date: Sat, 30 Oct 2004 07:52:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-computone@lazuli.wittsend.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] ip2main.c: remove stale function declaration
Message-ID: <20041030055208.GE4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following compile warning in recent 2.6 kernels:

<--  snip  -->

...
  CC      drivers/char/ip2main.o
...
drivers/char/ip2main.c:205: warning: 'set_modem_info' declared `static' but never defined
...

<--  snip  -->


gcc is right, and the patch below removes this finction declaration.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/drivers/char/ip2main.c.old	2004-10-30 04:27:14.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/char/ip2main.c	2004-10-30 04:27:20.000000000 +0200
@@ -202,7 +202,6 @@
 static void ip2_wait_until_sent(PTTY,int);
 
 static void set_params (i2ChanStrPtr, struct termios *);
-static int set_modem_info(i2ChanStrPtr, unsigned int, unsigned int *);
 static int get_serial_info(i2ChanStrPtr, struct serial_struct __user *);
 static int set_serial_info(i2ChanStrPtr, struct serial_struct __user *);
 

