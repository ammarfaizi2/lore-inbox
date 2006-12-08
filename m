Return-Path: <linux-kernel-owner+w=401wt.eu-S1426016AbWLHRKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426016AbWLHRKs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426018AbWLHRKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:10:48 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:46247 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426016AbWLHRKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:10:46 -0500
Message-ID: <45799CA2.2090407@us.ibm.com>
Date: Fri, 08 Dec 2006 11:10:58 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [Patch] Add necessary #includes to asm-powerpc/spu.h
Content-Type: multipart/mixed;
 boundary="------------070906070702000304080305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070906070702000304080305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------070906070702000304080305
Content-Type: text/x-diff;
 name="spu-h-includes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spu-h-includes.patch"

Subject: Add necessary #includes to asm-powerpc/spu.h.

From: Maynard Johnson <maynardj@us.ibm.com>

This patch adds a couple of #includes to asm-powerpc/spu.h to
prevent compilation warnings that can occur when spu.h is
included from a source file where fs.h and notifier.h have
not been included already.

Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>

Index: linux-2.6.19-rc6-arnd1+patches/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/include/asm-powerpc/spu.h	2006-12-04 10:56:17.406636032 -0600
+++ linux-2.6.19-rc6-arnd1+patches/include/asm-powerpc/spu.h	2006-12-08 10:38:10.069679312 -0600
@@ -24,6 +24,8 @@
 #define _SPU_H
 #ifdef __KERNEL__
 
+#include <linux/fs.h>
+#include <linux/notifier.h>
 #include <linux/workqueue.h>
 #include <linux/sysdev.h>
 

--------------070906070702000304080305--

