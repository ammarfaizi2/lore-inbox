Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTESTki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 15:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbTESTkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 15:40:37 -0400
Received: from zok.SGI.COM ([204.94.215.101]:3980 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263185AbTESTkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 15:40:36 -0400
Date: Mon, 19 May 2003 12:53:33 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] pull $CROSS_COMPILE from env. if present
Message-ID: <20030519195333.GC18426@sgi.com>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple patch to pull CROSS_COMPILE from the environment if it's
present, which makes it easier to compile the kernel with different
compiler versions and such.

Thanks,
Jesse


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1093  -> 1.1094 
#	            Makefile	1.406   -> 1.407  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/19	jbarnes@dec.engr.sgi.com	1.1094
# make CROSS_COMPILE come from an env. variable if present
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Mon May 19 12:49:12 2003
+++ b/Makefile	Mon May 19 12:49:12 2003
@@ -53,7 +53,7 @@
 HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
 HOSTCXXFLAGS	= -O2
 
-CROSS_COMPILE 	=
+CROSS_COMPILE 	?=
 
 # 	That's our default target when none is given on the command line
 #	Note that 'modules' will be added as a prerequisite as well, 
