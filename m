Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSGNGRx>; Sun, 14 Jul 2002 02:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSGNGRx>; Sun, 14 Jul 2002 02:17:53 -0400
Received: from h-64-105-137-27.SNVACAID.covad.net ([64.105.137.27]:32656 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315628AbSGNGRw>; Sun, 14 Jul 2002 02:17:52 -0400
Date: Sat, 13 Jul 2002 23:20:28 -0700
From: "Adam J. Richter" <adam@freya.yggdrasil.com>
Message-Id: <200207140620.XAA23582@freya.yggdrasil.com>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: IDE/ATAPI in 2.5
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2002, Bartlomiej Zolnierkiewicz wrote:
>On Sat, 13 Jul 2002, Adam J. Richter wrote:
>> On Sat, 13 Jul 2002, Bartlomiej Zolnierkiewicz wrote:
>> >Wrong impression. ;)
>> >Hint: look for STANDARD_ATAPI macro usage.
>>
>>       It looks like that macro should be renamed to something like
>> STANDARD_MMC.  Everything that that macro controls still appears to
>> go through ATA Packet Interface encapsulation.  Those quirks look like
>
>Please verify against sff8020.

	I don't know what you mean by this.  It's not a question of
whether the behavior being accomodated is conformant or nonconformant
to a standard.  The question is whether the accomodations controlled
by the "STANDARD_ATAPI" macro can easily be implemented in sr_mod.
Since the accomodations are translating a couple of numbers that
are repeseneted as binary coded decimal instead of integers (0-255)
on some drives, and sending a slightly different SCSI command to
change discs on a Sanyo three CD changer, it seems that they can easily
be implemented in sr_mod.

>> they would likely be duplicated in a SCSI version of the same drives
>> anyhow.  It should be easy to have sr_mod accomodate those drives.
>
>I can't find them, there are some in sr_vendor.c but they are diffirent

	From you email address, I would guess that English is not your
first language.  While you do write English very well, I think you made
a mistake in understanding what I siad.  "It should be easy to
have sr_mod accomodate those drives" means that it would be easy for
someone to write code in the near future to do this (that is, to change
sr_mod.c).  It does not mean that it has already been done.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
