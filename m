Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315606AbSETAfY>; Sun, 19 May 2002 20:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315609AbSETAfX>; Sun, 19 May 2002 20:35:23 -0400
Received: from wsip68-14-236-254.ph.ph.cox.net ([68.14.236.254]:54152 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S315606AbSETAfV>; Sun, 19 May 2002 20:35:21 -0400
Message-ID: <00c001c1ff96$357371a0$6caca8c0@kpfhome>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <200205192026.WAA27881@harpo.it.uu.se>
Subject: Re: lost interrupt hell - Plea for Help
Date: Sun, 19 May 2002 17:35:14 -0700
Organization: Laboratory Systems Group, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Mikael Pettersson" <mikpe@csd.uu.se>
To: <kevin@labsysgrp.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 19, 2002 01:26 PM
Subject: Re: lost interrupt hell - Plea for Help


>
> 1. It's been stated here on LKML several times that optical drives
>    should NOT be connected to Promise chips. It may work with Promise's
>    Windows drivers, but that doesn't help here. A better strategy is to
>    connect your CD-ROMs and Zip drive to the KT266A, and any IDE disks
>    either to the FastTrak or the Ultra66 add-on card (though from your
>    `lspci` I suppose your disks are SCSI).
>

I've now switched the CD drives over to the VIA IDE interfaces, and am no
longer getting "lost interrupt" messages. However, I can't succesfully rip
audio from CDs, because I get continual "packet command errors" while
cdda2wav is doing its thing. This results in extremely slow rip speeds...
This is occurring with both 2.4.19-pre8 and 2.4.19-pre8-ac4 (which I believe
has a number of Andre's latest IDE updates included). Also, trying to rip
from my first drive (/dev/cdroms/cdrom0 since I'm using devfs) produces
"cooked: Read TOC: not implemented". For some reason the ide-cd driver
thinks this drive is incapable of doing audio ripping; this may be due to
the fact that it's the master drive on the first IDE channel on the
motherboard and the BIOS left it in some strange mode...

I can mount ISO9660 CDs without apparent problems now, though, so it does
appear that there was some bad Promise/CD drive interaction before. Strange.

What else can be done to work on these audio ripping problems?

