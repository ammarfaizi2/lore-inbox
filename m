Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVAPMJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVAPMJc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 07:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVAPMJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 07:09:31 -0500
Received: from verein.lst.de ([213.95.11.210]:62429 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262492AbVAPMJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 07:09:20 -0500
Date: Sun, 16 Jan 2005 13:09:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Hellwig <hch@lst.de>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix CONFIG_AGP depencies
Message-ID: <20050116120911.GA14085@lst.de>
References: <20050116114457.GA13506@lst.de> <20050116120550.GQ4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116120550.GQ4274@stusta.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 01:05:50PM +0100, Adrian Bunk wrote:
> This doesn't seem to achieve what you want:
> PPC is defined on ppc64...

*grmbl*


--- 1.39/drivers/char/agp/Kconfig	2005-01-08 01:15:52 +01:00
+++ edited/drivers/char/agp/Kconfig	2005-01-16 11:39:56 +01:00
@@ -1,5 +1,6 @@
 config AGP
-	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU && !M68K && !ARM
+	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
+	depends on ALPHA || IA64 || PPC32 || X86
 	default y if GART_IOMMU
 	---help---
 	  AGP (Accelerated Graphics Port) is a bus system mainly used to
