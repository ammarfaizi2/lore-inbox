Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263481AbUJ2WZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbUJ2WZB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263498AbUJ2WYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:24:02 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:13974 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263553AbUJ2WJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:09:20 -0400
Message-Id: <200410292209.i9TM937o014943@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.7.1.1 10/09/2004 with nmh-1.1
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 1/1] ppc64 install outside of source tree
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Oct 2004 17:09:03 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sam, 
please apply.  Having been using this for a while.

Name: arch/ppc64/boot install outside of source tree

Rationale:
	When building outside source tree, install.sh is looked for in the 
        obj side.

Status:  tested on ppc64 builds

Signed-off-by: Doug Maxey <dwm@austin.ibm.com>

ChangeLog:
* have ppc64 ability to run install.sh from build outside srctree.

++doug
IBM Linux Technology Center

===== arch/ppc64/boot/Makefile 1.25 vs edited =====
--- 1.25/arch/ppc64/boot/Makefile	2004-10-03 12:23:50 -05:00
+++ edited/arch/ppc64/boot/Makefile	2004-10-11 14:15:58 -05:00
@@ -118,6 +118,6 @@
 		>> $(obj)/imagesize.c
 
 install: $(CONFIGURE) $(obj)/$(BOOTIMAGE)
-	sh -x $(src)/install.sh "$(KERNELRELEASE)" "$(obj)/$(BOOTIMAGE)" "$(INSTALL_PATH)"
+	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" "$(obj)/$(BOOTIMAGE)" "$(INSTALL_PATH)"
 
 clean-files := $(addprefix $(objtree)/, $(obj-boot) vmlinux.strip)


