Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131600AbQLQBva>; Sat, 16 Dec 2000 20:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131697AbQLQBvV>; Sat, 16 Dec 2000 20:51:21 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:25102 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131600AbQLQBvH>; Sat, 16 Dec 2000 20:51:07 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14908.5332.693556.59249@wire.cadcamlab.org>
Date: Sat, 16 Dec 2000 19:20:20 -0600 (CST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: infernix@infernix.nl (infernix),
        nkbj@image.dk (Niels Kristian Bech Jensen),
        linux-kernel@vger.kernel.org (Linux kernel developer's mailing list)
Subject: Re: Unable to boot 2.4.0-test12 (0224 AX:0212 BX:BC00 CX:5101 DX:000.)
In-Reply-To: <20001216172518.M3199@cadcamlab.org>
	<E147RXw-0003OG-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [me]
> > Is there *anything* the builtin code can do better than syslinux?

[ac]
> 	scp arch/i386/boot/bzImage somebox:/dev/fd0
> 	ssh root@somebox reboot

Never thought of that one.  I would probably instead use

	scp arch/i386/boot/bzImage somebox:/tmp
	ssh root@somebox 'mcopy -o /tmp/bzImage a: && reboot'

with a known good syslinux floppy in place, but I suppose your method
*is* somewhat simpler.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
