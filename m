Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSBCW7K>; Sun, 3 Feb 2002 17:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287860AbSBCW7A>; Sun, 3 Feb 2002 17:59:00 -0500
Received: from femail19.sdc1.sfba.home.com ([24.0.95.128]:55439 "EHLO
	femail19.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287858AbSBCW6m>; Sun, 3 Feb 2002 17:58:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
Date: Sun, 3 Feb 2002 17:59:47 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org> <20020203221750.HMXG18301.femail20.sdc1.sfba.home.com@there> <3C5DB8B7.4030304@zytor.com>
In-Reply-To: <3C5DB8B7.4030304@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020203225841.IBCK18525.femail19.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 February 2002 05:24 pm, H. Peter Anvin wrote:
> Rob Landley wrote:
> > And el-torito bootable CDs basically glue a floppy image onto the front
> > of the CD and lie to the bios to say "oh yeah, I'm a floppy, boot from
> > me". Luckily, they can use the old 2.88 "extended density" floppy
> > standard IBM tried to launch years ago which never got anywhere, but
> > which most BIOS's recognize.  But that's still a fairly small place to
> > try to stick a whole system...
>
> They can be; they can also run in a mode where they can access arbitrary
> blocks on the CD (ISOLINUX runs in this mode.)
>
> 	-hpa

You can pivot_root after the bios hands control over to the kernel, sure.  
But if the bios can actually boot from arbitrary blocks on the CD before the 
kernel takes over, this is news to me.  And for the kernel to read from the 
CD, it needs its drivers already loaded for it, so they have to be in that 
2.88 megs somewhere.  (Statically linked, ramdisk, etc.)

I was just pointing out that small boot environments weren't going away any 
time soon, even if floppy drivers were to finally manage it.  When you 
install your system, the initial image you bootstrap from is generally tiny.

Now I'm not so familiar with that etherboot stuff, intel's whatsis 
specification (PXE?) for sucking a bootable image through the network.  All 
I've ever seen that boot is a floppy image, but I don't know if that's a 
limitation in the spec or just the way people are using it...

And of course you could always do some variant of two kernel monte...

Rob
