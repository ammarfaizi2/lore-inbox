Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288998AbSAIUGe>; Wed, 9 Jan 2002 15:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289000AbSAIUGS>; Wed, 9 Jan 2002 15:06:18 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:34035 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S289011AbSAIUE5>;
	Wed, 9 Jan 2002 15:04:57 -0500
Date: Wed, 9 Jan 2002 12:04:53 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] : ir248_config-3.diff
Message-ID: <20020109120453.F12039@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir248_config-3.diff :
-------------------
	<Already in 2.5.1, for 2.4.18 only>
	o [FEATURE] Remove useless and confusing config option

diff -u -p linux/net/irda/Config.d3.in linux/net/irda/Config.in
--- linux/net/irda/Config.d3.in	Wed Nov 28 14:57:18 2001
+++ linux/net/irda/Config.in	Wed Nov 28 15:31:14 2001
@@ -14,13 +14,10 @@ if [ "$CONFIG_NET" != "n" ]; then
       source net/irda/irnet/Config.in
       source net/irda/ircomm/Config.in
       bool '  Ultra (connectionless) protocol' CONFIG_IRDA_ULTRA
-      bool '  IrDA protocol options' CONFIG_IRDA_OPTIONS
-      if [ "$CONFIG_IRDA_OPTIONS" != "n" ]; then
-	 comment '  IrDA options'
-	 bool '    Cache last LSAP' CONFIG_IRDA_CACHE_LAST_LSAP
-	 bool '    Fast RRs' CONFIG_IRDA_FAST_RR
-	 bool '    Debug information' CONFIG_IRDA_DEBUG
-      fi
+      comment 'IrDA options'
+      bool '  Cache last LSAP' CONFIG_IRDA_CACHE_LAST_LSAP
+      bool '  Fast RRs (low latency)' CONFIG_IRDA_FAST_RR
+      bool '  Debug information' CONFIG_IRDA_DEBUG
    fi
 
    if [ "$CONFIG_IRDA" != "n" ]; then
diff -u -p linux/arch/i386/defconfig.d3 linux/arch/i386/defconfig
--- linux/arch/i386/defconfig.d3	Tue Jan  8 17:09:27 2002
+++ linux/arch/i386/defconfig	Tue Jan  8 17:09:40 2002
@@ -496,6 +496,9 @@ CONFIG_PCMCIA_RAYCS=y
 # IrDA (infrared) support
 #
 # CONFIG_IRDA is not set
+CONFIG_IRDA_CACHE_LAST_LSAP=y
+CONFIG_IRDA_FAST_RR=y
+CONFIG_IRDA_DEBUG=y
 
 #
 # ISDN subsystem
