Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVHDRSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVHDRSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVHDRQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:16:19 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:15647 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S261512AbVHDRPy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:15:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: IDE disk and HPA
Date: Thu, 4 Aug 2005 10:15:49 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C341EB82@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IDE disk and HPA
thread-index: AcWY7nw+Viy9EnTtQrWYAOu2Hp5JkQAKGNaw
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: <etienne.lorrain@masroudeau.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Aug 2005 17:15:50.0034 (UTC) FILETIME=[29415720:01C59918]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Etienne Lorrain
>Sent: Thursday, August 04, 2005 5:11 AM
>To: linux-kernel@vger.kernel.org
>Subject: Re: IDE disk and HPA
>
>> > > My question is now: why is an HPA disabled i.e. disprotected when
>> > > detected? Why not let the HPA alone, because a certain 
>set of disk
>> > > sectors shall not be accessible by the OS?
>> >
>> > Because the HPA is most commonly used to hide all but a 
>fraction of a
>> > disk to work with older BIOSes.
>>
>> But as to my knowledge, the HPA was had been introduced to allow HW
>> vendors to store things like diagnostic programs in a part of the
>> disk protected from partitioning and filesystems.
>> The point is, IF there is an HPA, there MIGHT be a partitioning
>> scheme and some filesystems on the disk which rely on the size of
>> disk being the native size MINUS the HPA.
>
>  If those HW vendors want to store software in the HPA of the IDE
> hard disk, and they employ people able to read the IDE specifications,
> they know that this HPA can be protected by password and so Linux
> just display a failure when trying to restore the capacity of the
> Hard Disk - because it lacks the unlocking password.

 Yep, you are right. When used by BIOS/firmware, it is usually 
protected by password. And interesting enough, as in this particular 
case, they employ people to not only read them, but to write them as
well ;)
  However, if not protected by the password, it is probably Ok 
to make it visible (as things currently are).

>
>  Note that this HPA is a good place to store a bootloader too, in fact
> I like to think of it as the big floppy drive of the PC which no more
> have any floppy drive: create a FAT filesystem of 64 Mbytes there and
> copy all the floppy you used to have there. Your bootloader, if it
> is good enough, will be able to run software from this area.

If your bootloader if the first thing to run in the system, you can 
use & protect portion of your hardrive for yourself - just make sure you

lock with set max with password when passing control to 'normal'
OS/loader.

Aleks.
