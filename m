Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVFHPSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVFHPSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVFHPSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:18:51 -0400
Received: from magic.adaptec.com ([216.52.22.17]:13017 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261311AbVFHPSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:18:48 -0400
Message-ID: <42A70C50.3070507@adaptec.com>
Date: Wed, 08 Jun 2005 11:18:40 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi()
 for drivers - take 2
References: <20050607002045.GA12849@suse.de> <20050607202129.GB18039@kroah.com>
In-Reply-To: <20050607202129.GB18039@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jun 2005 15:18:22.0311 (UTC) FILETIME=[4EF06770:01C56C3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/05 16:21, Greg KH wrote:
> Hm, here's an updated patch that should have fixed the errors I had in
> my previous one where I wasn't disabling MSI for the devices that did
> not want it enabled (note, my patch skips the hotplug and pcie driver
> for now, those would have to be fixed if this patch goes on.)
> 
> However, now that I've messed around with the MSI-X logic in the IB
> driver, I'm thinking that this whole thing is just pointless, and I

Agreed.

> should just drop it and we should stick with the current way of enabling
> MSI only if the driver wants it.  If you look at the logic in the mthca

Agreed.

> driver you'll see what I mean.
> 
> So, anyone else think this is a good idea?  Votes for me to just drop it
> and go back to hacking on the driver core instead?

Drop it.  Yes.

> Oh, and in looking at the drivers/pci/msi.c file, it could use some
> cleanups to make it smaller and a bit less complex.  I've also seen some
> complaints that it is very arch specific (x86 based).  But as no other
> arches seem to want to support MSI, I don't really see any need to split
> it up.  Any comments about this?

It's up to you.

	Luben
