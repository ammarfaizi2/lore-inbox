Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWCHQ5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWCHQ5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWCHQ5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:57:50 -0500
Received: from xenotime.net ([66.160.160.81]:38628 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751514AbWCHQ5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:57:50 -0500
Date: Wed, 8 Mar 2006 08:59:34 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: lkml@rtr.ca, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: SATA ATAPI AHCI error messages?
Message-Id: <20060308085934.d31bfee8.rdunlap@xenotime.net>
In-Reply-To: <26CEE2C804D7BE47BC4686CDE863D0F50660AFB6@orsmsx410>
References: <26CEE2C804D7BE47BC4686CDE863D0F50660AFB6@orsmsx410>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2006 08:16:27 -0800 Gaston, Jason D wrote:

> >-----Original Message-----
> >From: Mark Lord [mailto:lkml@rtr.ca]
> >Sent: Wednesday, March 08, 2006 5:27 AM
> >To: Alan Cox
> >Cc: Gaston, Jason D; linux-kernel@vger.kernel.org
> >Subject: Re: SATA ATAPI AHCI error messages?
> >
> >Alan Cox wrote:
> >..
> >>> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
> >>> sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00
> 00
> >>> sr: Current [descriptor]: sense key: Aborted Command
> >>>     Additional sense: No additional sense information
> >>
> >> TUR should not be getting aborted command replies off a CD. Most odd
> >
> >It's been a while, and my memory of such is fuzzy,
> >but I think I have commonly seen ATAPI drives (in the past)
> >that simply fail TUR as above when the drive is open
> >or media is not present (one of those two, forgot which).
> >
> >Cheers
> 
> I have media in the drive and still see the error.  We are seeing the
> errors when the system is booting, before gnome or KDE is loaded.

Yes, I have seen that also.  I posted a patch to rate-limit the
printk's but it wasn't accepted since they are mostly there for
debugging anyway.... or so it seems.

---
~Randy
