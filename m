Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132795AbRAQLFU>; Wed, 17 Jan 2001 06:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132796AbRAQLFK>; Wed, 17 Jan 2001 06:05:10 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:53777 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132795AbRAQLE7>; Wed, 17 Jan 2001 06:04:59 -0500
Message-ID: <3A657C56.E0EFFF4D@t-online.de>
Date: Wed, 17 Jan 2001 12:04:54 +0100
From: Jeffrey.Rose@t-online.de (Jeffrey Rose)
Organization: http://ChristForge.SourceForge.net/
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 config breaks /dev/fd0* major/minor ? *not* Fixed
In-Reply-To: <3A656749.ACF3F01A@t-online.de> <3A6567CF.E10FDEBD@mandrakesoft.com> <3A657537.F4A64F78@vz.cit.alcatel.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Gennerat wrote:
> 
> Jeff Garzik a écrit :
> 
> > Jeffrey Rose wrote:
> > > I get a wrong major/minor reported when attempting
> > > to mount /dev/fd0 ...
> >
> > Sounds like it can't find the floppy driver, for whatever reason...
> >
> 
> I have seen this message, new with 2.4.0-2mdk
> (before I have 2.4.0-0.15mdk)
> but only on one PC.
> I have 2 PC, with same hardware, same PCMCIA config
> 
> The first have mandrake 7.2 Odissey, and the modules
> floppy and floppy_cs are loaded, and /mnt/floppy is mounted
> modutils-2.4.1-1mdk
> 
> The second have mandrake 7.1 Helium, and the modules
> fail during init. and I have this message:
> 'mount: /dev/fd0 has wrong major or minor number'
> modutils-2.3.21-2mdk (the last rpm-3)
> 
> I have copied the files of modutils-2.4.1-1mdk,
> and created 2 sym.links:
> # ls -l /lib/modules/2.4.0-2mdk/pcmcia/
> total 0
> lrwxrwxrwx    1 root     root           29 jan 10 22:09 ds.o -> ../kernel/drivers/pcmcia/ds.o
> lrwxrwxrwx    1 root     root           32 jan 17 11:30 floppy.o -> ../kernel/drivers/block/floppy.o
> lrwxrwxrwx    1 root     root           35 jan 17 11:30 floppy_cs.o -> ../kernel/drivers/block/floppy_cs.o
> and now, it works!

I am not using pcmcia, as this is a desktop with ISDN (Fritz! PCI ISDN
card), but I only get more verbose error messages with the
/dev/fd0CompaQ :

#> mount /dev/fd0CompaQ /mnt/floppy
#> floppy0: sector not found: track 0, head 0, sector 3, size 2
#> floppy0: sector not found: track 0, head 0, sector 3, size 2 
#> end_request: I/O error, dev 02:04 (floppy), sector 2
#> /dev/fd0CompaQ: Input/output error
#> mount: /dev/fd0CompaQ has wrong major or minor number

I will attempt a recompile with floppy as a module (as RH 2.2.16-22 did
... /lib/modules/2.2.16-22/block/ide-floppy.o), and see if
'ide-floppy.o' and the new 2.4.1 modutils will help resolve this problem
(unless my sad Compaq Presario 5000 BIOS IRQ setup is to blame :-(

Cheers,

Jeff
-- 
<Jeffrey.Rose@t-online.de>
KEYSERVER=wwwkeys.de.pgp.net
SEARCH STRING=Jeffrey Rose
KEYID=6AD04244
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
