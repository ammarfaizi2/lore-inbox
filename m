Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWGOSlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWGOSlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 14:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWGOSlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 14:41:15 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:7556 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1751534AbWGOSlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 14:41:14 -0400
Message-ID: <44B936C8.9070907@bootc.net>
Date: Sat, 15 Jul 2006 19:41:12 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Jim Cromie <jim.cromie@gmail.com>,
       Adrian Bunk <bunk@stusta.de>
Subject: [PATCH] scx200_gpio export cleanups
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use EXPORT_SYMBOL_GPL for new symbols, and declare the struct in the header file 
for access by other modules.

Signed-off-by: Chris Boot <bootc@bootc.net>

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


-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
