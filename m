Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbVF3Tcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbVF3Tcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbVF3Tb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:31:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:14990 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262985AbVF3T37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:29:59 -0400
Date: Thu, 30 Jun 2005 09:05:06 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>, rajesh.shah@intel.com,
       gregkh@suse.de, ak@suse.de, len.brown@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net
Subject: Re: [patch 2/2] i386/x86_64: collect host bridge resources v2
Message-ID: <20050630160506.GD6828@kroah.com>
References: <20050602224147.177031000@csdlinux-1> <20050602224327.051278000@csdlinux-1> <20050628155152.A24551@jurassic.park.msu.ru> <1119982914.19258.6.camel@whizzy> <20050629000300.A26118@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629000300.A26118@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 12:03:00AM +0400, Ivan Kokshaysky wrote:
> On Tue, Jun 28, 2005 at 11:21:54AM -0700, Kristen Accardi wrote:
> > I gave this patch a try (against mm2), and found that I now get many
> > errors on boot up complaining about not being able to allocate PCI
> > resources due to resource collisions, and then the system begins to
> > complain about lost interrupts on hda, and is never able to mount the
> > root filesystem.
> 
> Well, I'm not surprised. :-(
> Probably there is a conflict between e820 map and root bus ranges
> reported by ACPI. I think that it would be better to just drop
> gregkh-pci-pci-collect-host-bridge-resources-02.patch rather than
> try to fix it, at least until such conflicts can be resolved in
> a sane way.

Ok, I'll drop it.  Any objections to me doing this?

So, with the remaining pci patches, (as seen in
kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/pci/) are
there any objections to me pushing these (with the exception of the
above one) to Linus?  I think there was one report of the
pci-assign-unassigned-resources.patch patch causing boot problems on one
box, but that might have also been due to the above patch, am not sure.

Ah, the joys of acpi and pci resources... bleah.

thanks,

greg k-h
