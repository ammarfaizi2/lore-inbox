Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129951AbRBIE47>; Thu, 8 Feb 2001 23:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130041AbRBIE4t>; Thu, 8 Feb 2001 23:56:49 -0500
Received: from [193.120.224.170] ([193.120.224.170]:38285 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129951AbRBIE4g>;
	Thu, 8 Feb 2001 23:56:36 -0500
Date: Fri, 9 Feb 2001 04:56:29 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Alex Deucher <adeucher@UU.NET>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>,
        <jhartmann@valinux.com>
Subject: Re: [OT] Re: 2.4.x, drm, g400 and pci_set_master
In-Reply-To: <3A82E86C.14217D65@uu.net>
Message-ID: <Pine.LNX.4.32.0102090448300.3757-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Alex Deucher wrote:

> There is preliminary support for pcigart in the dri tree.  I believe
> some people have had some success with it.

but there doesn't need to be. DEC 2x17x Alpha chipsets have an IOMMU
for hardware scatter-gather support. (ie generic agpgart for the PCI
bus).

why put in mga specific code? generic support for the IOMMU
capabilities of every recent (since the 20172 chipset at least iirc)
DEC chipset would benefit everything from cheap sound cards, to
high-end IO (scatter-gather even if hardware does not support it and
direct access to/from host memory > 4GB without needing bounce
buffers).

only machines without this IOMMU are the AMD chipset machines, but
they have AGP.

>
> Alex

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
