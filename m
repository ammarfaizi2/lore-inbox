Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267373AbTAGNEL>; Tue, 7 Jan 2003 08:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbTAGNEL>; Tue, 7 Jan 2003 08:04:11 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:17623 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S267373AbTAGNEK>; Tue, 7 Jan 2003 08:04:10 -0500
Date: Tue, 7 Jan 2003 15:12:43 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: module_text_address() defined but not used in module.h
Message-ID: <20030107131243.GJ25540@alhambra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

module_text_address() is defined as 'static int ...' if modules are
not configured in in module.h, leading to a compiler warning that it
is defined but not used. Make it static inline. Patch against
2.5.54-bk. 

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.975   -> 1.976  
#	include/linux/module.h	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/07	mulix@alhambra.mulix.org	1.976
# fix 'defined but not used' warning
# --------------------------------------------
#
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Tue Jan  7 14:18:37 2003
+++ b/include/linux/module.h	Tue Jan  7 14:18:37 2003
@@ -328,7 +328,7 @@
 }
 
 /* Is this address in a module? */
-static int module_text_address(unsigned long addr)
+static inline int module_text_address(unsigned long addr)
 {
 	return 0;
 }

-- 
Muli Ben-Yehuda

my opinions may seem crazy. But they all make sense. Insane sense, but
sense nontheless. -- Shlomi Fish on #offtopic.

