Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTEZWZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTEZWYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:24:53 -0400
Received: from hera.cwi.nl ([192.16.191.8]:29858 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262299AbTEZWKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:10:38 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 27 May 2003 00:23:49 +0200 (MEST)
Message-Id: <UTC200305262223.h4QMNns14086.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [patch] kill lvm from x86_64
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BLK_DEV_LVM is gone, but there is still some associated code.
This is the x86_64 part.

diff -u --recursive --new-file -X /linux/dontdiff a/arch/x86_64/ia32/ia32_ioctl.c b/arch/x86_64/ia32/ia32_ioctl.c
--- a/arch/x86_64/ia32/ia32_ioctl.c	Tue May 27 00:31:01 2003
+++ b/arch/x86_64/ia32/ia32_ioctl.c	Tue May 27 00:58:10 2003
@@ -3196,22 +3196,6 @@
 HANDLE_IOCTL(SONET_SETFRAMING, do_atm_ioctl)
 HANDLE_IOCTL(SONET_GETFRAMING, do_atm_ioctl)
 HANDLE_IOCTL(SONET_GETFRSENSE, do_atm_ioctl)
-#if defined(CONFIG_BLK_DEV_LVM) || defined(CONFIG_BLK_DEV_LVM_MODULE)
-HANDLE_IOCTL(VG_STATUS, do_lvm_ioctl)
-HANDLE_IOCTL(VG_CREATE, do_lvm_ioctl)
-HANDLE_IOCTL(VG_EXTEND, do_lvm_ioctl)
-HANDLE_IOCTL(LV_CREATE, do_lvm_ioctl)
-HANDLE_IOCTL(LV_REMOVE, do_lvm_ioctl)
-HANDLE_IOCTL(LV_EXTEND, do_lvm_ioctl)
-HANDLE_IOCTL(LV_REDUCE, do_lvm_ioctl)
-HANDLE_IOCTL(LV_RENAME, do_lvm_ioctl)
-HANDLE_IOCTL(LV_STATUS_BYNAME, do_lvm_ioctl)
-HANDLE_IOCTL(LV_STATUS_BYINDEX, do_lvm_ioctl)
-HANDLE_IOCTL(PV_CHANGE, do_lvm_ioctl)
-HANDLE_IOCTL(PV_STATUS, do_lvm_ioctl)
-HANDLE_IOCTL(VG_CREATE_OLD, do_lvm_ioctl)
-HANDLE_IOCTL(LV_STATUS_BYDEV, do_lvm_ioctl)
-#endif /* LVM */
 /* VFAT */
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_BOTH32, vfat_ioctl32)
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_SHORT32, vfat_ioctl32)
