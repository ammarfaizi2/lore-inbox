Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVG2SGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVG2SGM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbVG2SGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:06:11 -0400
Received: from spirit.analogic.com ([208.224.221.4]:37896 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S262686AbVG2SGL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:06:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <C349E772C72290419567CFD84C26E017042058@mail.esn.co.in>
References: <C349E772C72290419567CFD84C26E017042058@mail.esn.co.in>
X-OriginalArrivalTime: 29 Jul 2005 18:06:10.0268 (UTC) FILETIME=[32F9F9C0:01C59468]
Content-class: urn:content-classes:message
Subject: RE: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
Date: Fri, 29 Jul 2005 14:05:59 -0400
Message-ID: <Pine.LNX.4.61.0507291404400.15592@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
thread-index: AcWUaDMBsx/8jQHLSeGQCDmtCXdaUA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>,
       "Srinivas G." <srinivasg@esntechnologies.co.in>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



camera formatted info
----------------------
Disk /dev/tfa0: 448 cylinders, 2 heads, 32 sectors/track
Units = cylinders of 32768 bytes, blocks of 1024 bytes, counting from 0

    Device Boot Start     End   #cyls    #blocks   Id  System
/dev/tfa0p1   *      0+    449     450-     14371+   1  FAT12
/dev/tfa0p2          0       -       0          0    0  Empty
/dev/tfa0p3          0       -       0          0    0  Empty
/dev/tfa0p4          0       -       0          0    0  Empty
Warning: partition 1 extends past end of disk

If it's 488 cylinders, then it should start at 0 and end at 447,
not 449.

It looks like some kind of driver error to begin with. The
fact that it sometimes works should be overlooked until the
driver returns the correct number of cylinders (the same
number that the formatting utility gets). Check to see if
your driver could return a different disk size under different
conditions.

On Fri, 29 Jul 2005, Mukund JB. wrote:

>
> Dear Lennart, Dick Johnson, Erik Mouw & All,
>
> Thanks for all ur precious support.
>
> The cannon camera (other devices too) formatted SD is indeed a partition
> FAT12. When I said
> sfdisk -l, it showed the fs ID as 1. 1 is indeed the FAT12 fs ID.
>
> Attached are the logs for win and camera device sfdisk -Vl /dev/tfa0.
>
> The SD card formatted in camera is partitioned FAT12 disk.
> Also, the SD card formatted in windows is partitioned FAT12 disk.
> (see the attachment)
>
> on ur suggestion I verified whether camera partition device has a valid
> FS ID. I verified. It is FAT12. It is the same for windows
> formatted device. The FS ID of both the formats is 1. i.e. FAT12.
>
> I has notion that my driver is not supporting partition devices. This
> makes this clean that my driver is supporting the partition devices
> (windows formatted SD). If both are partitioned where is the difference?
>
>
> So, can someone please help me telling what else could be missing that
> is creating this problem?
>
> Regards,
> Mukund Jampala
>
>
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>> owner@vger.kernel.org] On Behalf Of Lennart Sorensen
>> Sent: Friday, July 29, 2005 7:08 PM
>> To: linux-os (Dick Johnson)
>> Cc: Srinivas G.; linux-kernel-Mailing-list
>> Subject: Re: Unable to mount the SD card formatted using the DIGITAL
> CAMREA
>> on Linux box
>>
>> On Fri, Jul 29, 2005 at 08:02:14AM -0400, linux-os (Dick Johnson)
> wrote:
>>> Execute linux `fdisk` on the device. You may find that the
>>> ID byte is wrong.
>>>
>>> Also, why do you need a special block device driver? The SanDisk
>>> and CompacFlash devices should look like IDE drives.
>>
>> SD usually is secure digital (MMC compatible somewhat I believe).  It
>> does not provide IDE unlike CompactFlash.  SD uses a serial interface
> if
>> I remember correctly.
>>
>> Len Sorensen
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
