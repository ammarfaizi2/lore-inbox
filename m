Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135378AbRD3Pjb>; Mon, 30 Apr 2001 11:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135386AbRD3PjV>; Mon, 30 Apr 2001 11:39:21 -0400
Received: from dutidad.twi.tudelft.nl ([130.161.158.199]:21900 "EHLO dutidad")
	by vger.kernel.org with ESMTP id <S135378AbRD3PjG>;
	Mon, 30 Apr 2001 11:39:06 -0400
Date: Mon, 30 Apr 2001 17:39:04 +0200
From: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci/quirks.c - VIA PCI latency in 2.4.4
Message-ID: <20010430173904.A8741@dutidad.twi.tudelft.nl>
Reply-To: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
In-Reply-To: <20010430155844.E8052@dutidad.twi.tudelft.nl> <E14uEkK-00088U-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14uEkK-00088U-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 30, 2001 at 03:33:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 03:33:49PM +0100, Alan Cox wrote:
> > No fix is known for intel pci-to-host bridges with the 686B south bridge,
> > and in the case of the AMD-761 chipset, there are certain BIOS settings you
> > can change.  See: http://home.tiscalinet.de/au-ja/review-kt133a-4-en.html
> 
> The -ac tree has the ability to kill IDE DMA across the entire system. It may
> be this is what should be done with all hybrid setups where there is no known
> fix.

Alternatively, too much time shouldn't be spent on this specific bug.  VIA
has recognised it, and motherboard vendors are already starting to release
updated BIOSes that sport the required settings (e.g. Abit, see
http://www.viahardware.com/faq/kt7/faqbios.html).  I'm just afraid if the
kernel starts disabling IDE DMA on certain of these setups, there'll have to
be checks (in the kernel) for possible future updated BIOSes as well (else
we disable IDE DMA where it's not necessary).

Selective application of the fix (as in my patch) does no harm on the known
combinations though.

My very humble 2c,

-- 
charl p. botha      | computer graphics and cad/cam 
http://cpbotha.net/ | http://www.cg.its.tudelft.nl/
