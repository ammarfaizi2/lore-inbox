Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157278-27300>; Sat, 30 Jan 1999 18:31:33 -0500
Received: by vger.rutgers.edu id <157295-27302>; Sat, 30 Jan 1999 18:24:42 -0500
Received: from snowcrash.cymru.net ([163.164.160.3]:1509 "EHLO snowcrash.cymru.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157293-27302>; Sat, 30 Jan 1999 18:22:05 -0500
Message-Id: <m106kls-0007U2C@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: CMI-8338/Pci SoundPro
To: linker@z.ml.org (Gregory Maxwell)
Date: Sun, 31 Jan 1999 00:29:51 +0000 (GMT)
Cc: linux-kernel@vger.rutgers.edu, alan@redhat.com
In-Reply-To: <Pine.LNX.3.96.990130172312.2763A-100000@z.ml.org> from "Gregory Maxwell" at Jan 30, 99 05:31:30 pm
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu

> Is there currently any work on supporting the CMI8338 PCI sound chip?

Not that I know of.

> The page claims that it has legacy SB16 support via on board ISA DMA
> emulaton (which supposdity works under real dos). I havn't gotten it
> working under Linux yet, but I only spent about 5 seconds trying so far.

The DMA stuff should work. The way the transparent ISA DMA emulation works
is horribly sick but OS independant. PCI bridges output all bus cycles
to the PCI bus first. Unclaimed ones go to the ISA bus. This means a PCI
card can watch ISA DMA being programmed and work out what the user was
trying to do. It then issues its own PCI DMA operations for the same
addresses.

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
