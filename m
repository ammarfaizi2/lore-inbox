Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbWBQUjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbWBQUjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWBQUjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:39:32 -0500
Received: from spirit.analogic.com ([204.178.40.4]:14348 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751755AbWBQUjc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:39:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <7c3341450602171224y5eba2095o@mail.gmail.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 17 Feb 2006 20:39:27.0952 (UTC) FILETIME=[3F146D00:01C63402]
Content-class: urn:content-classes:message
Subject: Re: C/H/S from user space
Date: Fri, 17 Feb 2006 15:39:17 -0500
Message-ID: <Pine.LNX.4.61.0602171534320.4415@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: C/H/S from user space
Thread-Index: AcY0Aj8b6KNwtkTsR3mLwsMjWOjydA==
References: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com> <43F617FA.2030609@wolfmountaingroup.com> <Pine.LNX.4.61.0602171452520.4290@chaos.analogic.com> <7c3341450602171224y5eba2095o@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nick Warne" <nick@linicks.net>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Feb 2006, Nick Warne wrote:

> > So, since Linux doesn't destroy that information remaining in
>> the BIOS tables, I show how to make it available to a 'root' user.
>> Observation over several machines will show that the BIOS always
>> uses the same stuff for large media and, in fact, it has no choice.
>> Basically, this means that the first part of the boot-code, the
>> stuff that needs to be translated to fit into the int 0x13 registers,
>> needs to be below 1024 cylinders, 63 sectors-track, and 256 heads.
>> Trivial... even LILO was able to do that! Once the machine boots
>> past the requirement to use the BIOS services, it's a CHS=NOP.
>
>
> If I am off the mark here, forgive me.
>
> Since I moved exclusively to GNU/Linux 2 years ago, I notice when I
> update kernel I get this:
>
> nick@linuxamd:nick$ sudo /sbin/lilo -v
> LILO version 22.5.9, Copyright (C) 1992-1998 Werner Almesberger
> Development beyond version 21 Copyright (C) 1999-2004 John Coffman
> Released 08-Apr-2004 and compiled at 00:18:50 on May 21 2004.
>
> Warning: LBA32 addressing assumed
> Reading boot sector from /dev/hda2
> Warning: Kernel & BIOS return differing head/sector geometries for device 0x80
>    Kernel: 65535 cylinders, 16 heads, 63 sectors
>      BIOS: 1024 cylinders, 255 heads, 63 sectors
> Warning: Kernel & BIOS return differing head/sector geometries for device 0x81
>    Kernel: 29777 cylinders, 16 heads, 63 sectors
>      BIOS: 1024 cylinders, 255 heads, 63 sectors
>
> Now, from day one I never used the -v option with lilo, but as I get
> more experienced (!) I do now and see the above... I have never
> investigated due to worrying if I start messing with it I will trash
> my disks - as I see all anyway on this disks (and no errors), all
> works great/fast etc.
>
> Is this what is going on here (re this thread?).
>
> Nick
>

Nothing to worry about. If you make lots of new kernels to
try them out, you might wish to use GRUB instead of LILO.

However, once the boot-process gets out of 16-bit mode, it
isn't going to use the 16-bit disk services so it doesn't
care about any of that stuff. C/H/S is just a "key" to get
you through the fact that the 16-bit BIOS puts some minimal
stuff in registers to access the disk.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
