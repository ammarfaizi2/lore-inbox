Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTISGDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 02:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTISGDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 02:03:10 -0400
Received: from fmr99.intel.com ([192.55.52.32]:488 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S261351AbTISGDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 02:03:07 -0400
Subject: [TRIVIAL PATCH] generating cscope.files when 'make cscope'
From: Louis Zhuang <louis.zhuang@linux.co.intel.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Intel Crop.
Message-Id: <1063951260.23172.3.camel@hawk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Sep 2003 14:01:00 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kai,
	The following trivial patch will generate cscope.files as well as
cscope.out. This will help cscope plug-in for emacs. Pls apply if you
like it.
-- 
Yours truly,
Louis Zhuang
--------------------------------------------------------------------------------
Software is a process, not a static entity. It is becoming, rather that being.
It can easily be bad, but never be perfect. Its essence is eternal refactoring.
  - Inspired by Judge William H. Hastie

My words are my own...

--------------------------------------------------------------------------------
Fault Injection Test Harness Project
BK tree: http://fault-injection.bkbits.net/linux-2.5
Home Page: http://sf.net/projects/fault-injection

Open HPI Project
Home Page: http://sf.net/projects/openhpi

===== Makefile 1.427 vs edited =====
--- 1.427/Makefile	Tue Sep  9 03:45:42 2003
+++ edited/Makefile	Fri Sep 19 13:53:59 2003
@@ -672,7 +672,7 @@
 	.menuconfig.log \
 	include/asm \
 	.hdepend include/linux/modversions.h \
-	tags TAGS cscope kernel.spec \
+	tags TAGS cscope.out cscope.files kernel.spec \
 	.tmp*
 
 # Directories removed with 'make mrproper'
@@ -731,7 +731,7 @@
 endef
 
 quiet_cmd_cscope = MAKE   $@
-cmd_cscope = $(all-sources) | cscope -k -b -i -
+cmd_cscope = $(all-sources) > cscope.files ; cscope -k -b
 
 quiet_cmd_TAGS = MAKE   $@
 cmd_TAGS = $(all-sources) | etags -


