Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVG2VZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVG2VZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVG2VYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:24:21 -0400
Received: from isilmar.linta.de ([213.239.214.66]:41373 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262848AbVG2VU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:20:28 -0400
Date: Fri, 29 Jul 2005 23:20:24 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 8/8] pci and yenta: pcibios_bus_to_resource
Message-ID: <20050729212024.GF24225@isilmar.linta.de>
Mail-Followup-To: Greg KH <greg@kroah.com>, akpm@osdl.org,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz
References: <20050711222138.GH30827@isilmar.linta.de> <20050726235049.GB6584@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726235049.GB6584@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 04:50:49PM -0700, Greg KH wrote:
> On Tue, Jul 12, 2005 at 12:21:38AM +0200, Dominik Brodowski wrote:
> > In yenta_socket, we default to using the resource setting of the CardBus
> > bridge. However, this is a PCI-bus-centric view of resources and thus
> > needs to be converted to generic resources first. Therefore, add a call
> > to pcibios_bus_to_resource() call in between. This function is a mere
> > wrapper on x86 and friends, however on some others it already exists, is
> > added in this patch (alpha, arm, ppc, ppc64) or still needs to be 
> > provided (parisc -- where is its pcibios_resource_to_bus() ?).
> > 
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> Hm, I saw a few different patches here, and some odd complaints.  Care
> to resend an updated version?

AFAICS, Andrew has merged all fixes into this version:

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm3/broken-out/pci-and-yenta-pcibios_bus_to_resource.patch

Thanks,
	Dominik
