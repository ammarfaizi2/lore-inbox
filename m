Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130882AbQLCIBT>; Sun, 3 Dec 2000 03:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130871AbQLCIBJ>; Sun, 3 Dec 2000 03:01:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:9489 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130882AbQLCIBC>; Sun, 3 Dec 2000 03:01:02 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.0-test11: arch/i386/boot/bootsect.S incompatible with Vaio C1VE (Crusoe) floppy
Date: 2 Dec 2000 23:29:45 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <90csp9$71b$1@cesium.transmeta.com>
In-Reply-To: <975784573.3a294a7dcabfd@ssl.local> <Pine.LNX.3.96.1001202131716.1450C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.96.1001202131716.1450C-100000@mandrakesoft.mandrakesoft.com>
By author:    Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
In newsgroup: linux.dev.kernel
>
> On Sat, 2 Dec 2000, Wolfgang Spraul wrote:
> > 2.4.0-test11, arch/i386/boot/bootsect.S has a probe_loop: to determine the
> > number of sectors that can be read at once (i.e. in one track).
> > 
> > This routine does not work with the Sony UDF5 USB floppy disk, mapped as an
> > Int13 device by the Vaio C1VE (Crusoe) BIOS.
> > Therefore, a bzdisk floppy will not be bootable.
> 
> The bzdisk code is used so infrequently compared to the normal
> bootloaders, lilo, grub, and syslinux, that I'm not surprised it has
> problems with many edge cases.
> 
> Although I imagine this is an unpopular opinion, I think that we
> should remove all bzdisk-type code from X86...	syslinux and other
> boot loaders handle weird BIOS quirks much better, simply because
> they are used in far more situations than bzdisk.
> 
> syslinux especially is quite nice for loading kernels from floppy.
> It's very small, and "syslinux -s" adds in some wonderfully-paranoid
> sanity checks which make boot loading works on many a quirky BIOS.
> (don't use '-s' unless you need it, of course, it slows things down...)
> 

I concur, but I'm biased :)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
