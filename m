Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268655AbTCCWQ3>; Mon, 3 Mar 2003 17:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268658AbTCCWQ3>; Mon, 3 Mar 2003 17:16:29 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:1683 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S268655AbTCCWQ2>; Mon, 3 Mar 2003 17:16:28 -0500
Message-Id: <200303032226.h23MQbGi028937@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-reply-to: Your message of "Mon, 03 Mar 2003 17:20:31 EST."
             <200303032220.h23MKVGi028878@locutus.cmf.nrl.navy.mil> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 03 Mar 2003 17:26:37 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oops -- missing just one little bit (the best part?)

Index: linux/net/Kconfig
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/Kconfig,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Kconfig
--- linux/net/Kconfig	20 Feb 2003 13:46:28 -0000	1.1.1.1
+++ linux/net/Kconfig	1 Mar 2003 13:47:27 -0000
@@ -227,7 +227,7 @@
 source "net/sctp/Kconfig"
 
 config ATM
-	bool "Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)"
+	tristate "Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	---help---
 	  ATM is a high-speed networking technology for Local Area Networks
@@ -244,7 +244,7 @@
 	  further details.
 
 config ATM_CLIP
-	bool "Classical IP over ATM (EXPERIMENTAL)"
+	tristate "Classical IP over ATM (EXPERIMENTAL)"
 	depends on ATM && INET
 	help
 	  Classical IP over ATM for PVCs and SVCs, supporting InARP and
@@ -264,7 +264,7 @@
 
 config ATM_LANE
 	tristate "LAN Emulation (LANE) support (EXPERIMENTAL)"
-	depends on ATM
+	depends on ATM && INET
 	help
 	  LAN Emulation emulates services of existing LANs across an ATM
 	  network. Besides operating as a normal ATM end station client, Linux
