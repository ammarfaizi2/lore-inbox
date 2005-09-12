Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVILC5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVILC5y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 22:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVILC5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 22:57:54 -0400
Received: from sccrmhc14.comcast.net ([63.240.76.49]:1227 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751136AbVILC5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 22:57:54 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2/3] Set compatibility flag for 4GB zone on IA64
Date: Sun, 11 Sep 2005 19:58:02 -0700
User-Agent: KMail/1.8.1
Cc: "Luck, Tony" <tony.luck@intel.com>, ak@suse.de, torvalds@osdl.org,
       Greg Edwards <edwardsg@sgi.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F045A8EA0@scsmsx401.amr.corp.intel.com> <4324D70C.3090109@pobox.com>
In-Reply-To: <4324D70C.3090109@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509111958.02190.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 11, 2005 6:17 pm, Jeff Garzik wrote:
> Luck, Tony wrote:
> >>Luck, Tony wrote:
> >>>ia64 isn't all that homogeneous.  SGI systems stuff *all* memory
> >>>into the DMA zone as their I/O devices have no 32-bit limits (just
> >>>as well really as there is no memory below 4G on an Altix!).
> >>
> >>SGI machines support random PCI cards, right?  If so, you
> >>cannot presume
> >>I/O devices have no 32-bit limits.
> >
> > No, SGI machines don't support random PCI cards.  The lowest
> > possible physical address in an Altix is 192GB.  Cards that
> > can only DMA to addresses below 4G aren't going to be very
> > useful, are they?
>
> Do the boxes have IOMMUs?

Yes, but they can only support devices that can do 32 bit or above 
addressing due to the fact that their IOMMU page tables are only 
referenced if the high bit of a 32 bit address is set, iirc.

Anyway, for those boxes, all memory was put in the DMA zone and the I/O 
mapping routines failed if devices that didn't support at least 32 bits 
tried to do a DMA map.

Jesse
