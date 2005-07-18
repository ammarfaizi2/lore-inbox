Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVGRTiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVGRTiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 15:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVGRTiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 15:38:13 -0400
Received: from colo.lackof.org ([198.49.126.79]:4504 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261556AbVGRThf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 15:37:35 -0400
Date: Mon, 18 Jul 2005 13:42:16 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: akpm@osdl.org, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       greg@kroah.com
Subject: Re: [PATCH 8/8] pci and yenta: pcibios_bus_to_resource
Message-ID: <20050718194216.GC11016@colo.lackof.org>
References: <20050711222138.GH30827@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711222138.GH30827@isilmar.linta.de>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 12:21:38AM +0200, Dominik Brodowski wrote:
> In yenta_socket, we default to using the resource setting of the CardBus
> bridge. However, this is a PCI-bus-centric view of resources and thus
> needs to be converted to generic resources first. Therefore, add a call
> to pcibios_bus_to_resource() call in between. This function is a mere
> wrapper on x86 and friends, however on some others it already exists, is
> added in this patch (alpha, arm, ppc, ppc64) or still needs to be 
> provided (parisc -- where is its pcibios_resource_to_bus() ?).

in arch/parisc/kernel/pci.c?
At least, it seems to be present in the 2.6.13-rc1 tree
on cvs.parisc-linux.org tree.

Arnaldo De Carmelo had add-on pci-pcmcia cards working in his
a500 (64-bit w/IOMMU PA-RISC) last year.  ISTR a few other people have
similar cards working for on B180 workstation (32-bit w/o IOMMU PARISC).

grant
