Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276444AbRJKPjh>; Thu, 11 Oct 2001 11:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276525AbRJKPjS>; Thu, 11 Oct 2001 11:39:18 -0400
Received: from kiln.isn.net ([198.167.161.1]:3395 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S276444AbRJKPjQ>;
	Thu, 11 Oct 2001 11:39:16 -0400
Message-ID: <3BC5BD3B.CA7A0747@isn.net>
Date: Thu, 11 Oct 2001 12:39:39 -0300
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] parport.h ieee1284_ops.c 2.4.12
Content-Type: multipart/mixed;
 boundary="------------A8A58F1C41C73B90940D837B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A8A58F1C41C73B90940D837B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached patches fix my problems with 2.4.12
include/linux/parport.h
drivers/parport/ieee1284_ops.c
Garst
--------------A8A58F1C41C73B90940D837B
Content-Type: text/plain; charset=us-ascii;
 name="ieee1284_ops.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ieee1284_ops.c.diff"

--- ieee1284_ops.c~	Thu Oct 11 10:02:34 2001
+++ ieee1284_ops.c	Thu Oct 11 11:59:26 2001
@@ -362,7 +362,7 @@
 	} else {
 		DPRINTK (KERN_DEBUG "%s: ECP direction: failed to reverse\n",
 			 port->name);
-		port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 	}
 
 	return retval;
@@ -394,7 +394,7 @@
 		DPRINTK (KERN_DEBUG
 			 "%s: ECP direction: failed to switch forward\n",
 			 port->name);
-		port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 	}
 
 

--------------A8A58F1C41C73B90940D837B
Content-Type: text/plain; charset=us-ascii;
 name="parport.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="parport.h.diff"

--- parport.h~	Thu Oct 11 11:29:28 2001
+++ parport.h	Thu Oct 11 11:57:08 2001
@@ -252,7 +252,7 @@
 	IEEE1284_PH_ECP_SETUP,
 	IEEE1284_PH_ECP_FWD_TO_REV,
 	IEEE1284_PH_ECP_REV_TO_FWD,
-	IEEE1284_PH_ECP_DIR_UNKNOWN,
+	IEEE1284_PH_ECP_DIR_UNKNOWN
 };
 struct ieee1284_info {
 	int mode;

--------------A8A58F1C41C73B90940D837B--

