Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbUAPHEz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 02:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUAPHEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 02:04:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39598 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265303AbUAPHEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 02:04:54 -0500
Date: Thu, 15 Jan 2004 23:04:49 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Patchlet for arch help in 2.6.1 s390
Message-Id: <20040115230449.1b76d950.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.1-mm3/arch/s390/Makefile	2004-01-09 01:59:10.000000000 -0500
+++ linux-2.6.1-mm3-s390/arch/s390/Makefile	2004-01-15 22:00:50.000000000 -0500
@@ -70,3 +70,8 @@
 	$(call filechk,gen-asm-offsets)
 
 CLEAN_FILES += include/asm-$(ARCH)/offsets.h
+
+# Don't use tabs in echo arguments.
+define archhelp
+  echo  '* image           - Kernel image for IPL ($(boot)/image)'
+endef
