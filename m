Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271716AbTGROvb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271723AbTGROs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:48:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31621
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271807AbTGROMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:12:24 -0400
Date: Fri, 18 Jul 2003 15:26:44 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181426.h6IEQiCd017826@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix make rpm versioning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/Makefile linux-2.6.0-test1-ac2/Makefile
--- linux-2.6.0-test1/Makefile	2003-07-14 14:11:55.000000000 +0100
+++ linux-2.6.0-test1-ac2/Makefile	2003-07-14 14:55:04.000000000 +0100
@@ -781,7 +781,8 @@
 	tar -cvz $(RCS_TAR_IGNORE) -f $(KERNELPATH).tar.gz $(KERNELPATH)/. ; \
 	rm $(KERNELPATH) ; \
 	cd $(TOPDIR) ; \
-	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > .version ; \
+	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > .tmp_version ; \
+	mv -f .tmp_version .version; \
 	$(RPM) -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
 	rm $(TOPDIR)/../$(KERNELPATH).tar.gz
 
