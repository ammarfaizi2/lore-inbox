Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSGMXYo>; Sat, 13 Jul 2002 19:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSGMXYn>; Sat, 13 Jul 2002 19:24:43 -0400
Received: from h-64-105-137-27.SNVACAID.covad.net ([64.105.137.27]:60811 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315449AbSGMXYn>; Sat, 13 Jul 2002 19:24:43 -0400
Date: Sat, 13 Jul 2002 16:27:14 -0700
From: "Adam J. Richter" <adam@freya.yggdrasil.com>
Message-Id: <200207132327.QAA08173@freya.yggdrasil.com>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: IDE/ATAPI in 2.5
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2002, Bartlomiej Zolnierkiewicz wrote:
>On Sat, 13 Jul 2002, Adam J. Richter wrote:
[...]
>> 	Are there some non-ATAPI IDE CDROM's that
>> linux-2.5.25/drivers/ide/ide-cdrom.c supports?   I was under
>> the impression that ide-cdrom.c operated only through ATAPI.

>Wrong impression. ;)
>Hint: look for STANDARD_ATAPI macro usage.

	It looks like that macro should be renamed to something like
STANDARD_MMC.  Everything that that macro controls still appears to 
go through ATA Packet Interface encapsulation.  Those quirks look like
they would likely be duplicated in a SCSI version of the same drives
anyhow.  It should be easy to have sr_mod accomodate those drives.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
