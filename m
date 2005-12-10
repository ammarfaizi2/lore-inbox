Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbVLJAkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbVLJAkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 19:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbVLJAkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 19:40:25 -0500
Received: from mail.dvmed.net ([216.237.124.58]:62900 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932646AbVLJAkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 19:40:23 -0500
Message-ID: <439A23E8.3080407@pobox.com>
Date: Fri, 09 Dec 2005 19:40:08 -0500
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
References: <20051208141811.GB21715@srcf.ucam.org> <1134052433.17102.17.camel@localhost.localdomain> <20051208145257.GB21946@srcf.ucam.org> <20051208171901.GA22451@srcf.ucam.org> <20051209114246.GB16945@infradead.org> <20051209114944.GA1068@havoc.gtf.org> <20051209115235.GB25771@srcf.ucam.org> <43997171.9060105@pobox.com> <20051209121124.GA25974@srcf.ucam.org> <439975AB.5000902@pobox.com> <20051209122457.GB26070@srcf.ucam.org>
In-Reply-To: <20051209122457.GB26070@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Matthew Garrett wrote: > On Fri, Dec 09, 2005 at
	07:16:43AM -0500, Jeff Garzik wrote: > > >>libata will immediately
	notice the ejection without ACPI's help. > > >
	http://linux.yyz.us/sata/sata-status.html claims that ICH6 doesn't >
	support hotswap. The Intel docs seem to say the same thing. Pulling the
	> drive out generates an ACPI interrupt but not a PCI one. I'm really >
	happy to be wrong here, it's just that everything I've been able to
	find > so far suggests that ACPI is the only way to get a notification
	that the > drive has gone missing :) [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Fri, Dec 09, 2005 at 07:16:43AM -0500, Jeff Garzik wrote:
> 
> 
>>libata will immediately notice the ejection without ACPI's help.
> 
> 
> http://linux.yyz.us/sata/sata-status.html claims that ICH6 doesn't 
> support hotswap. The Intel docs seem to say the same thing. Pulling the 
> drive out generates an ACPI interrupt but not a PCI one. I'm really 
> happy to be wrong here, it's just that everything I've been able to find 
> so far suggests that ACPI is the only way to get a notification that the 
> drive has gone missing :)

ICH6 and ICH7 support it just fine, through the normal SATA PHY 
registers.  ICH5 only support it if you are clever :)

Further, although one can detect hot-unplug on ICH5, hotplug is probably 
not detectable without polling or SMI.

	Jeff


