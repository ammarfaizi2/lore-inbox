Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265689AbUFOPHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUFOPHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 11:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUFOPHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 11:07:38 -0400
Received: from verein.lst.de ([212.34.189.10]:47549 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265689AbUFOPG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 11:06:57 -0400
Date: Tue, 15 Jun 2004 17:06:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix standalone inclusion of asm-i386/dma-mapping.h
Message-ID: <20040615150652.GA18894@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without this a usb-storage patch I sent fails on x86 because
dma-mapping.h uses struct device and various VM stuff without proper
includes.  It's fine on ppc at least.



--- 1.7/include/asm-i386/dma-mapping.h	2004-05-25 11:53:06 +02:00
+++ edited/include/asm-i386/dma-mapping.h	2004-06-15 17:02:43 +02:00
@@ -1,6 +1,9 @@
 #ifndef _ASM_I386_DMA_MAPPING_H
 #define _ASM_I386_DMA_MAPPING_H
 
+#include <linux/device.h>
+#include <linux/mm.h>
+
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/scatterlist.h>
