Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVLILwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVLILwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVLILwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:52:54 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:7088 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751321AbVLILww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:52:52 -0500
Date: Fri, 9 Dec 2005 11:52:36 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051209115235.GB25771@srcf.ucam.org>
References: <20051208132657.GA21529@srcf.ucam.org> <20051208133308.GA13267@infradead.org> <20051208133945.GA21633@srcf.ucam.org> <1134050498.17102.2.camel@localhost.localdomain> <20051208141811.GB21715@srcf.ucam.org> <1134052433.17102.17.camel@localhost.localdomain> <20051208145257.GB21946@srcf.ucam.org> <20051208171901.GA22451@srcf.ucam.org> <20051209114246.GB16945@infradead.org> <20051209114944.GA1068@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209114944.GA1068@havoc.gtf.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 06:49:44AM -0500, Jeff Garzik wrote:

> If this is just for libata, it's still at the wrong level.
> 
> libata will eventually make the SCSI simulator optional, which means
> any acpi_scsi_init() or whatnot won't work for libata.

It depends on notification whenever a device is added to the scsi bus 
class, so it needs access to scsi_bus_type. While that could be put in 
the libata layer, it seems cleaner to leave it in scsi and then add 
another callback for libata when it moves to its own bus class.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
