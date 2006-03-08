Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWCHSjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWCHSjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 13:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWCHSjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 13:39:51 -0500
Received: from fmr19.intel.com ([134.134.136.18]:59368 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932326AbWCHSju convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 13:39:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: SATA ATAPI AHCI error messages?
Date: Wed, 8 Mar 2006 10:39:45 -0800
Message-ID: <26CEE2C804D7BE47BC4686CDE863D0F50660B36F@orsmsx410>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SATA ATAPI AHCI error messages?
Thread-Index: AcZC0fDmW8ymhqekTi+3MpdS/O6svgADX/ig
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>, <lkml@rtr.ca>
Cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Mar 2006 18:39:46.0764 (UTC) FILETIME=[AC9B58C0:01C642DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Randy.Dunlap [mailto:rdunlap@xenotime.net]
>Sent: Wednesday, March 08, 2006 9:00 AM
>To: Gaston, Jason D
>Cc: lkml@rtr.ca; alan@lxorguk.ukuu.org.uk; linux-kernel@vger.kernel.org
>Subject: Re: SATA ATAPI AHCI error messages?
>
>On Wed, 8 Mar 2006 08:16:27 -0800 Gaston, Jason D wrote:
>
>> >-----Original Message-----
>> >From: Mark Lord [mailto:lkml@rtr.ca]
>> >Sent: Wednesday, March 08, 2006 5:27 AM
>> >To: Alan Cox
>> >Cc: Gaston, Jason D; linux-kernel@vger.kernel.org
>> >Subject: Re: SATA ATAPI AHCI error messages?
>> >
>> >Alan Cox wrote:
>> >..
>> >>> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ
0xb/00/00
>> >>> sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00
00
>> 00
>> >>> sr: Current [descriptor]: sense key: Aborted Command
>> >>>     Additional sense: No additional sense information
>> >>
>> >> TUR should not be getting aborted command replies off a CD. Most
odd
>> >
>> >It's been a while, and my memory of such is fuzzy,
>> >but I think I have commonly seen ATAPI drives (in the past)
>> >that simply fail TUR as above when the drive is open
>> >or media is not present (one of those two, forgot which).
>> >
>> >Cheers
>>
>> I have media in the drive and still see the error.  We are seeing the
>> errors when the system is booting, before gnome or KDE is loaded.
>
>Yes, I have seen that also.  I posted a patch to rate-limit the
>printk's but it wasn't accepted since they are mostly there for
>debugging anyway.... or so it seems.
>
>---
>~Randy

I double checked and found that the messages do stop when media is
inserted into the drive.  They pick up again as soon as the media is
removed.

Is there any way we can get this fixed?

Thanks,

Jason

