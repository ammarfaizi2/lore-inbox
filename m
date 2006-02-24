Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWBXNQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWBXNQo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 08:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWBXNQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 08:16:44 -0500
Received: from isilmar.linta.de ([213.239.214.66]:63655 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750994AbWBXNQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 08:16:43 -0500
Date: Fri, 24 Feb 2006 14:16:41 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, kristen.c.accardi@intel.com,
       Bernhard Kaindl <bk@suse.de>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [PATCH] PCI/Cardbus cards hidden, needs pci=assign-busses to fix
Message-ID: <20060224131641.GA11412@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	kristen.c.accardi@intel.com, Bernhard Kaindl <bk@suse.de>,
	linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0601051533430.27220-100000@www.fnordora.org> <1136555288.30498.12.camel@localhost.localdomain> <Pine.LNX.4.64.0602162054020.13089@jbgna.fhfr.qr> <20060218014102.0647c0ce.akpm@osdl.org> <20060224014755.GD25787@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224014755.GD25787@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 05:47:55PM -0800, Greg KH wrote:
> > I guess if this is the only way in which we can do this, and nobody has any
> > better solutions then sure, it'll get people's machines going.  We'll be
> > forever patching that table though.
> > 
> > But _does_ anyone have any better solutions?
> 
> This patch might not be needed at all, as per Kristen's recent comments
> on the linux-pci mailing list, and her small patch that is already in
> the -mm tree.

If you mean

Subject:    [patch 3/4] pci: really fix parent's subordinate busnr

then no, that patch is not going to help: you can call
pci_fixup_parent_subordinate_busnr() as often as you want; it won't do
anything unless pcibios_assign_all_busses() is true.

	Dominik
