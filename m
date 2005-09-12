Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVILOwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVILOwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVILOwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:52:54 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:57606 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751219AbVILOwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:52:54 -0400
Date: Mon, 12 Sep 2005 10:48:52 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc: tony.luck@intel.com
Subject: [patch 2.6.13] ia64: add EXPORT_SYMBOL_GPL for ia64_max_cacheline_size
Message-ID: <09122005104852.31327@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of dma_get_cache_alignment for ia64 makes reference
to ia64_max_cacheline_size inside of a static inline. For this to
work for modules, this needs to be EXPORT_SYMBOL{,_GPL}.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 arch/ia64/kernel/setup.c |    1 +
 1 files changed, 1 insertion(+)

diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -79,6 +79,7 @@ unsigned long vga_console_iobase;
 unsigned long vga_console_membase;
 
 unsigned long ia64_max_cacheline_size;
+EXPORT_SYMBOL_GPL(ia64_max_cacheline_size);
 unsigned long ia64_iobase;	/* virtual address for I/O accesses */
 EXPORT_SYMBOL(ia64_iobase);
 struct io_space io_space[MAX_IO_SPACES];
