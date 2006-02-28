Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWB1NKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWB1NKt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 08:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWB1NKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 08:10:49 -0500
Received: from spirit.analogic.com ([204.178.40.4]:3856 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750747AbWB1NKs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 08:10:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <op.s5nm6rm5j68xd1@mail.piments.com>
x-originalarrivaltime: 28 Feb 2006 13:10:45.0026 (UTC) FILETIME=[624F3020:01C63C68]
Content-class: urn:content-classes:message
Subject: Re: o_sync in vfat driver
Date: Tue, 28 Feb 2006 08:10:44 -0500
Message-ID: <Pine.LNX.4.61.0602280745500.9291@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: o_sync in vfat driver
Thread-Index: AcY8aGJYTphCxiy2SjmLRhVMbaTkzg==
References: <op.s5cj47sxj68xd1@mail.piments.com> <op.s5jpqvwhui3qek@mail.piments.com> <op.s5kxhyzgfx0war@mail.piments.com> <op.s5kx7xhfj68xd1@mail.piments.com> <op.s5kya3t0j68xd1@mail.piments.com> <op.s5ky2dbcj68xd1@mail.piments.com> <op.s5ky71nwj68xd1@mail.piments.com> <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com> <20060227132848.GA27601@csclub.uwaterloo.ca> <1141048228.2992.106.camel@laptopd505.fenrus.org> <1141049176.18855.4.camel@imp.csi.cam.ac.uk> <1141050437.2992.111.camel@laptopd505.fenrus.org> <1141051305.18855.21.camel@imp.csi.cam.ac.uk> <op.s5ngtbpsj68xd1@mail.piments.com> <Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com> <op.s5nm6rm5j68xd1@mail.piments.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <col-pepper@piments.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Feb 2006 col-pepper@piments.com wrote:

> On Mon, 27 Feb 2006 22:32:07 +0100, linux-os (Dick Johnson)
> <linux-os@analogic.com> wrote:
>
>> Flash does not get zeroed to be written! It gets erased, which sets all
>> the bits to '1', i.e., all bytes to 0xff.
>
> Thanks for the correction, but that does not change the discussion.
>
>> Further, the designers of
>> flash disks are not stupid as you assume. The direct access occurs
>> to static RAM (read/write stuff).
>
> I'm not assuming anything . Some hardware has been killed by this issue.
> http://lkml.org/lkml/2005/5/13/144

No. That hardware was not killed by that issue. The writer, or another
who had encountered the same issue, eventually repartitioned and
reformatted the device. The partition table had gotten corrupted by
some experiments and the writer assumed that the device was broken.
It wasn't.

Also, if you read other elements in this thread, you would have
learned about something that has become somewhat of a red herring.

It takes about a second to erase a 64k physical sector. This is
a required operation before it is written. Since the projected
life of these new devices is about 5 to 10 million such cycles,
(older NAND flash used in modems was only 100-200k) the writer
would have to be running that "brand new device" for at least
5 million seconds. Let's see:

60 seconds per minute
3600 seconds per hour
86400 seconds per day.

5,000,000 / 86400 = 57 days of continuous writes to the same
sector. The writer surely would have a strange file because
he states that even a single large file can destroy the drive
if it is mounted with the "sync" option.

Also, the failure mode of NAND flash is not that it becomes
"destroyed". The failure mode is a slow loss of data. The
devices no longer retain data for a zillion years, only a
few hundred, eventually, only a year or so. So when somebody
claims that the flash has gotten destroyed, they need to have
written it for a few months, then waited for a few years before
reporting the event.

Clearly the writer is wrong.

>
> It seems that it's you making the assumption that all of these devices are
> manufactured the same way.
>
> The constant dirtying of the buffer will still cause excessive use of the
> flash block hosting the FAT. Clearly not all devices use a load spreading
> mechanism and this can lead to premature failure.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
