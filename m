Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132282AbQLHUnJ>; Fri, 8 Dec 2000 15:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132685AbQLHUm7>; Fri, 8 Dec 2000 15:42:59 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:48749
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132282AbQLHUmv>; Fri, 8 Dec 2000 15:42:51 -0500
Date: Fri, 8 Dec 2000 21:12:17 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Elmer.Joandi@ut.ee
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove warning from drivers/net/arlan.c
Message-ID: <20001208211217.A599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch eliminates an 'defined but not used' warning when
compiling drivers/net/arlan.c without module support (240t12p3). It 
also fixes a typo.

It should apply cleanly.


--- linux-240-t12-pre3-clean/drivers/net/arlan.c	Wed Nov 22 22:41:40 2000
+++ linux/drivers/net/arlan.c	Sun Dec  3 13:05:53 2000
@@ -8,7 +8,7 @@
 #include <linux/config.h>
 #include "arlan.h"
 
-static const char *arlan_version = "C.Jennigs 97 & Elmer.Joandi@ut.ee  Oct'98, http://www.ylenurme.ee/~elmer/655/";
+static const char *arlan_version = "C.Jennings 97 & Elmer.Joandi@ut.ee  Oct'98, http://www.ylenurme.ee/~elmer/655/";
 
 struct net_device *arlan_device[MAX_ARLANS];
 int last_arlan;
@@ -19,7 +19,6 @@
 static char *siteName = siteNameUNKNOWN;
 static int mem = memUNKNOWN;
 int arlan_debug = debugUNKNOWN;
-static int probe = probeUNKNOWN;
 static int numDevices = numDevicesUNKNOWN;
 static int spreadingCode = spreadingCodeUNKNOWN;
 static int channelNumber = channelNumberUNKNOWN;
@@ -1986,6 +1985,8 @@
 }
 
 #ifdef  MODULE
+
+static int probe = probeUNKNOWN;
 
 int init_module(void)
 {

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

If a man says something in a forest and there are no women around to 
hear him, is he still wrong? -- Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
