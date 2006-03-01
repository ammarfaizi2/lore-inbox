Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWB1XYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWB1XYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWB1XYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:24:13 -0500
Received: from fmr21.intel.com ([143.183.121.13]:3799 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932606AbWB1XYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:24:12 -0500
Message-Id: <20060301001722.746570000@araj-sfield>
References: <20060301001557.318047000@araj-sfield>
Date: Tue, 28 Feb 2006 16:15:59 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Ashok Raj <ashok.raj@intel.com>
Subject: [patch 2/5] Remove unnecessary lapic definition from acpidef.h
Content-Disposition: inline; filename=remove-unused-lapic-entry
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dont know why this exists... just happened to trip me when i used a 
variable name with lapic, and until i looked at the pre-processed
output couldnt figure out we had a lame definition like this.

Hope iam not breaking anything here..

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
------------------------------------------------
 include/asm-i386/apicdef.h   |    1 -
 include/asm-x86_64/apicdef.h |    2 --
 2 files changed, 3 deletions(-)

Index: linux-2.6.16-rc1-mm4/include/asm-i386/apicdef.h
===================================================================
--- linux-2.6.16-rc1-mm4.orig/include/asm-i386/apicdef.h
+++ linux-2.6.16-rc1-mm4/include/asm-i386/apicdef.h
@@ -120,7 +120,6 @@
  */
 #define u32 unsigned int
 
-#define lapic ((volatile struct local_apic *)APIC_BASE)
 
 struct local_apic {
 
Index: linux-2.6.16-rc1-mm4/include/asm-x86_64/apicdef.h
===================================================================
--- linux-2.6.16-rc1-mm4.orig/include/asm-x86_64/apicdef.h
+++ linux-2.6.16-rc1-mm4/include/asm-x86_64/apicdef.h
@@ -136,8 +136,6 @@
  */
 #define u32 unsigned int
 
-#define lapic ((volatile struct local_apic *)APIC_BASE)
-
 struct local_apic {
 
 /*000*/	struct { u32 __reserved[4]; } __reserved_01;

--

