Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284360AbRLMQmD>; Thu, 13 Dec 2001 11:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284361AbRLMQlw>; Thu, 13 Dec 2001 11:41:52 -0500
Received: from dns.logatique.fr ([213.41.101.1]:14837 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S284360AbRLMQln>; Thu, 13 Dec 2001 11:41:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <orzel@kde.org>
Organization: KDE
To: linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently
Date: Thu, 13 Dec 2001 17:41:44 +0100
X-Mailer: KMail [version 1.3.6]
In-Reply-To: <20011213160007.D998D23CCB@persephone.dmz.logatique.fr> <066801c183f2$53f90ec0$5601010a@prefect>
In-Reply-To: <066801c183f2$53f90ec0$5601010a@prefect>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011213163912.5741223CCD@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks for the patch. I've thought about doing that, but it seemed to me it 
was something so much important that it would already be in some official 
kernel. 

Does it mean that NONE of the existing embedded linux is able to use a ROM 
directly as a filesystem ?? (either root fs or not)

I'm astonished. Is there some embedded-specific mailing list I'm not aware of?


Thanx,
Thomas


On Thursday 13 December 2001 17:22, Bradley D. LaRonde wrote:
> I have maintained, on and off, a patch to crafms that supports traditional
> cramfs decompress-and-read/run-from-RAM, plus direct mmaping with no
> decompression and read/run straight out of ROM:
>
>     http://www.ltc.com/~brad/mips/cramfs-linear-root-xip-linux-2.4.9-2.diff


> > I'm looking for a way to put a filesystem into ROM.
> > Seems pretty trivial, isn't it ?
> >
> > My understanding is (the way initrd does, and the way I do as of today)
> > * create a RAMDISK
> > * loads the data into ramdisk
> > * mount the ramdisk
> >
> > problem is that I don't want to waste the RAM as the data in the ROM is
> > already in the address space. (it's an embedded system, btw)
> >
> > Speed is not an issue here. ROM access might be slower than RAM, it will
> > always be so much quicker than a disk access. (wrong?)
> >
> > Ideally, i would give address/length of the fs in ROM to a function, and
> > I would get a ramdisk configured to read its data exactly there, and not
> > in ram.
> >
> > Any hint ?
> >
> > I've tried to look in the different options from mainstream kernels and
> > embedded-oriented kernels whithout success.
