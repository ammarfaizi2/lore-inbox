Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbSKHOfz>; Fri, 8 Nov 2002 09:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbSKHOfy>; Fri, 8 Nov 2002 09:35:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46605 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262062AbSKHOfy>; Fri, 8 Nov 2002 09:35:54 -0500
Date: Fri, 8 Nov 2002 14:42:34 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: Re: [PATCH] SCSI on non-ISA systems
Message-ID: <20021108144234.A24114@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Rusty Trivial Russell <trivial@rustcorp.com.au>
References: <20021108135742.A22790@flint.arm.linux.org.uk> <Pine.GSO.4.21.0211081522050.23267-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0211081522050.23267-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Fri, Nov 08, 2002 at 03:22:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 03:22:55PM +0100, Geert Uytterhoeven wrote:
> On Fri, 8 Nov 2002, Russell King wrote:
> > This isn't actually the original purpose of CONFIG_GENERIC_ISA_DMA (it
> > was to allow an architecture to provide ISA-like DMA without having to
> > use the ISA DMA request/free functions - eg, they need to claim interrupts
> > on request_dma() and free them on free_dma()).
> 
> Then what's the correct(TM) fix? Unconditionally #define
> CONFIG_GENERIC_ISA_DMA, so it behaves like before?

Probably the correct answer is to get everyone to use an explicit release
function and just kill scsi_host_generic_release() entirely.

However, I'm sure other people will have differing views on that.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

