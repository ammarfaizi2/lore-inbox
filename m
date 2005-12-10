Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932773AbVLJCs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbVLJCs0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 21:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932772AbVLJCs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 21:48:26 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:28381 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932761AbVLJCsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 21:48:25 -0500
Date: Sat, 10 Dec 2005 02:47:51 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051210024750.GA31328@srcf.ucam.org>
References: <20051209114246.GB16945@infradead.org> <20051209114944.GA1068@havoc.gtf.org> <20051209115235.GB25771@srcf.ucam.org> <43997171.9060105@pobox.com> <20051209121124.GA25974@srcf.ucam.org> <439975AB.5000902@pobox.com> <20051209122457.GB26070@srcf.ucam.org> <439A23E8.3080407@pobox.com> <20051210023426.GA31220@srcf.ucam.org> <439A3FD9.40308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439A3FD9.40308@pobox.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 09:39:21PM -0500, Jeff Garzik wrote:
> Matthew Garrett wrote:
> >On Fri, Dec 09, 2005 at 07:40:08PM -0500, Jeff Garzik wrote:
> >
> >
> >>ICH6 and ICH7 support it just fine, through the normal SATA PHY 
> >>registers.  ICH5 only support it if you are clever :)
> >
> >
> >ICH6 supports it even in non-AHCI mode? You may want to update the 
> >website, then :)
> 
> Yes, its a bit outdated.  I just found out that ICH6/7 supports access 
> to SATA PHY registers even in non-AHCI mode.

Oh, cool. That makes life a /lot/ easier - most laptops I've seen using 
SATA are ICH6, so excellent!

> >>Further, although one can detect hot-unplug on ICH5, hotplug is probably 
> >>not detectable without polling or SMI.
> >
> >
> >ACPI allows us to detect hotplug on ICH5, which sounds like a good 
> >argument for its inclusion.
> 
> One special case (ICH5 hotplug, but not ICH5 hot unplug), when all other 
> cases are handled in the normal way?
> 
> That's not a good argument at all.

Well, we could always just add it to ata_piix and leave it out of the 
acpi and scsi layers. I've no great atachment to ACPI - I just want this 
stuff to work :) Basically, ACPI gives us the possibility of making 
hotplug/unplug work on hosts that don't otherwise support it under a 
limited set of conditions. I think that's worthwhile, especially if it 
can be done in a way that doesn't introduce hugely ugly stuff to the 
rest of the kernel.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
