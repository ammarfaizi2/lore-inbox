Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132488AbQLJAyy>; Sat, 9 Dec 2000 19:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132509AbQLJAyp>; Sat, 9 Dec 2000 19:54:45 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:58118
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132488AbQLJAyc>; Sat, 9 Dec 2000 19:54:32 -0500
Date: Sat, 9 Dec 2000 16:23:53 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18 almost...
In-Reply-To: <3A32C128.1ED29FA2@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.10.10012091621480.6785-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2000, Michael Rothwell wrote:

> Alan Cox wrote:
> > 
> > The patch I intend to be 2.2.18 is out as 2.2.18pre26 in the usual place.
> > I'll move it over tomorrow if nobody reports any horrors, missing files etc
> 
> 
> Fresh 2.2.17, "patch -p1 < /pre-patch-2.2.18-26"
> 
> can't find file to patch at input line 38909
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |diff -u --new-file --recursive --exclude-from /usr/src/exclude
> v2.2.17/arch/i386/vmlinux.lds linux/arch/i386/vmlinux.lds
> |--- v2.2.17/arch/i386/vmlinux.lds	Wed May  3 21:22:13 2000
> |+++ linux/arch/i386/vmlinux.lds	Sat Dec  9 21:23:21 2000

So do something silly like

cp linux/arch/i386/vmlinux.lds.S linux/arch/i386/vmlinux.lds

and you will see that the patch against the files are identical.

/linux/arch/i386/Makefile

arch/i386/vmlinux.lds: arch/i386/vmlinux.lds.S FORCE
        $(CPP) -C -P -I$(HPATH) -imacros $(HPATH)/asm-i386/page_offset.h -Ui386
arch/i386/vmlinux.lds.S >arch/i386/vmlinux.lds

All it is is a leftover file........

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
