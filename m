Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTJTHx0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTJTHx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:53:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:9949 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262424AbTJTHxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:53:24 -0400
Date: Mon, 20 Oct 2003 09:53:23 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <37972.192.168.9.10.1066602246.squirrel@ncircle.nullnet.fi>
Subject: Re: HighPoint 374
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <975.1066636403@www51.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >> Yep, but it cannot be strictly via-chipset issue
> >> as I have verified that the same problem exists
> >> with Epox 4PCA3+ motherboard, which is P4 & Intel 875P
> >> based.
> >
> > may be epox got broken HPT's ?
> > anyone with mainboard from other vendor seeing this problems ?
> 
> This whole thread was opened by a person with HPT rocketraid 404
> PCI-card ...
> 
> >
> > my HPT BIOS is v1.24
> > mainboard BIOS last updated in september i think
> 
> I think I have exactly the same HPT-bios version.
> The mb's bios is anyway dated 2003-03-07 so I think
> we have the same version. Unfortunately, I'm unable
> to check the bios version of the 875P-base mb for now
> (but I think it was the same 1.24 as well).
> 
> Are you capable of trying if the hdparm -m0 trick
> works for you ?

you mean the fs corruption on soft raid or the interupts problem ?
i dumped the raid setup as i couldn't find a way to debug it
and my drives are pretty full again, but i'll try to free some space

for the interupts 
with test7-bk8  , acpi=off pci=noacpi &
hdparm  -m0 -d1 -X69  /dev/hd[a,e,g]
hdparm  -m16 -d1 -X69  /dev/hd[a,e,g]
i don't see timeouts
if i omit -m i do see them sometimes

(i see them both with -m and without -m if i try to use TCQ )

for testing copied several 6-10Gb directories &
dd if=/dev/zero of=/mnt/tmp/1/10Gb.zeros bs=512k count=21000
or
dd if=/dev/zero of=/mnt/tmp/1/10Gb.zeros bs=1024k count=10000

svetljo


-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

