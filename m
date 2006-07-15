Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWGOSuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWGOSuh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 14:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWGOSuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 14:50:37 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:3051 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1030199AbWGOSuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 14:50:37 -0400
Message-ID: <44B938FB.3010004@bootc.net>
Date: Sat, 15 Jul 2006 19:50:35 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jim Cromie <jim.cromie@gmail.com>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] scx200_gpio export cleanups
References: <44B936C8.9070907@bootc.net>
In-Reply-To: <44B936C8.9070907@bootc.net>
Content-Type: multipart/mixed;
 boundary="------------040302020605010904090700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040302020605010904090700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chris Boot wrote:
> Use EXPORT_SYMBOL_GPL for new symbols, and declare the struct in the 
> header file for access by other modules.
> 
> Signed-off-by: Chris Boot <bootc@bootc.net>

Corrupted patch... Attached.

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

--------------040302020605010904090700
Content-Type: text/x-patch;
 name="scx200-export-cleanups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scx200-export-cleanups.patch"

diff --git a/drivers/char/scx200_gpio.c b/drivers/char/scx200_gpio.c
index b956c7b..8ecef2e 100644
--- a/drivers/char/scx200_gpio.c
+++ b/drivers/char/scx200_gpio.c
@@ -44,7 +44,7 @@ struct nsc_gpio_ops scx200_gpio_ops = {
 	.gpio_change	= scx200_gpio_change,
 	.gpio_current	= scx200_gpio_current
 };
-EXPORT_SYMBOL(scx200_gpio_ops);
+EXPORT_SYMBOL_GPL(scx200_gpio_ops);
 
 static int scx200_gpio_open(struct inode *inode, struct file *file)
 {
diff --git a/include/linux/scx200_gpio.h b/include/linux/scx200_gpio.h
index 90dd069..1a82d30 100644
--- a/include/linux/scx200_gpio.h
+++ b/include/linux/scx200_gpio.h
@@ -4,6 +4,7 @@ u32 scx200_gpio_configure(unsigned index
 
 extern unsigned scx200_gpio_base;
 extern long scx200_gpio_shadow[2];
+extern struct nsc_gpio_ops scx200_gpio_ops;
 
 #define scx200_gpio_present() (scx200_gpio_base!=0)
 

--------------040302020605010904090700--
