Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131471AbRARJB3>; Thu, 18 Jan 2001 04:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132035AbRARJBT>; Thu, 18 Jan 2001 04:01:19 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:24617 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S131471AbRARJBG>;
	Thu, 18 Jan 2001 04:01:06 -0500
Message-ID: <3A66B086.F0E81BB8@vz.cit.alcatel.fr>
Date: Thu, 18 Jan 2001 09:59:50 +0100
From: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: paul@paulbristow.net
CC: Linux-Kernel <linux-kernel@vger.kernel.org>,
        David Hinds <dhinds@sonic.net>
Subject: Re: PCMCIA problem loading ide-floppy from ide_cs
In-Reply-To: <3A65FD84.129CA315@Hell.WH8.TU-Dresden.De> <01011722372302.01013@zoltar.quantum.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Bristow a écrit :

> Hi,
>
> I am trying to understand the new PCMCIA configuration.  So far I am trying
> to use the kernel PCMCIA driver.  The yenta_socket driver is working fine.
>
> Using 2.4.0, and cardmgr 3.1.23
>
> When I insert my Iomega Clik drive, cardmgr correctly identifies it as an ATA
> Fixed Disk and loads ide_cs.  ide_cs does the ide_probe and correctly assumes
> that the drive is an ide-floppy.  However at this point it doesn't seem to
> even try to load the module.  KMOD is set to y in .config
>
> If I preload the ide-floppy module everything loads up fine and I can use the
> drive perfectly.  However, when I do a cardctl eject 0, everything screws up.
> The eject command says it works, unlinks ide_cs, but seems to leave
> ide-floppy working!  and yes, I have run depmod -a about a zillion times.
>
> modprobe -nv finds the modules no problem.

with modutils-2.4.1-1mdk I had to create some new sym-links

# ls -l /lib/modules/2.4.0-2mdk/pcmcia/
total 0
lrwxrwxrwx     ide_cs.o -> ../kernel/drivers/ide/ide-cs.o
lrwxrwxrwx     floppy.o -> ../kernel/drivers/block/floppy.o
lrwxrwxrwx     floppy_cs.o -> ../kernel/drivers/block/floppy_cs.o
-
I think you must do the same for ide-floppy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
