Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSFPLwR>; Sun, 16 Jun 2002 07:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316192AbSFPLwQ>; Sun, 16 Jun 2002 07:52:16 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:29937 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S316187AbSFPLwP>; Sun, 16 Jun 2002 07:52:15 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: torvalds@transmeta.com
Subject: [trivial patch] config cleanup - software suspend
Date: Sun, 16 Jun 2002 21:49:03 +1000
User-Agent: KMail/1.4.5
Cc: pavel@ucw.cz, trivial@rustcorp.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_RHRS3OV1IK099MYQQT99"
Message-Id: <200206162149.03250.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_RHRS3OV1IK099MYQQT99
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Please find enclosed a trivial patch that moves the Software Suspend 
configuration option into the new power management menu, which is where 
(IMNSHO) it belongs.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
--------------Boundary-00=_RHRS3OV1IK099MYQQT99
Content-Type: text/x-diff;
  charset="us-ascii";
  name="swsusp-config-16062002.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="swsusp-config-16062002.patch"

diff -Naur -X dontdiff linux-2.5.21/arch/i386/config.in linux-2.5.21-config-pm/arch/i386/config.in
--- linux-2.5.21/arch/i386/config.in	Sun Jun  9 15:28:47 2002
+++ linux-2.5.21-config-pm/arch/i386/config.in	Sun Jun 16 21:39:58 2002
@@ -225,6 +225,8 @@
    bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
 fi
 
+dep_mbool 'Software Suspend (EXPERIMENTAL)' CONFIG_SOFTWARE_SUSPEND $CONFIG_PM $CONFIG_EXPERIMENTAL
+
 endmenu
 
 mainmenu_option next_comment
@@ -405,10 +407,6 @@
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-   dep_bool 'Software Suspend' CONFIG_SOFTWARE_SUSPEND $CONFIG_PM
-fi
-
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB

--------------Boundary-00=_RHRS3OV1IK099MYQQT99--

