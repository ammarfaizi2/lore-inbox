Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317905AbSGWAhs>; Mon, 22 Jul 2002 20:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317900AbSGWAgw>; Mon, 22 Jul 2002 20:36:52 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:8196 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317892AbSGWAgT>;
	Mon, 22 Jul 2002 20:36:19 -0400
Date: Mon, 22 Jul 2002 17:39:35 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM changes for 2.5.27
Message-ID: <20020723003935.GD660@kroah.com>
References: <20020723003702.GA660@kroah.com> <20020723003806.GB660@kroah.com> <20020723003905.GC660@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020723003905.GC660@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 24 Jun 2002 23:35:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683.1.1 -> 1.683.1.2
#	  arch/ppc/config.in	1.36    -> 1.37   
#	arch/sparc/config.in	1.15    -> 1.16   
#	arch/s390x/config.in	1.8     -> 1.9    
#	arch/mips64/config.in	1.13    -> 1.14   
#	arch/ppc64/config.in	1.9     -> 1.10   
#	  arch/arm/config.in	1.35    -> 1.36   
#	arch/alpha/config.in	1.22    -> 1.23   
#	arch/x86_64/config.in	1.10    -> 1.11   
#	 arch/s390/config.in	1.9     -> 1.10   
#	arch/sparc64/config.in	1.29    -> 1.30   
#	   arch/sh/config.in	1.11    -> 1.12   
#	 arch/cris/config.in	1.15    -> 1.16   
#	 arch/mips/config.in	1.13    -> 1.14   
#	 arch/m68k/config.in	1.14    -> 1.15   
#	arch/parisc/config.in	1.8     -> 1.9    
#	 arch/ia64/config.in	1.23    -> 1.24   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/22	greg@kroah.com	1.683.1.2
# LSM: fixed up all of the other archs (non i386) to include the security config menu.
# --------------------------------------------
#
diff -Nru a/arch/alpha/config.in b/arch/alpha/config.in
--- a/arch/alpha/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/alpha/config.in	Mon Jul 22 17:26:04 2002
@@ -393,4 +393,5 @@
 
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/arm/config.in b/arch/arm/config.in
--- a/arch/arm/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/arm/config.in	Mon Jul 22 17:26:04 2002
@@ -658,4 +658,5 @@
 dep_bool '    Kernel low-level debugging messages via UART2' CONFIG_DEBUG_CLPS711X_UART2 $CONFIG_DEBUG_LL $CONFIG_ARCH_CLPS711X
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/cris/config.in b/arch/cris/config.in
--- a/arch/cris/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/cris/config.in	Mon Jul 22 17:26:04 2002
@@ -228,5 +228,7 @@
   int ' Profile shift count' CONFIG_PROFILE_SHIFT 2
 fi
 
-source lib/Config.in
 endmenu
+
+source security/Config.in
+source lib/Config.in
diff -Nru a/arch/ia64/config.in b/arch/ia64/config.in
--- a/arch/ia64/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/ia64/config.in	Mon Jul 22 17:26:04 2002
@@ -263,3 +263,5 @@
 fi
 
 endmenu
+
+source security/Config.in
diff -Nru a/arch/m68k/config.in b/arch/m68k/config.in
--- a/arch/m68k/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/m68k/config.in	Mon Jul 22 17:26:04 2002
@@ -549,4 +549,5 @@
 
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/mips/config.in b/arch/mips/config.in
--- a/arch/mips/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/mips/config.in	Mon Jul 22 17:26:04 2002
@@ -503,4 +503,5 @@
 fi
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/mips64/config.in b/arch/mips64/config.in
--- a/arch/mips64/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/mips64/config.in	Mon Jul 22 17:26:04 2002
@@ -248,4 +248,5 @@
 fi
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/parisc/config.in b/arch/parisc/config.in
--- a/arch/parisc/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/parisc/config.in	Mon Jul 22 17:26:04 2002
@@ -200,4 +200,5 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/ppc/config.in b/arch/ppc/config.in
--- a/arch/ppc/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/ppc/config.in	Mon Jul 22 17:26:04 2002
@@ -628,3 +628,6 @@
    bool 'Support for early boot texts over serial port' CONFIG_SERIAL_TEXT_DEBUG
 fi
 endmenu
+
+source security/Config.in
+
diff -Nru a/arch/ppc64/config.in b/arch/ppc64/config.in
--- a/arch/ppc64/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/ppc64/config.in	Mon Jul 22 17:26:04 2002
@@ -220,4 +220,5 @@
 fi
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/s390/config.in b/arch/s390/config.in
--- a/arch/s390/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/s390/config.in	Mon Jul 22 17:26:04 2002
@@ -75,4 +75,5 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/s390x/config.in b/arch/s390x/config.in
--- a/arch/s390x/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/s390x/config.in	Mon Jul 22 17:26:04 2002
@@ -78,4 +78,5 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/sh/config.in b/arch/sh/config.in
--- a/arch/sh/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/sh/config.in	Mon Jul 22 17:26:04 2002
@@ -369,4 +369,5 @@
 fi
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/sparc/config.in b/arch/sparc/config.in
--- a/arch/sparc/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/sparc/config.in	Mon Jul 22 17:26:04 2002
@@ -242,4 +242,5 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/sparc64/config.in b/arch/sparc64/config.in
--- a/arch/sparc64/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/sparc64/config.in	Mon Jul 22 17:26:04 2002
@@ -293,4 +293,5 @@
 
 endmenu
 
+source security/Config.in
 source lib/Config.in
diff -Nru a/arch/x86_64/config.in b/arch/x86_64/config.in
--- a/arch/x86_64/config.in	Mon Jul 22 17:26:04 2002
+++ b/arch/x86_64/config.in	Mon Jul 22 17:26:04 2002
@@ -229,4 +229,5 @@
 fi
 endmenu
 
+source security/Config.in
 source lib/Config.in
