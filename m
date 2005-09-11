Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVIKQ7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVIKQ7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVIKQ7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:59:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:29886 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751073AbVIKQ7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:59:25 -0400
Date: Sun, 11 Sep 2005 18:59:19 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, tony.luck@intel.com
Subject: [2/3] Set compatibility flag for 4GB zone on IA64
Message-ID: <43246267.mailL4W11DT2L@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set compatibility flag for 4GB zone on IA64

IA64 traditionally had a 4GB DMA32 zone. Set the compatibility flag
to keep old drivers working.

For new drivers it would be better to use ZONE_DMA32 now. 

Signed-off-by: Andi Kleen <ak@suse.de>
Cc: tony.luck@intel.com

Index: linux/arch/ia64/Kconfig
===================================================================
--- linux.orig/arch/ia64/Kconfig
+++ linux/arch/ia64/Kconfig
@@ -54,6 +54,10 @@ config IA64_UNCACHED_ALLOCATOR
 	bool
 	select GENERIC_ALLOCATOR
 
+config ZONE_DMA_IS_DMA32
+	bool
+	default y
+
 choice
 	prompt "System type"
 	default IA64_GENERIC
