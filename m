Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVLIL6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVLIL6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVLIL6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:58:52 -0500
Received: from mail.dvmed.net ([216.237.124.58]:29104 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932116AbVLIL6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:58:50 -0500
Message-ID: <43997171.9060105@pobox.com>
Date: Fri, 09 Dec 2005 06:58:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
References: <20051208132657.GA21529@srcf.ucam.org> <20051208133308.GA13267@infradead.org> <20051208133945.GA21633@srcf.ucam.org> <1134050498.17102.2.camel@localhost.localdomain> <20051208141811.GB21715@srcf.ucam.org> <1134052433.17102.17.camel@localhost.localdomain> <20051208145257.GB21946@srcf.ucam.org> <20051208171901.GA22451@srcf.ucam.org> <20051209114246.GB16945@infradead.org> <20051209114944.GA1068@havoc.gtf.org> <20051209115235.GB25771@srcf.ucam.org>
In-Reply-To: <20051209115235.GB25771@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Matthew Garrett wrote: > On Fri, Dec 09, 2005 at
	06:49:44AM -0500, Jeff Garzik wrote: > > >>If this is just for libata,
	it's still at the wrong level. >> >>libata will eventually make the
	SCSI simulator optional, which means >>any acpi_scsi_init() or whatnot
	won't work for libata. > > > It depends on notification whenever a
	device is added to the scsi bus > class, so it needs access to
	scsi_bus_type. While that could be put in > the libata layer, it seems
	cleaner to leave it in scsi and then add > another callback for libata
	when it moves to its own bus class. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Fri, Dec 09, 2005 at 06:49:44AM -0500, Jeff Garzik wrote:
> 
> 
>>If this is just for libata, it's still at the wrong level.
>>
>>libata will eventually make the SCSI simulator optional, which means
>>any acpi_scsi_init() or whatnot won't work for libata.
> 
> 
> It depends on notification whenever a device is added to the scsi bus 
> class, so it needs access to scsi_bus_type. While that could be put in 
> the libata layer, it seems cleaner to leave it in scsi and then add 
> another callback for libata when it moves to its own bus class.

If this is for hotswap, as I noted, libata doesn't need this at all.

If the hardware supports it, then libata will support it directly. 
There is no ACPI-specific magic, because ACPI does nothing but talk to 
the same hardware libata is talking to.

	Jeff



