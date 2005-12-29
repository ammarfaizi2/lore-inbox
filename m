Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVL2WiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVL2WiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 17:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVL2WiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 17:38:12 -0500
Received: from isilmar.linta.de ([213.239.214.66]:63114 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751070AbVL2WiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 17:38:11 -0500
Date: Thu, 29 Dec 2005 23:38:05 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Greg KH <greg@kroah.com>
Cc: Kumar Gala <galak@gate.crashing.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: pci_scan_bridge and cardbus controllers?
Message-ID: <20051229223805.GA22490@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg KH <greg@kroah.com>, Kumar Gala <galak@gate.crashing.org>,
	linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
References: <Pine.LNX.4.44.0512141311140.14530-100000@gate.crashing.org> <20051229071756.GD8863@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229071756.GD8863@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 28, 2005 at 11:17:56PM -0800, Greg KH wrote:
> On Wed, Dec 14, 2005 at 01:45:30PM -0600, Kumar Gala wrote:
> > in pci_fixup_parent_subordinate_busnr() we will only reassign bus numbers 
> > if pcibios_assign_all_busses() returns 1.
> > 
> > If we got to pci_fixup_parent_subordinate_busnr() and
> > pcibios_assign_all_busses() returns 0, should we not print out some
> > warning since we most likely got here because the bios didn't init things
> > properly?
> > 
> > I came across this on an embedded system in which we had a cardbus 
> > controller behind a P2P bridge.  The bios did not reserve any bus numbers 
> > for the cardbus controller like linux does.  So I ended up with:
> 
> Ick.  Perhaps the pcmcia developers would know better what they want to
> have done here?  Try asking on their list :)

Well, there is such a patch in your PCI queue already -- see
http://bugzilla.kernel.org/show_bug.cgi?id=5557 for details.

	Dominik
