Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319229AbSH2PXG>; Thu, 29 Aug 2002 11:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319231AbSH2PXG>; Thu, 29 Aug 2002 11:23:06 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:1985 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S319229AbSH2PXE>; Thu, 29 Aug 2002 11:23:04 -0400
Date: Thu, 29 Aug 2002 08:27:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: kraxel@bytesex.org
Subject: [TRIVIAL][PATCH] Look at drivers/media/Config.in after fs/Config.in
Message-ID: <20020829152718.GF22875@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, CONFIG_VIDEO_PROC_FS depends on CONFIG_PROC_FS, but in all
arches which look at drivers/media/Config.in, it comes before
fs/Config.in, so bad things could happen.  The following patch makes
sure that on all arches, fs/Config.in comes before
drivers/media/Config.in

This patch was previously in the trivial patch monkey system, but got
rejected due to an ia64 update, and I didn't get a chance to re-submit
this before the other change made its way into Linus' tree.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/alpha/config.in 1.29 vs edited =====
--- 1.29/arch/alpha/config.in	Wed Aug 28 11:16:05 2002
+++ edited/arch/alpha/config.in	Thu Aug 29 08:08:46 2002
@@ -343,9 +343,9 @@
 
 #source drivers/misc/Config.in
 
-source drivers/media/Config.in
-
 source fs/Config.in
+
+source drivers/media/Config.in
 
 if [ "$CONFIG_VT" = "y" ]; then
   mainmenu_option next_comment
===== arch/arm/config.in 1.38 vs edited =====
--- 1.38/arch/arm/config.in	Mon Jul 15 09:54:04 2002
+++ edited/arch/arm/config.in	Thu Aug 29 08:08:47 2002
@@ -594,9 +594,9 @@
    fi
 fi
 
-source drivers/media/Config.in
-
 source fs/Config.in
+
+source drivers/media/Config.in
 
 if [ "$CONFIG_VT" = "y" ]; then
    mainmenu_option next_comment
===== arch/cris/config.in 1.17 vs edited =====
--- 1.17/arch/cris/config.in	Tue Aug 13 03:01:05 2002
+++ edited/arch/cris/config.in	Thu Aug 29 08:08:47 2002
@@ -202,9 +202,9 @@
 
 #source drivers/misc/Config.in
 
-source drivers/media/Config.in
-
 source fs/Config.in
+
+source drivers/media/Config.in
 
 mainmenu_option next_comment
 comment 'Sound'
===== arch/i386/config.in 1.46 vs edited =====
--- 1.46/arch/i386/config.in	Tue Aug 13 03:01:37 2002
+++ edited/arch/i386/config.in	Thu Aug 29 08:08:48 2002
@@ -370,9 +370,9 @@
 
 #source drivers/misc/Config.in
 
-source drivers/media/Config.in
-
 source fs/Config.in
+
+source drivers/media/Config.in
 
 if [ "$CONFIG_VT" = "y" ]; then
    mainmenu_option next_comment
===== arch/ia64/config.in 1.30 vs edited =====
--- 1.30/arch/ia64/config.in	Tue Aug 13 03:25:11 2002
+++ edited/arch/ia64/config.in	Thu Aug 29 08:09:35 2002
@@ -185,7 +185,6 @@
 
   #source drivers/misc/Config.in
 
-  source drivers/media/Config.in
 else # HP_SIM
 
   mainmenu_option next_comment
@@ -201,6 +200,7 @@
 fi # HP_SIM
 
 source fs/Config.in
+source drivers/media/Config.in
 
 if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
   if [ "$CONFIG_VT" = "y" ]; then
===== arch/mips/config.in 1.19 vs edited =====
--- 1.19/arch/mips/config.in	Wed Aug 28 11:16:05 2002
+++ edited/arch/mips/config.in	Thu Aug 29 08:08:48 2002
@@ -393,8 +393,6 @@
 
 source drivers/char/Config.in
 
-source drivers/media/Config.in
-
 if [ "$CONFIG_DECSTATION" = "y" ]; then
    mainmenu_option next_comment
    comment 'DECStation Character devices'
@@ -448,6 +446,8 @@
 fi
 
 source fs/Config.in
+
+source drivers/media/Config.in
 
 if [ "$CONFIG_VT" = "y" ]; then
    mainmenu_option next_comment
===== arch/mips64/config.in 1.18 vs edited =====
--- 1.18/arch/mips64/config.in	Wed Aug 28 11:16:05 2002
+++ edited/arch/mips64/config.in	Thu Aug 29 08:08:49 2002
@@ -195,9 +195,9 @@
 
 #source drivers/misc/Config.in
 
-source drivers/media/Config.in
-
 source fs/Config.in
+
+source drivers/media/Config.in
 
 if [ "$CONFIG_VT" = "y" ]; then
    mainmenu_option next_comment
===== arch/ppc/config.in 1.41 vs edited =====
--- 1.41/arch/ppc/config.in	Wed Aug 21 13:30:24 2002
+++ edited/arch/ppc/config.in	Thu Aug 29 08:08:49 2002
@@ -548,9 +548,9 @@
 
 source drivers/char/Config.in
 
-source drivers/media/Config.in
-
 source fs/Config.in
+
+source drivers/media/Config.in
 
 mainmenu_option next_comment
 comment 'Sound'
===== arch/ppc64/config.in 1.15 vs edited =====
--- 1.15/arch/ppc64/config.in	Tue Aug 13 03:43:48 2002
+++ edited/arch/ppc64/config.in	Thu Aug 29 08:08:49 2002
@@ -192,9 +192,9 @@
 
 source drivers/char/Config.in
 
-source drivers/media/Config.in
-
 source fs/Config.in
+
+source drivers/media/Config.in
 
 mainmenu_option next_comment
 comment 'Sound'
===== arch/x86_64/config.in 1.14 vs edited =====
--- 1.14/arch/x86_64/config.in	Sun Aug 25 15:42:58 2002
+++ edited/arch/x86_64/config.in	Thu Aug 29 08:08:50 2002
@@ -183,9 +183,9 @@
 
 source drivers/misc/Config.in
 
-source drivers/media/Config.in
-
 source fs/Config.in
+
+source drivers/media/Config.in
 
 if [ "$CONFIG_VT" = "y" ]; then
    mainmenu_option next_comment
