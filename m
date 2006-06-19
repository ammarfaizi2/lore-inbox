Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWFSSnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWFSSnq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWFSSnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:43:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:12267 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932547AbWFSSn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:28 -0400
Message-Id: <20060619183406.465452000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:32 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org,
       Masato Noguchi <Masato.Noguchi@jp.sony.com>
Subject: [patch 17/20] spufs: fix Makefile for "make clean"
Content-Disposition: inline; filename=spufs-fix-clean-_dump.h.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masato Noguchi <Masato.Noguchi@jp.sony.com>

added spu_{save,restore}_dump.h to target of 'make clean'

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
 arch/powerpc/platforms/cell/spufs/Makefile |    1 +
 1 files changed, 1 insertion(+)

Index: powerpc.git/arch/powerpc/platforms/cell/spufs/Makefile
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/Makefile
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/Makefile
@@ -15,6 +15,7 @@ SPU_AFLAGS	:= -c -D__ASSEMBLY__ -I$(srct
 SPU_LDFLAGS	:= -N -Ttext=0x0
 
 $(obj)/switch.o: $(obj)/spu_save_dump.h $(obj)/spu_restore_dump.h
+clean-files := spu_save_dump.h spu_restore_dump.h
 
 # Compile SPU files
       cmd_spu_cc = $(SPU_CC) $(SPU_CFLAGS) -c -o $@ $<

--

