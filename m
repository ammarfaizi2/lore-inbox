Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131109AbRAQKgD>; Wed, 17 Jan 2001 05:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132342AbRAQKfy>; Wed, 17 Jan 2001 05:35:54 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:34141 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S131394AbRAQKfo>;
	Wed, 17 Jan 2001 05:35:44 -0500
Message-ID: <3A657537.F4A64F78@vz.cit.alcatel.fr>
Date: Wed, 17 Jan 2001 11:34:31 +0100
From: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Jeffrey Rose <Jeffrey.Rose@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 config breaks /dev/fd0* major/minor ? Fixed
In-Reply-To: <3A656749.ACF3F01A@t-online.de> <3A6567CF.E10FDEBD@mandrakesoft.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik a écrit :

> Jeffrey Rose wrote:
> > I get a wrong major/minor reported when attempting
> > to mount /dev/fd0 ...
>
> Sounds like it can't find the floppy driver, for whatever reason...
>

I have seen this message, new with 2.4.0-2mdk
(before I have 2.4.0-0.15mdk)
but only on one PC.
I have 2 PC, with same hardware, same PCMCIA config

The first have mandrake 7.2 Odissey, and the modules
floppy and floppy_cs are loaded, and /mnt/floppy is mounted
modutils-2.4.1-1mdk

The second have mandrake 7.1 Helium, and the modules
fail during init. and I have this message:
'mount: /dev/fd0 has wrong major or minor number'
modutils-2.3.21-2mdk (the last rpm-3)

I have copied the files of modutils-2.4.1-1mdk, 
and created 2 sym.links:
# ls -l /lib/modules/2.4.0-2mdk/pcmcia/
total 0
lrwxrwxrwx    1 root     root           29 jan 10 22:09 ds.o -> ../kernel/drivers/pcmcia/ds.o
lrwxrwxrwx    1 root     root           32 jan 17 11:30 floppy.o -> ../kernel/drivers/block/floppy.o
lrwxrwxrwx    1 root     root           35 jan 17 11:30 floppy_cs.o -> ../kernel/drivers/block/floppy_cs.o
and now, it works!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
