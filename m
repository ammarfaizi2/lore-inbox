Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWBFWKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWBFWKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWBFWKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:10:51 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:48294 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932187AbWBFWKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:10:35 -0500
Message-ID: <43E7C9C4.5010700@openvz.org>
Date: Tue, 07 Feb 2006 01:12:20 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
CC: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, riel@redhat.com,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>
Subject: [PATCH 2/4] Virtualization/containers: CONFIG_CONTAINER
References: <43E7C65F.3050609@openvz.org>
In-Reply-To: <43E7C65F.3050609@openvz.org>
Content-Type: multipart/mixed;
 boundary="------------070905050604020007040209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070905050604020007040209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch simply adds CONFIG_CONTAINER option for 
virtualization/containerss functionality.
Per-resource config options can be added later if needed.

Signed-Off-By: Kirill Korotaev <dev@openvz.org>

Kirill

--------------070905050604020007040209
Content-Type: text/plain;
 name="diff-container-config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-container-config"

--- ./arch/alpha/Kconfig.vkconfig	2006-02-06 22:14:50.000000000 +0300
+++ ./arch/alpha/Kconfig	2006-02-06 23:26:35.000000000 +0300
@@ -621,6 +621,8 @@ source "arch/alpha/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/arm/Kconfig.vkconfig	2006-02-06 22:14:50.000000000 +0300
+++ ./arch/arm/Kconfig	2006-02-06 23:27:06.000000000 +0300
@@ -794,6 +794,8 @@ source "arch/arm/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/arm26/Kconfig.vkconfig	2006-02-06 22:14:51.000000000 +0300
+++ ./arch/arm26/Kconfig	2006-02-06 23:27:14.000000000 +0300
@@ -232,6 +232,8 @@ source "arch/arm26/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/cris/Kconfig.vkconfig	2006-02-06 22:14:51.000000000 +0300
+++ ./arch/cris/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -175,6 +175,8 @@ source "arch/cris/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/frv/Kconfig.vkconfig	2006-02-06 22:14:51.000000000 +0300
+++ ./arch/frv/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -341,6 +341,8 @@ source "arch/frv/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/h8300/Kconfig.vkconfig	2006-02-06 22:14:51.000000000 +0300
+++ ./arch/h8300/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -189,6 +189,8 @@ source "arch/h8300/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/i386/Kconfig.vkconfig	2006-02-06 22:15:14.000000000 +0300
+++ ./arch/i386/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -1072,6 +1072,8 @@ source "arch/i386/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/ia64/Kconfig.vkconfig	2006-01-03 06:21:10.000000000 +0300
+++ ./arch/ia64/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -463,4 +463,6 @@ source "arch/ia64/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
--- ./arch/m32r/Kconfig.vkconfig	2006-02-06 22:14:52.000000000 +0300
+++ ./arch/m32r/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -377,6 +377,8 @@ source "arch/m32r/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/m68k/Kconfig.vkconfig	2006-02-06 22:14:52.000000000 +0300
+++ ./arch/m68k/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -648,6 +648,8 @@ source "arch/m68k/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/m68knommu/Kconfig.vkconfig	2006-02-06 22:14:52.000000000 +0300
+++ ./arch/m68knommu/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -644,6 +644,8 @@ source "arch/m68knommu/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/mips/Kconfig.vkconfig	2006-02-06 22:14:52.000000000 +0300
+++ ./arch/mips/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -1811,6 +1811,8 @@ source "arch/mips/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/parisc/Kconfig.vkconfig	2006-02-06 22:15:14.000000000 +0300
+++ ./arch/parisc/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -210,6 +210,8 @@ source "arch/parisc/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/powerpc/Kconfig.vkconfig	2006-02-06 22:14:52.000000000 +0300
+++ ./arch/powerpc/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -975,4 +975,6 @@ config KEYS_COMPAT
 	depends on COMPAT && KEYS
 	default y
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
--- ./arch/ppc/Kconfig.vkconfig	2006-02-06 22:14:53.000000000 +0300
+++ ./arch/ppc/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -1396,4 +1396,6 @@ source "arch/ppc/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
--- ./arch/s390/Kconfig.vkconfig	2006-02-06 22:14:53.000000000 +0300
+++ ./arch/s390/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -470,6 +470,8 @@ source "arch/s390/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/sh/Kconfig.vkconfig	2006-02-06 22:14:53.000000000 +0300
+++ ./arch/sh/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -635,6 +635,8 @@ source "arch/sh/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/sh64/Kconfig.vkconfig	2006-02-06 22:14:53.000000000 +0300
+++ ./arch/sh64/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -272,6 +272,8 @@ source "arch/sh64/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/sparc/Kconfig.vkconfig	2006-02-06 22:14:53.000000000 +0300
+++ ./arch/sparc/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -286,6 +286,8 @@ source "arch/sparc/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/sparc64/Kconfig.vkconfig	2006-02-06 22:14:53.000000000 +0300
+++ ./arch/sparc64/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -395,6 +395,8 @@ source "arch/sparc64/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/um/Kconfig.vkconfig	2006-02-06 22:14:53.000000000 +0300
+++ ./arch/um/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -292,6 +292,8 @@ source "fs/Kconfig"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/v850/Kconfig.vkconfig	2006-02-06 22:14:54.000000000 +0300
+++ ./arch/v850/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -318,6 +318,8 @@ source "arch/v850/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/x86_64/Kconfig.vkconfig	2006-02-06 22:14:54.000000000 +0300
+++ ./arch/x86_64/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -604,6 +604,8 @@ source "arch/x86_64/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- ./arch/xtensa/Kconfig.vkconfig	2006-02-06 22:14:54.000000000 +0300
+++ ./arch/xtensa/Kconfig	2006-02-06 23:30:51.000000000 +0300
@@ -247,6 +247,8 @@ source "arch/xtensa/Kconfig.debug"
 
 source "security/Kconfig"
 
+source "kernel/Kconfig.container"
+
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
--- /dev/null	 23:22:33.000000000 +0300
+++ ./kernel/Kconfig.container	2006-02-06 23:22:33.000000000 +0300
@@ -0,0 +1,11 @@
+menu "Virtual Containers"
+
+config CONTAINER
+	bool "Virtual Containers support"
+	default n
+	help
+	  This option enables support of virtual linux containers,
+	  which can be used for creation of virtual environments,
+	  Virtual Private Servers, checkpointing, isolation and so on
+
+endmenu

--------------070905050604020007040209--

