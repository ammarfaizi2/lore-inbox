Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUHIOzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUHIOzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUHIOyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:54:23 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:64782 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S266686AbUHIOtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:49:07 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] apm_info.disabled
Date: Mon, 9 Aug 2004 16:48:57 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Z74FBt4DIBSvc66"
Message-Id: <200408091648.57596.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Z74FBt4DIBSvc66
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_Z74FBt4DIBSvc66
Content-Type: text/x-diff;
  charset="utf-8";
  name="2.6.x-apm-disabled.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.x-apm-disabled.patch"

--- linux-2.6.8-rc3/arch/i386/kernel/apm.c.orig	2004-08-09 11:09:31.000000000 +0200
+++ linux-2.6.8-rc3/arch/i386/kernel/apm.c	2004-08-09 16:29:51.085575808 +0200
@@ -2271,10 +2271,12 @@
 	}
 	if ((num_online_cpus() > 1) && !power_off && !smp) {
 		printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
+		apm_info.disabled = 1;
 		return -ENODEV;
 	}
 	if (PM_IS_ACTIVE()) {
 		printk(KERN_NOTICE "apm: overridden by ACPI.\n");
+		apm_info.disabled = 1;
 		return -ENODEV;
 	}
 	pm_active = 1;

--Boundary-00=_Z74FBt4DIBSvc66--
