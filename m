Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312791AbSCVS3w>; Fri, 22 Mar 2002 13:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312790AbSCVS3c>; Fri, 22 Mar 2002 13:29:32 -0500
Received: from stingr.net ([212.193.33.37]:33165 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S312788AbSCVS33>;
	Fri, 22 Mar 2002 13:29:29 -0500
Date: Fri, 22 Mar 2002 21:29:23 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Andrew Morton <akpm@zip.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Fix *ERRORS* in cs89x0
Message-ID: <20020322182923.GA3199@stingr.net>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hehe. Tried to get my old ibm pc300gl working with onboard network.
It won't start. Wonder why ? Then examine changes I made to source to start
it.

Examine thorough. Please. 0x6 == (0x4 | 0x2), isn't it ?

This is the 2nd edition - at 1st take I just commented out some |'s in
adapter_cnf init code in cs89x0.c. Dunno what change is 'ideologically
correct'. Now I'm happy with following.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.162   -> 1.163  
#	drivers/net/cs89x0.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/22	stingray@proxy.sgu.ru	1.163
# Fix stupid error in cs89x0
# --------------------------------------------
#
diff -Nru a/drivers/net/cs89x0.h b/drivers/net/cs89x0.h
--- a/drivers/net/cs89x0.h	Fri Mar 22 15:26:24 2002
+++ b/drivers/net/cs89x0.h	Fri Mar 22 15:26:24 2002
@@ -385,11 +385,11 @@
 #define A_CNF_10B_T 0x0001
 #define A_CNF_AUI 0x0002
 #define A_CNF_10B_2 0x0004
-#define A_CNF_MEDIA_TYPE 0x0060
-#define A_CNF_MEDIA_AUTO 0x0000
+#define A_CNF_MEDIA_TYPE 0x0070
+#define A_CNF_MEDIA_AUTO 0x0070
 #define A_CNF_MEDIA_10B_T 0x0020
 #define A_CNF_MEDIA_AUI 0x0040
-#define A_CNF_MEDIA_10B_2 0x0060
+#define A_CNF_MEDIA_10B_2 0x0010
 #define A_CNF_DC_DC_POLARITY 0x0080
 #define A_CNF_NO_AUTO_POLARITY 0x2000
 #define A_CNF_LOW_RX_SQUELCH 0x4000


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
