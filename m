Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTJTJDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 05:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbTJTJDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 05:03:33 -0400
Received: from mail.gmx.de ([213.165.64.20]:27817 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262139AbTJTJDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 05:03:32 -0400
Date: Mon, 20 Oct 2003 11:03:31 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <45855.194.237.142.24.1066637022.squirrel@ncircle.nullnet.fi>
Subject: Re: HighPoint 374
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <14985.1066640611@www51.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> >> Are you capable of trying if the hdparm -m0 trick
> >> works for you ?
> >
> > you mean the fs corruption on soft raid or the interupts problem ?
> > i dumped the raid setup as i couldn't find a way to debug it
> > and my drives are pretty full again, but i'll try to free some space
> 
> I meant the interrupt problem, because if that problem exists
> there doesn't seem to be a reasonable way to figure out what
> is the reason for the filesystem corruption.
> 
> > for the interupts
> > with test7-bk8  , acpi=off pci=noacpi &
> > hdparm  -m0 -d1 -X69  /dev/hd[a,e,g]
> > hdparm  -m16 -d1 -X69  /dev/hd[a,e,g]
> > i don't see timeouts
> > if i omit -m i do see them sometimes
> 
> Ok, so if I understood you correctly, the interrupt problem
> persists _only_ if you leave the multiple sector setting on
> its default setting ? If you explicitly disable it, or set
> it to maximum it works fine ? Does it work with any value ?

-m4 & -m8 seems to work OK
each time 3 runs of the dd test
1 to hda
2 to hde

TCQ  not activated


-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

