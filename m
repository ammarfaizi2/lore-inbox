Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265912AbUBJOtQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265915AbUBJOtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:49:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43783 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265912AbUBJOsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:48:46 -0500
Date: Tue, 10 Feb 2004 14:47:19 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dmapool (was: Re: Linux 2.6.3-rc2)
Message-ID: <20040210144719.B23310@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org> <Pine.GSO.4.58.0402101424250.2261@waterleaf.sonytel.be> <Pine.GSO.4.58.0402101531240.2261@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.58.0402101531240.2261@waterleaf.sonytel.be>; from geert@linux-m68k.org on Tue, Feb 10, 2004 at 03:32:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 03:32:47PM +0100, Geert Uytterhoeven wrote:
> On Tue, 10 Feb 2004, Geert Uytterhoeven wrote:
> > The dmapool code makes dma_{alloc,free}_coherent() a requirement for all
> > platforms, breaking platforms that don't have it (e.g. m68k, and from a quick
> > browse sparc and sparc64 probably, too).
> >
> > May not be that nice for a release candidate in a stable series...
> 
> This patch seems to fix the problem (all offending platforms include
> <asm/generic.h> if CONFIG_PCI only):

Please don't - that breaks ARM.  Part of the whole point of dmapool is
that it provides a generic DMA pool implementation, especially for
non-PCI USB devices.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
