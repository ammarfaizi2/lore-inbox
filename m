Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264994AbUFALaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264994AbUFALaW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265001AbUFALaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:30:21 -0400
Received: from holomorphy.com ([207.189.100.168]:40079 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264994AbUFALaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:30:01 -0400
Date: Tue, 1 Jun 2004 04:29:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040601112957.GO2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040601021539.413a7ad7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601021539.413a7ad7.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 02:15:39AM -0700, Andrew Morton wrote:
> - NFS server udpates
> - md updates
> - big x86 dmi_scan.c cleanup
> - merged perfctr.  No documentation though :(
> - cris architecture update

Hmm. perfctr needs some structs.


-- wli


Index: linux-2.6.7-rc2-mm1/include/linux/perfctr.h
===================================================================
--- linux-2.6.7-rc2-mm1.orig/include/linux/perfctr.h	2004-06-01 03:25:54.000000000 -0700
+++ linux-2.6.7-rc2-mm1/include/linux/perfctr.h	2004-06-01 04:27:51.000000000 -0700
@@ -53,7 +53,11 @@
 	unsigned int _reserved3;
 	unsigned int _reserved4;
 };
-
+#else
+struct perfctr_cpu_mask;
+struct perfctr_info;
+struct vperfctr_control;
+struct perfctr_sum_ctrs;
 #endif	/* CONFIG_PERFCTR */
 
 #ifdef __KERNEL__
