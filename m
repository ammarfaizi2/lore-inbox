Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUJOKfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUJOKfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 06:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUJOKfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 06:35:00 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:15496 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S267565AbUJOKe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 06:34:58 -0400
Date: Fri, 15 Oct 2004 14:34:41 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Introduce PCI <-> CPU address conversion [1/2]
Message-ID: <20041015143441.A31625@jurassic.park.msu.ru>
References: <20041014124737.GM16153@parcelfarce.linux.theplanet.co.uk> <20041014182704.A13971@jurassic.park.msu.ru> <20041014143924.GP16153@parcelfarce.linux.theplanet.co.uk> <20041015071926.GA11457@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041015071926.GA11457@twiddle.net>; from rth@twiddle.net on Fri, Oct 15, 2004 at 12:19:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 12:19:26AM -0700, Richard Henderson wrote:
> So you conclude from 50% of the ports implementing things in a 
> particular way that you should invent a totally new interface?
> Isn't the obvious solution to implement the existing interface
> for the ports that don't have it?

Definitely.
Besides, pci_bus_to_phys() name is quite misleading. Sounds like
invitation to use phys_to_virt() with the returned value...
pcibios_bus_to_resource as the inverse of pcibios_resource_to_bus
would be much cleaner.

Ivan.
