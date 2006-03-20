Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030563AbWCTWIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030563AbWCTWIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbWCTWID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:08:03 -0500
Received: from spirit.analogic.com ([204.178.40.4]:64523 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030563AbWCTWHt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:07:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <1142890822.5007.18.camel@localhost.localdomain>
x-originalarrivaltime: 20 Mar 2006 22:07:47.0839 (UTC) FILETIME=[B8DD40F0:01C64C6A]
Content-class: urn:content-classes:message
Subject: Re: VFAT: Can't create file named 'aux.h'?
Date: Mon, 20 Mar 2006 17:07:47 -0500
Message-ID: <Pine.LNX.4.61.0603201705460.25162@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: VFAT: Can't create file named 'aux.h'?
Thread-Index: AcZMarkDwJZd2Wi1SZqBD54vU2iEdA==
References: <1142890822.5007.18.camel@localhost.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Dirk Reiners" <dreiners@iastate.edu>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Mar 2006, Dirk Reiners wrote:

>
> 	Hi everybody,
>
> while trying to back up a couple Linux directories to a FAT disk I ran
> into a weird situation: I can't create a file called aux.h on the FAT
> system!
>
> Here's how to reproduce it:
>
> cd /tmp
> dd if=/dev/zero of=vfat_img bs=1M count=1
> /sbin/losetup /dev/loop7 vfat_img
> /sbin/mkfs.vfat /dev/loop7
> mkdir vfat_mnt
> mount -t vfat /dev/loop7 vfat_mnt
> touch vfat_mnt/auy.h
> touch vfat_mnt/aux.h
>
> auy.h is happily created, aux.h gives "touch: setting times of
> `vfat_mnt/aux.h': No such file or directory", and no file is created.
> This happened to me on the system described below, but I could reproduce
> the same behavior on a system booted from RHEL4 CDs, an old Knoppix
> (3.4), and friends could reproduce it on other systems, too, so it
> doesn't seem to be very related to a specific version.
>
> As a workaround I tar/bzipped my dirs, but that behavior seems very
> unusual and doesn't inspire a lot of confidence in vfat... What am I
> missing here?
>
> Thanks
>
> 	Dirk

[SNIPPED...]

Special file under DOS: "CON", "AUX", "PRN", and a few others! The
"extension" isn't checked.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.48 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
