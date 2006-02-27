Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWB0VcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWB0VcN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWB0VcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:32:13 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:4113 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750933AbWB0VcL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:32:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <op.s5ngtbpsj68xd1@mail.piments.com>
x-originalarrivaltime: 27 Feb 2006 21:32:07.0412 (UTC) FILETIME=[42654340:01C63BE5]
Content-class: urn:content-classes:message
Subject: Re: o_sync in vfat driver
Date: Mon, 27 Feb 2006 16:32:07 -0500
Message-ID: <Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: o_sync in vfat driver
Thread-Index: AcY75UJuu4qEAfIsSkWtM40WTYTjqA==
References: <op.s5cj47sxj68xd1@mail.piments.com> <op.s5jpqvwhui3qek@mail.piments.com> <op.s5kxhyzgfx0war@mail.piments.com> <op.s5kx7xhfj68xd1@mail.piments.com> <op.s5kya3t0j68xd1@mail.piments.com> <op.s5ky2dbcj68xd1@mail.piments.com> <op.s5ky71nwj68xd1@mail.piments.com> <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com> <20060227132848.GA27601@csclub.uwaterloo.ca> <1141048228.2992.106.camel@laptopd505.fenrus.org> <1141049176.18855.4.camel@imp.csi.cam.ac.uk> <1141050437.2992.111.camel@laptopd505.fenrus.org> <1141051305.18855.21.camel@imp.csi.cam.ac.uk> <op.s5ngtbpsj68xd1@mail.piments.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <col-pepper@piments.com>
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Feb 2006 col-pepper@piments.com wrote:

> On Mon, 27 Feb 2006 15:41:44 +0100, Anton Altaparmakov <aia21@cam.ac.uk>
> wrote:
>
>> On Mon, 2006-02-27 at 15:27 +0100, Arjan van de Ven wrote:
>>> On Mon, 2006-02-27 at 14:06 +0000, Anton Altaparmakov wrote:
>>>> On Mon, 2006-02-27 at 14:50 +0100, Arjan van de Ven wrote:
>>>>> On Mon, 2006-02-27 at 08:28 -0500, Lennart Sorensen wrote:
>>>>>> On Sun, Feb 26, 2006 at 11:50:40PM +0100, col-pepper@piments.com
>>> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> OMG what do I have to do to post here? 10th attempt.
>>>>>>> {part2}
>>>>>>>
>>>>>>> Here is a non-exhaustive list of typical devices types
>>> requiring fat vfat
>>>>>>> support:
>>>>>>>
>>>>>>> fd ide-hd scsi-hd usb-hd cdrom usb-hd usb-handheld (iPod,
>>> iRiver etc)
>>>>>>> usb-flash (usbsticks, cameras, some music devices.)
>>>>>>>
>>>>>>> IIRC the sync mount option for vfat is ignored for file systems
>>>> 2G, this
>>>>>>> effectively (and probably intentionally) excludes nearly all hd
>>> partitions
>>>>>>> and iPod type devices.
>>>>>>
>>>>>> I think many people wish it was ignored on smaller devices too
>>> given
>>>>>> what it does to write performance.
>>>>>
>>>>> well. If you don't want it *DO NOT USE IT AT THE MOUNT COMMAND
>>> LINE* !!!
>>>>
>>>> That is easy to say when you are using the command line...  Modern
>>>> distros (as you know I am sure) mount all hot-plug devices like usb
>>>> keys, usb hard disks, etc automatically at plug-in time and at least
>>>> some distros use "-o sync"
>>>
>>> that is a bad misdesign of that distro or at least the tool the distro
>>> uses for this (I don't know which it is so I can say that without
>>> sounding partial :)
>>>
>>> the tool that decides to use "sync", or at least the author thereof,
>>> should be aware of what flash is, and that it has a limited lifespan etc
>>> etc, and that you thus want maximum caching etc.
>>
>> I agree completely which is why we hack the system to remove the o_sync
>> on our distro derivative.  (-:
>>
>> But my point was that your solution of "don't do that then" is not much
>> use to your average user who sits in front of such distro in graphical
>> desktop as they are not technical enough to find and hack their hotplug
>> system to work properly...
>>
>> Best regards,
>>
>>         Anton
>
>>> If you don't want it *DO NOT USE IT AT THE MOUNT COMMAND LINE* !!!
>
> Yeah, cleaver.
> That is not really a constructive responce. I dont use , I do use command
> line mount all the time. I never was in danger of damaging my drive with
> this new "feature".
>
> Telling a user who has just burnt out a brand new 1GB usb device he should
> have RTFM and modified that HAL configuration to insure it did not use
> sync it not likely to win much confidence in the linux kernel.
>
> The point of raising this is that the vast majority of linux users have no
> awareness of this. If there is a danger of this sync implementation
> damaging hardware it should be done differently.
>
> More importantly this sync strategy is very likely _increasing_ the danger
> of data loss that is the core reason for using sync in the first place.
>
> To quote from my earlier post:
>
> The new model attempts to be more rigourous by updating the FAT every time
> a block of data is written. Thus the "hammering" of the physical memory
> hosting the FAT record.

Nobody should care.

>
> In view of the nature of flash memory this may actually be drastically
> increasing the chance that the whole FAT gets erased.
>

Will not happen because that's not how they work.

> If a pullout occurs during write , there is now a near 50% chance that
> this takes out the entire FAT.
>

If a pullout or a power-failure occurs, you just have an incomplete
write, an old FAT entry just like ejecting a floppy during a write.

> Now if that analysis is inaccurate I'd like be corrected. But flash has to
> be zeroed to be written. If every second write is zeroing the FAT this
> would seem much more likely to destroy the whole fs than to provide better
> protection from a untimely pull-out.
>

Flash does not get zeroed to be written! It gets erased, which sets all
the bits to '1', i.e., all bytes to 0xff. Further, the designers of
flash disks are not stupid as you assume. The direct access occurs
to static RAM (read/write stuff). After a few milliseconds of it
becoming dirty, and/or when a new page needs to be accessed, the
chip erases some page that was not used yet, or was used a long
time ago and is not on the active list. Then, it becomes buzy,
writes the current sector to the newly erased sector, and (after
that write occurs) replaces the entry in the table that tells the
disk implimentation the logical to physical translation of that page.
In the case where a page will be changed, the new page's data is read
from the device into static RAM before access. In any case, the chip
then becomes non-buzy. The power can fail at any time and you just
have the previous data instead of the new data, just like a real
disk drive, except that the sectors are large (64 k).

You see, these are not just flash-RAM chips. They are disc drive
emulators that contain an ASIC for the bus interface and control
logic, some static RAM, and the flash RAM.

The IDE emulators, like CompaqFlash, as tiny as they are, actually
have the same pin-outs as an IDE drive!!

>
> [Note: I am not subscribed to LKML, if you wish me to recieve any follow
> ups please BCC: col-pepper at piments point com . thx]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
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
