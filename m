Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932737AbWCAAqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbWCAAqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWCAAqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:46:13 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:64668 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932737AbWCAAqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:46:13 -0500
Date: Tue, 28 Feb 2006 18:45:50 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: ak@muc.de
Cc: mulix@mulix.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86-64: double definition of force_iommu in include/asm-x86_64/proto.h
Message-ID: <20060301004550.GA14656@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a double definition of force_iommu, and moves no_iommu to be
with the rest of the IOMMU variables.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 149aa2a22913 include/asm-x86_64/proto.h
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
