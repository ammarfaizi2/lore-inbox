Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVLHOM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVLHOM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVLHOM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:12:58 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:11423 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932123AbVLHOM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:12:57 -0500
Date: Thu, 8 Dec 2005 14:12:39 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051208141238.GA21715@srcf.ucam.org>
References: <20051208030242.GA19923@srcf.ucam.org> <20051208091542.GA9538@infradead.org> <20051208132657.GA21529@srcf.ucam.org> <20051208133308.GA13267@infradead.org> <20051208133945.GA21633@srcf.ucam.org> <20051208135225.GA13122@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208135225.GA13122@havoc.gtf.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 08:52:25AM -0500, Jeff Garzik wrote:
> On Thu, Dec 08, 2005 at 01:39:45PM +0000, Matthew Garrett wrote:
> > Doing SATA suspend/resume properly on x86 depends on knowing the ACPI 
> > object that corresponds to a host or target.
> 
> Not true.

Well, where "properly" means "conforming to the ACPI spec". If _GTF is 
there, it's meant to be called. The _GTF buffer contents can potentially 
vary depending on BIOS settings, so there's no way for Linux to know 
what the correct commands to send are. And since _GTF responses can also 
depend on the information passed to _SDD, it's necessary to support that 
as well.

> > It's also the only way to 
> > support hotswap on this hardware[1],
> 
> Not true.

I was under the impression that ICH5 and ICH6 in non-AHCI mode didn't 
generate any sort of hotswap interrupt. This gets around that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
