Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTEZWE4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTEZWE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:04:56 -0400
Received: from hera.cwi.nl ([192.16.191.8]:36769 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262268AbTEZWEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:04:53 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 27 May 2003 00:18:03 +0200 (MEST)
Message-Id: <UTC200305262218.h4QMI3I11185.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [patch] kill lvm from compat_ioctl.h
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BLK_DEV_LVM is gone, but there is still some associated code.
This is the include/linux/compat_ioctl.h part.

diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/compat_ioctl.h b/include/linux/compat_ioctl.h
--- a/include/linux/compat_ioctl.h	Thu May 22 13:16:24 2003
+++ b/include/linux/compat_ioctl.h	Tue May 27 01:12:14 2003
@@ -539,28 +539,6 @@
 COMPATIBLE_IOCTL(ATMTCP_REMOVE)
 COMPATIBLE_IOCTL(ATMMPC_CTRL)
 COMPATIBLE_IOCTL(ATMMPC_DATA)
-#if defined(CONFIG_BLK_DEV_LVM) || defined(CONFIG_BLK_DEV_LVM_MODULE)
-/* 0xfe - lvm */
-COMPATIBLE_IOCTL(VG_SET_EXTENDABLE)
-COMPATIBLE_IOCTL(VG_STATUS_GET_COUNT)
-COMPATIBLE_IOCTL(VG_STATUS_GET_NAMELIST)
-COMPATIBLE_IOCTL(VG_REMOVE)
-COMPATIBLE_IOCTL(VG_RENAME)
-COMPATIBLE_IOCTL(VG_REDUCE)
-COMPATIBLE_IOCTL(PE_LOCK_UNLOCK)
-COMPATIBLE_IOCTL(PV_FLUSH)
-COMPATIBLE_IOCTL(LVM_LOCK_LVM)
-COMPATIBLE_IOCTL(LVM_GET_IOP_VERSION)
-#ifdef LVM_TOTAL_RESET
-COMPATIBLE_IOCTL(LVM_RESET)
-#endif
-COMPATIBLE_IOCTL(LV_SET_ACCESS)
-COMPATIBLE_IOCTL(LV_SET_STATUS)
-COMPATIBLE_IOCTL(LV_SET_ALLOCATION)
-COMPATIBLE_IOCTL(LE_REMAP)
-COMPATIBLE_IOCTL(LV_BMAP)
-COMPATIBLE_IOCTL(LV_SNAPSHOT_USE_RATE)
-#endif /* LVM */
 #if defined(CONFIG_DRM) || defined(CONFIG_DRM_MODULE)
 COMPATIBLE_IOCTL(DRM_IOCTL_GET_MAGIC)
 COMPATIBLE_IOCTL(DRM_IOCTL_IRQ_BUSID)
