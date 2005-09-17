Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVIQRVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVIQRVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 13:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVIQRVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 13:21:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:52479 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751164AbVIQRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 13:21:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: adobriyan@gmail.com
Subject: Re: ppc64: BPA iommu fails to build (BUILD_BUG_ON)
Date: Sat, 17 Sep 2005 19:22:13 +0200
User-Agent: KMail/1.7.2
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       jordi_caubet@es.ibm.com
References: <OFC125707F.002C0D91-ONC125707F.002C0D91-C125707F.002C0D95@de.ibm.com>
In-Reply-To: <OFC125707F.002C0D91-ONC125707F.002C0D91-C125707F.002C0D95@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200509171922.14625.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünnavend 17 September 2005 10:01, Alexey Dobriyan wrote:

> After a patch to make BUILD_BUG_ON error at compile-time went in
> 2.6.14-git1, arch/ppc64/kernel/bpa_iommu.c fails to build

This patch fixes that, I forgot to send it out with the previous updates.
Please apply.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-cg/arch/ppc64/kernel/bpa_iommu.c
===================================================================
--- linux-cg.orig/arch/ppc64/kernel/bpa_iommu.c
+++ linux-cg/arch/ppc64/kernel/bpa_iommu.c
@@ -99,7 +99,7 @@ get_iost_entry(unsigned long iopt_base, 
 		break;
 
 	default: /* not a known compile time constant */
-		BUILD_BUG_ON(1);
+		BUG();
 		break;
 	}
 
