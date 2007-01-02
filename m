Return-Path: <linux-kernel-owner+w=401wt.eu-S1752778AbXABQVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbXABQVL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbXABQVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:21:10 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:38763
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752778AbXABQVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:21:09 -0500
Message-Id: <459A94D3.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 02 Jan 2007 16:22:27 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-ia64@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] ia64: missing exports hwsw_sync_...
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing exports to allow several drivers to be built as
module with CONFIG_IA64_HP_ZX1_SWIOTLB.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.20-rc3/arch/ia64/hp/common/hwsw_iommu.c	2006-11-29 22:57:37.000000000 +0100
+++ 2.6.20-rc3-ia64-zx1-swiotlb/arch/ia64/hp/common/hwsw_iommu.c	2007-01-02 08:24:22.000000000 +0100
@@ -192,3 +192,7 @@ EXPORT_SYMBOL(hwsw_unmap_sg);
 EXPORT_SYMBOL(hwsw_dma_supported);
 EXPORT_SYMBOL(hwsw_alloc_coherent);
 EXPORT_SYMBOL(hwsw_free_coherent);
+EXPORT_SYMBOL(hwsw_sync_single_for_cpu);
+EXPORT_SYMBOL(hwsw_sync_single_for_device);
+EXPORT_SYMBOL(hwsw_sync_sg_for_cpu);
+EXPORT_SYMBOL(hwsw_sync_sg_for_device);

