Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUKMOy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUKMOy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 09:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbUKMOy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 09:54:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4370 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262766AbUKMOyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 09:54:24 -0500
Date: Sat, 13 Nov 2004 15:53:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Robert Olsson <robert.olsson@its.uu.se>
Cc: davem@davemloft.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [patch] net/core/pktgen.c shouldn't include pci.h
Message-ID: <20041113145351.GZ2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If rebuilding after touching pci.h in 2.6, net/core/pktgen.c is the only 
file under net/ that gets rebuilt.

I searched and didn't find any reason why net/core/pktgen.c needs to 
include pci.h .

I'm therefore suggesting the patch below (applies against both 2.4
and 2.6).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/net/core/pktgen.c.old	2004-11-13 14:37:43.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/net/core/pktgen.c	2004-11-13 14:40:07.000000000 +0100
@@ -69,7 +69,6 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/inet.h>


