Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSHFU6Y>; Tue, 6 Aug 2002 16:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSHFUwQ>; Tue, 6 Aug 2002 16:52:16 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:36583 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316390AbSHFUvy>;
	Tue, 6 Aug 2002 16:51:54 -0400
Date: Tue, 6 Aug 2002 13:55:31 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] : ir240_expiry_fix.diff
Message-ID: <20020806205531.GI11677@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir240_expiry_fix.diff :
---------------------
	o [CORRECT] Make discovery expiry work properly for non default
		discovery period/timeout


diff -u -p linux/include/net/irda/discovery.d1.h linux/include/net/irda/discovery.h
--- linux/include/net/irda/discovery.d1.h	Mon Aug  5 16:00:23 2002
+++ linux/include/net/irda/discovery.h	Mon Aug  5 16:00:28 2002
@@ -36,7 +36,7 @@
 #include <net/irda/irda.h>
 #include <net/irda/irqueue.h>
 
-#define DISCOVERY_EXPIRE_TIMEOUT 6*HZ
+#define DISCOVERY_EXPIRE_TIMEOUT (2*sysctl_discovery_timeout*HZ)
 #define DISCOVERY_DEFAULT_SLOTS  0
 
 /* Types of discovery */
