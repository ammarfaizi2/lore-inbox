Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVLIKjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVLIKjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 05:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVLIKjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 05:39:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59989 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932071AbVLIKjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 05:39:02 -0500
Date: Fri, 9 Dec 2005 11:39:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Erik Slagter <erik@slagter.name>
Cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       Jeff Garzik <jgarzik@pobox.com>, hch@infradead.org, mjg59@srcf.ucam.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051209103937.GE26185@suse.de>
References: <20051208030242.GA19923@srcf.ucam.org> <20051208091542.GA9538@infradead.org> <20051208132657.GA21529@srcf.ucam.org> <20051208133308.GA13267@infradead.org> <20051208133945.GA21633@srcf.ucam.org> <20051208134438.GA13507@infradead.org> <1134062330.1732.9.camel@localhost.localdomain> <43989B00.5040503@pobox.com> <20051208133144.0f39cb37.randy_d_dunlap@linux.intel.com> <1134121522.27633.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134121522.27633.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09 2005, Erik Slagter wrote:
> On Thu, 2005-12-08 at 13:31 -0800, Randy Dunlap wrote:
> 
> > > It works just fine on laptops, with Jens' suspend/resume patch.
> > 
> > I have seen a few other people report that SATA suspend/resume
> > works when using Jens's patch.  However, this is done without
> > the benefit of what the additional ACPI methods provide thru
> > _GTF and writing those taskfiles, such as:
> > - enabling write cache
> > - enabling device power management
> > - freezing the security password
> > 
> > so even when it "works," those people may be missing some
> > performance benefits or power savings or security.
> > 
> > In any case, I'm glad to see some discussion of this.
> 
> IMHO available infrastructure (and hardware abstraction!) should be used
> instead of being stubborn and pretend we know everything about any
> hardware.

It's not about being stubborn, it's about maintaining and working on a
clean design. The developers have to do that, not the users. So forgive
people for being a little cautious about shuffling all sorts of ACPI
into the scsi core and/or drivers. We always need to think long term
here.

Users don't care about the maintainability and cleanliness of the code,
they really just want it to work. Which is perfectly understandable.

-- 
Jens Axboe

