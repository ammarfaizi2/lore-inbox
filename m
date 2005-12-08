Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVLHOSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVLHOSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVLHOSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:18:20 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:38829 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932147AbVLHOSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:18:18 -0500
Date: Thu, 8 Dec 2005 14:18:11 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051208141811.GB21715@srcf.ucam.org>
References: <20051208030242.GA19923@srcf.ucam.org> <20051208091542.GA9538@infradead.org> <20051208132657.GA21529@srcf.ucam.org> <20051208133308.GA13267@infradead.org> <20051208133945.GA21633@srcf.ucam.org> <1134050498.17102.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134050498.17102.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 02:01:38PM +0000, Alan Cox wrote:

> Something like  "pci_to_acpi(struct pcidev *)" belongs in arch specific
> code even if we do add a generic "void * pm_device" type pointer to
> struct pci_dev or struct device for such a purpose.

pci_to_acpi is already implemented in the PCI layer (see 
drivers/pci/pci-acpi.c), with struct device.firmware_data being where 
the acpi_handle ends up. I guess there's no problem in moving my code 
out to scsi-acpi.c and adding an arch_initcall for it. Would that be 
more acceptable? The only problem then is working out a clean way of 
setting up the notification structure.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
