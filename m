Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbTIJTXi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265609AbTIJTVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:21:18 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:51980 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265605AbTIJTS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:18:26 -0400
Date: Wed, 10 Sep 2003 21:18:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: kbuild: Remove cscope.out during make mrproper
Message-ID: <20030910191824.GD5604@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
References: <20030910191411.GA5517@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910191411.GA5517@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1271  -> 1.1272 
#	            Makefile	1.428   -> 1.429  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/10	sam@mars.ravnborg.org	1.1272
# kbuild: Remove cscope.out during make mrproper
# 
# From: "Nathan T. Lynch" <ntl@pobox.com>
# 
# The attached patch fixes the toplevel Makefile to remove cscope.out
# during make mrproper.  The default name for the database that cscope
# creates is cscope.out, and this is what the cscope rule in the
# makefile uses.  Currently, mrproper will leave cscope.out behind,
# which can make for interesting diffs...
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Wed Sep 10 21:15:47 2003
+++ b/Makefile	Wed Sep 10 21:15:47 2003
@@ -675,7 +675,7 @@
 	.menuconfig.log \
 	include/asm \
 	.hdepend include/linux/modversions.h \
-	tags TAGS cscope kernel.spec \
+	tags TAGS cscope.out kernel.spec \
 	.tmp*
 
 # Directories removed with 'make mrproper'
