Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbUC2MQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbUC2MQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:16:11 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:52150 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262843AbUC2MNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:13:51 -0500
Date: Mon, 29 Mar 2004 04:13:11 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT: remove emulation of obsolete cpumask macros
 [7/22]
Message-Id: <20040329041311.110ef37b.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_7_of_22 - Remove obsolete cpumask emulation from cpumask.h
	Now that the emulation of the obsolete cpumask macros is no
	longer needed, remove it from cpumask.h

diffstat Patch_7_of_22:
 cpumask.h |   12 ------------
 1 files changed, 12 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1712  -> 1.1713 
#	include/linux/cpumask.h	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/28	pj@sgi.com	1.1713
# Remove obsolete cpumask operator emulation, once no longer in use
# by any of the arch's: i386, ppc64, or x86_64.
# --------------------------------------------
#
diff -Nru a/include/linux/cpumask.h b/include/linux/cpumask.h
--- a/include/linux/cpumask.h	Mon Mar 29 01:03:38 2004
+++ b/include/linux/cpumask.h	Mon Mar 29 01:03:38 2004
@@ -147,16 +147,4 @@
 
 #endif
 
-/* Begin obsolete cpumask operator emulation */
-#define cpu_isset_const(a,b) cpu_isset(a,b)
-#define cpumask_const_t cpumask_t
-#define cpus_coerce(m) (cpus_raw(m)[0])
-#define cpus_coerce_const cpus_coerce
-#define cpus_promote(x) ({ cpumask_t m; m._m[0] = x; m; })
-#define cpus_weight_const cpus_weight
-#define first_cpu_const first_cpu
-#define mk_cpumask_const(x) x
-#define next_cpu_const next_cpu
-/* End of obsolete cpumask operator emulation */
-
 #endif /* __LINUX_CPUMASK_H */


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
