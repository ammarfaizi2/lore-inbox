Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUHEE4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUHEE4t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267544AbUHEE4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:56:49 -0400
Received: from holomorphy.com ([207.189.100.168]:2497 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267516AbUHEEyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:54:25 -0400
Date: Wed, 4 Aug 2004 21:54:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [sparc32] [9/13] remove unused variable in dvma.c
Message-ID: <20040805045417.GA2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org> <20040805043817.GS2334@holomorphy.com> <20040805043957.GT2334@holomorphy.com> <20040805044130.GU2334@holomorphy.com> <20040805044427.GV2334@holomorphy.com> <20040805044627.GW2334@holomorphy.com> <20040805044736.GX2334@holomorphy.com> <20040805044839.GY2334@holomorphy.com> <20040805044950.GZ2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805044950.GZ2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 09:49:50PM -0700, William Lee Irwin III wrote:
> cache_decay_ticks needs to be defined in order for the kernel to link.
> This placeholder is inaccurate, however, other, more grave SMP issues
> need to be addressed first.

This variable is unused and causes noisy compiles.

Index: mm2-2.6.8-rc2/drivers/sbus/dvma.c
===================================================================
--- mm2-2.6.8-rc2.orig/drivers/sbus/dvma.c
+++ mm2-2.6.8-rc2/drivers/sbus/dvma.c
@@ -121,7 +121,6 @@
 void __init sun4_dvma_init(void)
 {
 	struct sbus_dma *dma;
-	struct sbus_dma *dchain;
 	struct resource r;
 
 	if(sun4_dma_physaddr) {
