Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSLBUJl>; Mon, 2 Dec 2002 15:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbSLBUJl>; Mon, 2 Dec 2002 15:09:41 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:58884 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264940AbSLBUJf>; Mon, 2 Dec 2002 15:09:35 -0500
Date: Mon, 2 Dec 2002 23:16:24 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: "'Richard Henderson'" <rth@twiddle.net>,
       "'Bjoern Brauel'" <bjb@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel build of 2.5.50 fails on Alpha
Message-ID: <20021202231624.A1571@jurassic.park.msu.ru>
References: <20021201201122.A31609@twiddle.net> <001001c29a3c$d65eaf80$3640a8c0@boemboem>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001001c29a3c$d65eaf80$3640a8c0@boemboem>; from folkert@vanheusden.com on Mon, Dec 02, 2002 at 08:55:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 08:55:59PM +0100, Folkert van Heusden wrote:
> I'm afraid that one won't compile:
> 
> arch/alpha/kernel/pci.c: In function `pcibios_fixup_final':
> arch/alpha/kernel/pci.c:128: `ALPHA_ALCOR_MAX_DMA_ISA_ADDRESS' undeclared

My fault. Please try this.

Ivan.

--- 2.5.50/include/asm-alpha/dma.h	Wed Nov  6 01:44:33 2002
+++ linux/include/asm-alpha/dma.h	Mon Dec  2 23:07:29 2002
@@ -112,9 +112,9 @@
 # elif defined(CONFIG_ALPHA_RUFFIAN)
 #  define MAX_ISA_DMA_ADDRESS		ALPHA_RUFFIAN_MAX_ISA_DMA_ADDRESS
 # elif defined(CONFIG_ALPHA_SABLE)
-#  define MAX_ISA_DMA_ADDRESS		ALPHA_SABLE_MAX_DMA_ISA_ADDRESS
+#  define MAX_ISA_DMA_ADDRESS		ALPHA_SABLE_MAX_ISA_DMA_ADDRESS
 # elif defined(CONFIG_ALPHA_ALCOR)
-#  define MAX_ISA_DMA_ADDRESS		ALPHA_ALCOR_MAX_DMA_ISA_ADDRESS
+#  define MAX_ISA_DMA_ADDRESS		ALPHA_ALCOR_MAX_ISA_DMA_ADDRESS
 # else
 #  define MAX_ISA_DMA_ADDRESS		ALPHA_MAX_ISA_DMA_ADDRESS
 # endif
