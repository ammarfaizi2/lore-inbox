Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268171AbTBXGlT>; Mon, 24 Feb 2003 01:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268173AbTBXGlT>; Mon, 24 Feb 2003 01:41:19 -0500
Received: from adsl-175-13.barak.net.il ([62.90.175.13]:23424 "EHLO
	laptop.slamail.org") by vger.kernel.org with ESMTP
	id <S268171AbTBXGlS>; Mon, 24 Feb 2003 01:41:18 -0500
Message-ID: <3E59C109.2020103@slamail.org>
Date: Mon, 24 Feb 2003 08:51:53 +0200
From: Yaacov Akiba Slama <ya@slamail.org>
Reply-To: Yaacov Akiba Slama <ya@slamail.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en, fr, he
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial drivers/pcmcia/i82365.c
Content-Type: multipart/mixed;
 boundary="------------060205070805000902070105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060205070805000902070105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

drivers/pcmcia/i82365.c needs the following patchlet to compile because 
the ChangeSet 1.990.4.3 modified the signature of pnp_activate_dev.

With this patch, I can use 2.5.62 + cset-1.914.102.107-to-1.1025 + 
ChangeSet 1.1037 in my thinkpad 600x + xircom ethernet&modem card.

Thanks,
Yaacov Akiba Slama

--------------060205070805000902070105
Content-Type: text/plain;
 name="pcmcia-i8235.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcmcia-i8235.diff"

--- linux/drivers/pcmcia/i82365.c	2003-02-23 23:41:39.000000000 +0200
+++ linux/drivers/pcmcia/i82365.c	2003-02-23 23:42:57.000000000 +0200
@@ -846,7 +846,7 @@
 	
 	    printk("PNP ");
 	    
-	    if (pnp_activate_dev(dev, NULL) < 0) {
+	    if (pnp_activate_dev(dev) < 0) {
 		printk("activate failed\n");
 		pnp_device_detach(dev);
 		break;

--------------060205070805000902070105--

