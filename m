Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWCGBk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWCGBk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbWCGBk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:40:28 -0500
Received: from fmr18.intel.com ([134.134.136.17]:35985 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752064AbWCGBk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:40:27 -0500
Subject: [PATCH]cpuid.4 doesn't need cpu level 5
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 09:39:31 +0800
Message-Id: <1141695571.19013.23.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Detecting cache line using cpuid.4, cpuid level 4 is enough.

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.16-rc5-root/arch/i386/kernel/cpu/intel_cacheinfo.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/kernel/cpu/intel_cacheinfo.c~cpuid4 arch/i386/kernel/cpu/intel_cacheinfo.c
--- linux-2.6.16-rc5/arch/i386/kernel/cpu/intel_cacheinfo.c~cpuid4	2006-03-05 07:41:36.000000000 +0800
+++ linux-2.6.16-rc5-root/arch/i386/kernel/cpu/intel_cacheinfo.c	2006-03-05 07:42:45.000000000 +0800
@@ -174,7 +174,7 @@ unsigned int __cpuinit init_intel_cachei
 	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
 	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
 
-	if (c->cpuid_level > 4) {
+	if (c->cpuid_level > 3) {
 		static int is_initialized;
 
 		if (is_initialized == 0) {
_


