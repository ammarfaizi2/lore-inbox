Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVC1NmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVC1NmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVC1NlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:41:16 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:4783 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261782AbVC1N1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:27:06 -0500
Subject: [RFC/PATCH 9/17][Kdump] Kconfig for kdump
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Content-Type: multipart/mixed; boundary="=-Fyq8LRJmwB9NhUPcT2sf"
Date: Mon, 28 Mar 2005 18:57:03 +0530
Message-Id: <1112016423.4001.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Fyq8LRJmwB9NhUPcT2sf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-Fyq8LRJmwB9NhUPcT2sf
Content-Disposition: attachment; filename=crashdump-x86-kconfig.patch
Content-Type: text/x-patch; name=crashdump-x86-kconfig.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit



o config option CONFIG_CRASH_DUMP
o Made it dependent on HIGHMEM. This is required as capture kernel treats the
  previous kernel's memory as high memmory and stitches a PTE for accessing
  it.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-rc1-mm3-1M-root/arch/i386/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN arch/i386/Kconfig~crashdump-x86-kconfig arch/i386/Kconfig
--- linux-2.6.12-rc1-mm3-1M/arch/i386/Kconfig~crashdump-x86-kconfig	2005-03-27 18:35:43.000000000 +0530
+++ linux-2.6.12-rc1-mm3-1M-root/arch/i386/Kconfig	2005-03-27 18:35:43.000000000 +0530
@@ -955,6 +955,13 @@ config KEXEC
 	  support.  As of this writing the exact hardware interface is
 	  strongly in flux, so no good recommendation can be made.
 
+config CRASH_DUMP
+	bool "kernel crash dumps (EXPERIMENTAL)"
+	depends on EMBEDDED
+	depends on EXPERIMENTAL
+	depends on HIGHMEM
+	help
+	  Generate crash dump after being started by kexec.
 endmenu
 
 
_

--=-Fyq8LRJmwB9NhUPcT2sf--

