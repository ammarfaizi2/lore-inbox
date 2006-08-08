Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWHHIX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWHHIX3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWHHIX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:23:29 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:13268 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932566AbWHHIX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:23:28 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       ebiederm@xmission.com
Message-Id: <20060808082509.359.32542.sendpatchset@cherry.local>
Subject: [PATCH] i386: CONFIG_RELOCATABLE clean fix
Date: Tue,  8 Aug 2006 17:24:13 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386: CONFIG_RELOCATABLE clean fix

vmlinux.bin.all and vmlinux.relocs should be removed by the clean rule.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 This patch applies on top of Eric W. Biedermans CONFIG_RELOCATABLE tree

 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- 0001/arch/i386/boot/compressed/Makefile
+++ work/arch/i386/boot/compressed/Makefile	2006-08-07 12:47:00.000000000 +0900
@@ -4,7 +4,8 @@
 # create a compressed vmlinux image from the original vmlinux
 #
 
-targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
+targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o \
+		   vmlinux.bin.all vmlinux.relocs
 EXTRA_AFLAGS	:= -traditional
 
 LDFLAGS_vmlinux := -T
