Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVA1UO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVA1UO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVA1UMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:12:47 -0500
Received: from colo.lackof.org ([198.49.126.79]:40662 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262728AbVA1ULt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:11:49 -0500
Date: Fri, 28 Jan 2005 13:12:00 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Message-ID: <20050128201200.GE32135@colo.lackof.org>
References: <9e47339105011719436a9e5038@mail.gmail.com> <200501281041.42016.jbarnes@sgi.com> <20050128193320.GB32135@colo.lackof.org> <200501281141.16450.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501281141.16450.jbarnes@sgi.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 11:41:16AM -0800, Jesse Barnes wrote:
> Yeah, I think I understand.  We could probably do the same thing on sn2
> as you do on parisc--add a 'segment 0' offset to the port so that it's routed 
> correctly.  I think that's a little less flexible than adding a new resource 
> though, since it makes it harder for drivers to support more than one device 
> or devices on non-segment 0 busses.

To be clear, the parisc code defines this in include/asm-parisc/pci.h:

#define HBA_PORT_SPACE_BITS     16
#define PCI_PORT_HBA(a)    ((a) >> HBA_PORT_SPACE_BITS)

and PCI_PORT_HBA gets used in arch/parisc/kernel/pci.c.

Offhand, I don't know if ia64 has the equivalent.
But it sounds like it might need it.

grant
