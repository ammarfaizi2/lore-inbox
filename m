Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315927AbSEGSHH>; Tue, 7 May 2002 14:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSEGSHG>; Tue, 7 May 2002 14:07:06 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42134 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315927AbSEGSHF>; Tue, 7 May 2002 14:07:05 -0400
Date: Tue, 7 May 2002 20:06:34 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Roman Zippel <zippel@linux-m68k.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
Message-ID: <Pine.SOL.4.30.0205071957130.24930-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> we should fix atari byte-swapped ide in ata_read() like we do in
>> atapi_read() then ide_fix_driveid() will make rest...
>> (or I am missing something?)
>
> Here you can mix two different issues:
>  - Ataris have a byte-swapped IDE interface. Hence we need support to
>    swap data for interoperability (not only on Atari: imagine an Atari disk
>    connected to a PC)

dealt in (arch/parameter) specific ata_read()
reverses byteswapped data

>  - IDE is little endian, so the drive identification is little endian too.
>    To make things more complex, not only multibyte objects, but also
>    text strings are byteswapped.

dealt in generic ide_fix_driveid()
converts driveid to cpu endianness

greetings...
--
bkz

