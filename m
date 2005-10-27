Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbVJ0GaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbVJ0GaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 02:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVJ0GaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 02:30:07 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:56987 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932567AbVJ0GaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 02:30:06 -0400
Date: Thu, 27 Oct 2005 10:30:04 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Roland Dreier <rolandd@cisco.com>,
       gregkh@suse.de, mst@mellanox.co.il, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
Message-ID: <20051027103004.A4167@jurassic.park.msu.ru>
References: <524q799p2t.fsf@cisco.com> <20051022233220.GA1463@parisc-linux.org> <20051026225140.GD13495@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051026225140.GD13495@kroah.com>; from greg@kroah.com on Wed, Oct 26, 2005 at 03:51:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 03:51:40PM -0700, Greg KH wrote:
> On Sat, Oct 22, 2005 at 05:32:20PM -0600, Matthew Wilcox wrote:
> > Perhaps the right thing to do is to change pad2 (in struct pci_bus) to
> > bus_flags and make bit 0 PCI_BRIDGE_FLAGS_NO_MSI ?

It would be better to make it a bit field as in struct pci_dev.

-	unsigned short pad2;
+	unsigned short no_msi:1;

> Yeah, I can't think of any way to use the device tree to do this, so
> this sounds as good a way as any.

Other pci_bus flags might be useful as well, for instance I thought
of bus->hotplug_bridge or something like that.

Ivan.
