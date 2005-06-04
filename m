Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVFDC0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFDC0F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 22:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVFDC0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 22:26:05 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:52352
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S261208AbVFDC0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 22:26:01 -0400
Date: Sat, 4 Jun 2005 04:26:00 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org> <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 06:55:40PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 4 Jun 2005, Andreas Koch wrote:
> > 
> > As you suspected, it wasn't a panacea: The kernel now panics, with a
> > call chain of
> > 
> > 	...
> > 	pcibios_init()
> > 	pci_assign_unassigned_resources()
> > 	pci_bus_assign_resources()
> > 	pci_setup_bridge()
> > 
> > I can collect more specific info if necessary.
> 
> It would be nice to know exactly what it is that panics, I could well
> imagine that it's something like the "bus->self" that ends up being NULL
> for the root bus or something silly like that, simply because x86 has 
> never needed to use these functions.
> 
> If so, it migth be as easy as just skipping buses that don't have bridge 
> device associated with them, but this would require that you try to debug 
> the oops a bit to figure out where it is..

Actually, I tried that already.  But I didn't get any usable info from
the oops and GDB (`list *pci_setup_bridge+0x1a2' shows an include file,
not a line in the function) .  I'll make another attempt tomorrow when
I am more awake :-)

  Andreas
