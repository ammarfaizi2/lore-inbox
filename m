Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290232AbSBFIX4>; Wed, 6 Feb 2002 03:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289802AbSBFIXn>; Wed, 6 Feb 2002 03:23:43 -0500
Received: from ns.caldera.de ([212.34.180.1]:24198 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S290285AbSBFIWp>;
	Wed, 6 Feb 2002 03:22:45 -0500
Date: Wed, 6 Feb 2002 09:21:29 +0100
From: Christoph Hellwig <hch@caldera.de>
To: David Mosberger <davidm@hpl.hp.com>
Cc: Michael Madore <mmadore@turbolinux.com>, linux-ia64@linuxia64.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [Linux-ia64] Proper fix for sym53c8xx_2 driver and dma64_addr_t
Message-ID: <20020206092129.A8739@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	David Mosberger <davidm@hpl.hp.com>,
	Michael Madore <mmadore@turbolinux.com>, linux-ia64@linuxia64.org,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <3C6043E5.D1F40E5D@turbolinux.com> <20020205223804.A22012@caldera.de> <15456.21030.840746.209377@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15456.21030.840746.209377@napali.hpl.hp.com>; from davidm@hpl.hp.com on Tue, Feb 05, 2002 at 01:44:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 01:44:06PM -0800, David Mosberger wrote:
>   Christoph> IA64 needs to define dma64_addr_t.
> 
> Not before the driver writers understand when to use it.

Architecture maintainers are not supposed to decide whether driver
writers understand APIs.  The dma64_addr_t type is part of the PCI
DMA interface and IA64 needs to defines it.

Linus, could you please accept the below patch to define dma64_addr_t
on IA64?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

Index: include/asm-ia64/types.h
===================================================================
RCS file: /vger/linux/include/asm-ia64/types.h,v
retrieving revision 1.3
diff -u -u -r1.3 types.h
--- include/asm-ia64/types.h	22 Apr 2000 00:45:18 -0000	1.3
+++ include/asm-ia64/types.h	6 Feb 2002 08:24:24 -0000
@@ -63,6 +63,7 @@
 /* DMA addresses are 64-bits wide, in general.  */
 
 typedef u64 dma_addr_t;
+typedef u64 dma64_addr_t;
 
 # endif /* __KERNEL__ */
 #endif /* !__ASSEMBLY__ */
