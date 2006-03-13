Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWCMWBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWCMWBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWCMWBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:01:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27919 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932488AbWCMWBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:01:22 -0500
Date: Mon, 13 Mar 2006 23:01:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       Jon Mason <jdmason@us.ibm.com>
Subject: [2.6 patch] x86-64: fix double definition of force_iommu
Message-ID: <20060313220120.GN13973@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Mason <jdmason@us.ibm.com>

This fixes a double definition of force_iommu, and moves no_iommu to be
with the rest of the IOMMU variables.

Signed-off-by: Jon Mason <jdmason@us.ibm.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Jon Mason on:
- 28 Feb 2006

--- a/include/asm-x86_64/proto.h	Tue Feb 28 22:02:10 2006
+++ b/include/asm-x86_64/proto.h	Tue Feb 28 18:40:04 2006
@@ -109,7 +109,6 @@
 extern unsigned long table_start, table_end;
 
 extern int exception_trace;
-extern int force_iommu, no_iommu;
 extern int using_apic_timer;
 extern int disable_apic;
 extern unsigned cpu_khz;
@@ -130,6 +129,7 @@
 #define iommu_aperture_allowed 0
 #endif
 extern int force_iommu;
+extern int no_iommu;
 
 extern int reboot_force;
 extern int notsc_setup(char *);
