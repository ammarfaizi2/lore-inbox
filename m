Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSKHNvD>; Fri, 8 Nov 2002 08:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbSKHNvD>; Fri, 8 Nov 2002 08:51:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18957 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261996AbSKHNvD>; Fri, 8 Nov 2002 08:51:03 -0500
Date: Fri, 8 Nov 2002 13:57:42 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: Re: [PATCH] SCSI on non-ISA systems
Message-ID: <20021108135742.A22790@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Rusty Trivial Russell <trivial@rustcorp.com.au>
References: <Pine.GSO.4.21.0211081443590.23267-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0211081443590.23267-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Fri, Nov 08, 2002 at 02:46:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 02:46:40PM +0100, Geert Uytterhoeven wrote:
> Since 2.5.31, the compilation of kernel/dma.c is conditional on
> CONFIG_GENERIC_ISA_DMA. However, drivers/scsi/hosts.c unconditionally calls
> free_dma(), which breaks machines with SCSI that don't have ISA.

This isn't actually the original purpose of CONFIG_GENERIC_ISA_DMA (it
was to allow an architecture to provide ISA-like DMA without having to
use the ISA DMA request/free functions - eg, they need to claim interrupts
on request_dma() and free them on free_dma()).

However, since this function isn't used on ARM, it doesn't affect me,
and so I don't have any problem with this patch. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

