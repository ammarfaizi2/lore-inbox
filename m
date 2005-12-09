Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVLIMQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVLIMQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 07:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVLIMQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 07:16:53 -0500
Received: from mail.dvmed.net ([216.237.124.58]:37040 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750782AbVLIMQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 07:16:50 -0500
Message-ID: <439975AB.5000902@pobox.com>
Date: Fri, 09 Dec 2005 07:16:43 -0500
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
References: <20051208133945.GA21633@srcf.ucam.org> <1134050498.17102.2.camel@localhost.localdomain> <20051208141811.GB21715@srcf.ucam.org> <1134052433.17102.17.camel@localhost.localdomain> <20051208145257.GB21946@srcf.ucam.org> <20051208171901.GA22451@srcf.ucam.org> <20051209114246.GB16945@infradead.org> <20051209114944.GA1068@havoc.gtf.org> <20051209115235.GB25771@srcf.ucam.org> <43997171.9060105@pobox.com> <20051209121124.GA25974@srcf.ucam.org>
In-Reply-To: <20051209121124.GA25974@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Matthew Garrett wrote: > On Fri, Dec 09, 2005 at
	06:58:41AM -0500, Jeff Garzik wrote: > > >>If this is for hotswap, as I
	noted, libata doesn't need this at all. >> >>If the hardware supports
	it, then libata will support it directly. >>There is no ACPI-specific
	magic, because ACPI does nothing but talk to >>the same hardware libata
	is talking to. > > > If libata knows how to talk to the random hardware
	attached to a Dell > laptop hotswap bay, I'll be amazed. Ejecting the
	drive generates a > system management interrupt, which then causes the
	ACPI code to check a > register in a block of machine-specific
	registers and generate an ACPI > notification. As far as I can tell,
	the controller has no say in the > matter at all - the Intel specs seem
	to suggest that ICH6 doesn't > generate a hotswap interrupt unless
	you're using AHCI (which this > hardware doesn't). [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Fri, Dec 09, 2005 at 06:58:41AM -0500, Jeff Garzik wrote:
> 
> 
>>If this is for hotswap, as I noted, libata doesn't need this at all.
>>
>>If the hardware supports it, then libata will support it directly. 
>>There is no ACPI-specific magic, because ACPI does nothing but talk to 
>>the same hardware libata is talking to.
> 
> 
> If libata knows how to talk to the random hardware attached to a Dell 
> laptop hotswap bay, I'll be amazed. Ejecting the drive generates a 
> system management interrupt, which then causes the ACPI code to check a 
> register in a block of machine-specific registers and generate an ACPI 
> notification. As far as I can tell, the controller has no say in the 
> matter at all - the Intel specs seem to suggest that ICH6 doesn't 
> generate a hotswap interrupt unless you're using AHCI (which this 
> hardware doesn't).

libata will immediately notice the ejection without ACPI's help.

	Jeff


