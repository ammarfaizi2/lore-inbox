Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287896AbSBCXqV>; Sun, 3 Feb 2002 18:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286723AbSBCXqL>; Sun, 3 Feb 2002 18:46:11 -0500
Received: from femail25.sdc1.sfba.home.com ([24.254.60.15]:58078 "EHLO
	femail25.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287868AbSBCXp4>; Sun, 3 Feb 2002 18:45:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
Date: Sun, 3 Feb 2002 18:47:01 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org> <20020203225841.IBCK18525.femail19.sdc1.sfba.home.com@there> <3C5DC138.3080106@zytor.com>
In-Reply-To: <3C5DC138.3080106@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020203234556.DOZQ23516.femail25.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 February 2002 06:01 pm, H. Peter Anvin wrote:
> Rob Landley wrote:
> > You can pivot_root after the bios hands control over to the kernel, sure.
> > But if the bios can actually boot from arbitrary blocks on the CD before
> > the kernel takes over, this is news to me.  And for the kernel to read
> > from the CD, it needs its drivers already loaded for it, so they have to
> > be in that 2.88 megs somewhere.  (Statically linked, ramdisk, etc.)
>
> No, the boot specification allows direct access to the CD.  See the El
> Torito specification, specifically the parts that talk about "no
> emulation" mode.

Thanks.  I'd missed that.

> > Now I'm not so familiar with that etherboot stuff, intel's whatsis
> > specification (PXE?) for sucking a bootable image through the network. 
> > All I've ever seen that boot is a floppy image, but I don't know if
> > that's a limitation in the spec or just the way people are using it...
>
> That's just the way *some* people are using it.  Look at PXELINUX for
> something that doesn't.  PXELINUX can use the UDP API provided by the
> PXE specification to download arbitrary files, specified at runtime, via
> TFTP.

That one I suspected.  (I used the TFTP setup on solaris and power PC years 
ago, just didn't know if x86 bioses had caught up.  Most of my BIOS 
experience in the past few years has been with Dell machines, so my 
expectations may have been unnecessarily lowered... :)  On the other hand, 
very few systems in the field seem to boot and install entirely through the 
network unless they're meant to be diskless...

> 	-hpa

Rob
