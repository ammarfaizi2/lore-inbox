Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131076AbRCJRzN>; Sat, 10 Mar 2001 12:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131077AbRCJRzD>; Sat, 10 Mar 2001 12:55:03 -0500
Received: from d189.as5200.mesatop.com ([208.164.122.189]:22665 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S131076AbRCJRyv>; Sat, 10 Mar 2001 12:54:51 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Sat, 10 Mar 2001 10:57:46 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH] remove second identical Configure.help entry for six CONFIGs
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01031010574602.08110@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.4.2-ac17, there are 8 CONFIG parameters which have two entries
in Configure.help.  Of these eight,  six have identical Configure.help text.

The following patch removes the second identical instance of those six.

If this patch is accepted, a patch to remove the obsolete version of the
other two (namely CONFIG_DEBUG_IOVIRT and  CONFIG_IP_NF_TARGET_TCPMSS)
will be posted here.

Here is the patch, against 2.4.2-ac17.

Steven

--- linux/Documentation/Configure.help.orig     Sat Mar 10 09:35:19 2001
+++ linux/Documentation/Configure.help  Sat Mar 10 09:45:50 2001
@@ -2070,15 +2070,6 @@
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.

-tcpmss match support
-CONFIG_IP_NF_MATCH_TCPMSS
-  This option adds a `tcpmss' match, which allows you to examine the
-  MSS value of TCP SYN packets, which control the maximum packet size
-  for that connection.
-
-  If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `N'.
-
 LOG target support
 CONFIG_IP_NF_TARGET_LOG
   This option adds a `LOG' target, which allows you to create rules in
@@ -17190,27 +17181,6 @@
   SA-1100 based Victor Digital Talking Book Reader.  See
   http://www.visuaide.com/pagevictor.en.html for information on
   this system.
-
-Support ARM610 processor
-CONFIG_CPU_ARM6
-  Say Y here if you wish to include support for the ARM610 processor.
-
-Support ARM710 processor
-CONFIG_CPU_ARM7
-  Say Y here if you wish to include support for the ARM710 processor.
-
-Support StrongARM(R) SA-110 processor
-CONFIG_CPU_SA110
-  Say Y here if you wish to include support for the Intel(R)
-  StrongARM(R) SA-110 processor.
-
-Support ARM720 processor
-CONFIG_CPU_ARM720
-  Say Y here if you wish to include support for the ARM720 processor.
-
-Support ARM920
-CONFIG_CPU_ARM920
-  Say Y here if you wish to include support for the ARM920 processor.

 Support ARM610 processor
 CONFIG_CPU_ARM6

