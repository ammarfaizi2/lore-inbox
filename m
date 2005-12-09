Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVLILmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVLILmW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVLILmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:42:22 -0500
Received: from mail.dvmed.net ([216.237.124.58]:22960 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750970AbVLILmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:42:20 -0500
Message-ID: <43996D94.5080108@pobox.com>
Date: Fri, 09 Dec 2005 06:42:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Matthew Garrett <mjg59@srcf.ucam.org>,
       Christoph Hellwig <hch@infradead.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: RFC: ACPI/scsi/libata integration and hotswap
References: <20051208030242.GA19923@srcf.ucam.org>	 <20051208091542.GA9538@infradead.org>	 <20051208132657.GA21529@srcf.ucam.org>	 <20051208133308.GA13267@infradead.org>	 <20051208133945.GA21633@srcf.ucam.org>	 <20051208135225.GA13122@havoc.gtf.org>	 <1134050863.17102.5.camel@localhost.localdomain>	 <43983FC6.6050108@pobox.com> <1134052257.17102.13.camel@localhost.localdomain>
In-Reply-To: <1134052257.17102.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Alan Cox wrote: > On Iau, 2005-12-08 at 09:14 -0500,
	Jeff Garzik wrote: > >>These are only for PATA. We don't care about
	_GTM/_STM on SATA. > > > Even your piix driver supports PATA. Put the
	foaming (justified ;)) > hatred for ACPI aside for a moment and take a
	look at the real world as > it unfortunately is right now. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2005-12-08 at 09:14 -0500, Jeff Garzik wrote:
> 
>>These are only for PATA.  We don't care about _GTM/_STM on SATA.
> 
> 
> Even your piix driver supports PATA. Put the foaming (justified ;))
> hatred for ACPI aside for a moment and take a look at the real world as
> it unfortunately is right now.

First, I clearly said "except on ata_piix ... or PATA"

Second, don't put words in my mouth.  I don't hate ACPI, and libata's 
direction for hotswap and suspend/resume has zero to do with "foaming 
hatred."

Right now, the top priority is getting SATA suspend/resume correct, and 
_hopefully_ doing it in a way that's friendly to PATA.  And as I said, 
we don't care about _GTM/_STM on SATA.

Further, all current ACPI proposed code is completely half-assed.  It's 
"hope and pray", because libata configures the device and does resets -- 
which is bound to CONFLICT WITH ACPI.

Even further, I want to support both ACPI cases (x86[-64]) and non-ACPI 
cases (other arches).  Some platforms want ACPI for passwords or other 
settings.  Some platforms don't have ACPI at all.  Locking libata into 
ACPI _only_ for suspend/resume is completely unacceptable.

I'm not a hope-n-pray kind of guy.  I want to get it right.  People are 
more than welcome to use unapplied patches floating around the 'net 
until we get there.

	Jeff


