Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUGBKyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUGBKyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 06:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUGBKyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 06:54:00 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:206 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262060AbUGBKxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 06:53:09 -0400
Date: Fri, 2 Jul 2004 03:52:11 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>, Sylvain <sylvain.jeaugey@bull.net>,
       Dan Higgins <djh@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Simon <Simon.Derr@bull.net>, Dimitri Sivanich <sivanich@sgi.com>
Message-Id: <20040702105214.15684.8490.91938@sam.engr.sgi.com>
In-Reply-To: <20040702105147.15684.22242.27912@sam.engr.sgi.com>
References: <20040702105147.15684.22242.27912@sam.engr.sgi.com>
Subject: [patch 3/8] cpusets v4 - cpumask_t - additional const qualifiers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The remainder of the const qualifiers on cpumask ops.

Index: 2.6.7-mm5/include/linux/cpumask.h
===================================================================
--- 2.6.7-mm5.orig/include/linux/cpumask.h	2004-07-01 19:05:31.000000000 -0700
+++ 2.6.7-mm5/include/linux/cpumask.h	2004-07-01 19:30:10.000000000 -0700
@@ -114,58 +114,58 @@ static inline int __cpu_test_and_set(int
 }
 
 #define cpus_and(dst, src1, src2) __cpus_and(&(dst), &(src1), &(src2), NR_CPUS)
-static inline void __cpus_and(cpumask_t *dstp, cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline void __cpus_and(cpumask_t *dstp, const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	bitmap_and(dstp->bits, src1p->bits, src2p->bits, nbits);
 }
 
 #define cpus_or(dst, src1, src2) __cpus_or(&(dst), &(src1), &(src2), NR_CPUS)
-static inline void __cpus_or(cpumask_t *dstp, cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline void __cpus_or(cpumask_t *dstp, const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	bitmap_or(dstp->bits, src1p->bits, src2p->bits, nbits);
 }
 
 #define cpus_xor(dst, src1, src2) __cpus_xor(&(dst), &(src1), &(src2), NR_CPUS)
-static inline void __cpus_xor(cpumask_t *dstp, cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline void __cpus_xor(cpumask_t *dstp, const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	bitmap_xor(dstp->bits, src1p->bits, src2p->bits, nbits);
 }
 
 #define cpus_andnot(dst, src1, src2) \
 				__cpus_andnot(&(dst), &(src1), &(src2), NR_CPUS)
-static inline void __cpus_andnot(cpumask_t *dstp, cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline void __cpus_andnot(cpumask_t *dstp, const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	bitmap_andnot(dstp->bits, src1p->bits, src2p->bits, nbits);
 }
 
 #define cpus_complement(dst, src) __cpus_complement(&(dst), &(src), NR_CPUS)
 static inline void __cpus_complement(cpumask_t *dstp,
-					cpumask_t *srcp, int nbits)
+					const cpumask_t *srcp, int nbits)
 {
 	bitmap_complement(dstp->bits, srcp->bits, nbits);
 }
 
 #define cpus_equal(src1, src2) __cpus_equal(&(src1), &(src2), NR_CPUS)
-static inline int __cpus_equal(cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline int __cpus_equal(const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	return bitmap_equal(src1p->bits, src2p->bits, nbits);
 }
 
 #define cpus_intersects(src1, src2) __cpus_intersects(&(src1), &(src2), NR_CPUS)
-static inline int __cpus_intersects(cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline int __cpus_intersects(const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
 }
 
 #define cpus_subset(src1, src2) __cpus_subset(&(src1), &(src2), NR_CPUS)
-static inline int __cpus_subset(cpumask_t *src1p,
-					cpumask_t *src2p, int nbits)
+static inline int __cpus_subset(const cpumask_t *src1p,
+					const cpumask_t *src2p, int nbits)
 {
 	return bitmap_subset(src1p->bits, src2p->bits, nbits);
 }
@@ -257,7 +257,7 @@ static inline int __next_cpu(int n, cons
 #define cpumask_scnprintf(buf, len, src) \
 			__cpumask_scnprintf((buf), (len), &(src), NR_CPUS)
 static inline int __cpumask_scnprintf(char *buf, int len,
-					cpumask_t *srcp, int nbits)
+					const cpumask_t *srcp, int nbits)
 {
 	return bitmap_scnprintf(buf, len, srcp->bits, nbits);
 }
@@ -265,9 +265,9 @@ static inline int __cpumask_scnprintf(ch
 #define cpumask_parse(ubuf, ulen, src) \
 			__cpumask_parse((ubuf), (ulen), &(src), NR_CPUS)
 static inline int __cpumask_parse(const char __user *buf, int len,
-					cpumask_t *srcp, int nbits)
+					cpumask_t *dstp, int nbits)
 {
-	return bitmap_parse(buf, len, srcp->bits, nbits);
+	return bitmap_parse(buf, len, dstp->bits, nbits);
 }
 
 #if NR_CPUS > 1

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
