Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268033AbTB1RRj>; Fri, 28 Feb 2003 12:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268038AbTB1RRj>; Fri, 28 Feb 2003 12:17:39 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:27654 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S268033AbTB1RRi>; Fri, 28 Feb 2003 12:17:38 -0500
Date: Fri, 28 Feb 2003 20:27:21 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>, linux-kernel@vger.kernel.org
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030228202721.A4481@jurassic.park.msu.ru>
References: <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su> <20030228160550.B31251@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030228160550.B31251@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Feb 28, 2003 at 04:05:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 04:05:50PM +0000, Russell King wrote:
> Umm, question - I've seen ISA bridges with the ability to perform 32-bit
> DMA using the ISA DMA controllers.  AFAIK, Linux doesn't make use of this
> feature, except on ARM PCI systems with ISA bridges.

Alpha uses this from day 1, BTW.
Also, in 2.5 we have "isa_bridge" stuff which was intended exactly for
that - it's a pointer to pci device (real ISA bridge with appropriate
dma_mask) that can be used by non-busmastering ISA devices as a pci_dev *
arg to pci_* mapping functions.

>  Is there a reason
> why this isn't used on x86 hardware?

Given a huge number of various ISA bridges found in x86 systems,
I don't see a generic way to determine which ones can do 32-bit DMA...
Maybe kind of white list?

Ivan.
