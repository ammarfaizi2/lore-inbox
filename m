Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261760AbSI2UGl>; Sun, 29 Sep 2002 16:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261761AbSI2UGl>; Sun, 29 Sep 2002 16:06:41 -0400
Received: from [209.173.6.49] ([209.173.6.49]:23168 "EHLO comet.linuxguru.net")
	by vger.kernel.org with ESMTP id <S261760AbSI2UGk>;
	Sun, 29 Sep 2002 16:06:40 -0400
Date: Sun, 29 Sep 2002 16:11:59 -0400
From: newsgate@linuxguru.net
To: linux-kernel@vger.kernel.org
Cc: hermes@gibson.dropbear.id.au
Subject: [PATCH] Orinoco 2.5.39 include fix
Message-ID: <20020929201159.GA4933@comet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.39 with orinoco support fails to include because of tqueue.h isn't
included. This patch fixes that so that the orinoco module compiles.  

This patch has been untested because the keyboard on my Toshiba 505-S5004
has not worked since 2.5.31. :(


(An aside -- Some day I'm going to have a kernel patch accepted. Some
day...)



diff -urN linux-2.5.39/drivers/net/wireless/orinoco.c linux-2.5.39.new/drivers/net/wireless/orinoco.c
--- linux-2.5.39/drivers/net/wireless/orinoco.c	2002-09-27 17:49:54.000000000 -0400
+++ linux-2.5.39.new/drivers/net/wireless/orinoco.c	2002-09-29 15:57:30.000000000 -0400
@@ -372,6 +372,7 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <linux/wireless.h>
+#include <linux/tqueue.h>
 
 #include "hermes.h"
 #include "hermes_rid.h"
diff -urN linux-2.5.39/drivers/net/wireless/orinoco_cs.c linux-2.5.39.new/drivers/net/wireless/orinoco_cs.c
--- linux-2.5.39/drivers/net/wireless/orinoco_cs.c	2002-09-27 17:50:32.000000000 -0400
+++ linux-2.5.39.new/drivers/net/wireless/orinoco_cs.c	2002-09-29 15:57:17.000000000 -0400
@@ -32,6 +32,7 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <linux/wireless.h>
+#include <linux/tqueue.h>
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>


-- 
GnuPG fingerprint AAE4 8C76 58DA 5902 761D  247A 8A55 DA73 0635 7400
James Blackwell  --  Director http://www.linuxguru.net
