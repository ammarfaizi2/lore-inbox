Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315788AbSEJDs6>; Thu, 9 May 2002 23:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315789AbSEJDs5>; Thu, 9 May 2002 23:48:57 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:33295 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315788AbSEJDs4>;
	Thu, 9 May 2002 23:48:56 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205100348.g4A3mtE119099@saturn.cs.uml.edu>
Subject: Re: sb16 isa non-pnp problems
To: sandos@home.se (=?iso-8859-1?Q?John_B=E4ckstrand?=)
Date: Thu, 9 May 2002 23:48:55 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001101c1f7c1$c233fba0$0319450a@sandos> from "=?iso-8859-1?Q?John_B=E4ckstrand?=" at May 10, 2002 03:26:49 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ive been trying to get my sb16 isa non-pnp working on a
> old 486, it has got two isa slots.
...
> The problems Im seeing is for the pnp card that it isnt
> detected at all, even if I do modprobe sb io=0x220
> dma=1 irq=5, I guess that is because I cant seem to be
> able to configure it using pnp, isapnp didnt print
> anything and the conf-files seemed very long-winded.

Ditch isapnp and those config files. If using Red Hat,
add "nopnp" to the kernel command line. Configure your
kernel (2.4.xx or 2.5.xx) to handle ISA PnP by itself.

> The non-pnp card is atleast detected, and I can even
> get sound from it. The sb16 DOS-util diagnose.exe from
> creative plays fine on this card, but it doesnt even
> detect the newer pnp card. Anyway, in linux I can cat
> /dev/urandom > /dev/dsp on my non-pnp, and will get
> noise. But my system will hang after about 10-20
> seconds with this. Playing a mp3 using mpg123 gets me a
> seg fault, or unable to handle paging request, aiiie:
> killing interrupt handler or some other oops.
> 
> Any ideas? I have looked into /proc/interrupts,
> /proc/ioports, /proc/dma, and there are no conflicts
> afaics. Its an oldish 486, 20mb ram, running a
> overdrive 80mhz right now.

Blame your motherboard. Many 486 motherboards have
trouble with DMA. I've had similar problems with a
real SoundBlaster16 and a "486". (IBM BlueLightning
486SLC2-66, Intel 486SX-25, and Intel DX4-75 OverDrive)

DOS DOOM played in DOS     --> crash
DOS DOOM in an OS/2 window --> OK
Linux with 8-bit sounds    --> OK
Linux with 16-bit sounds   --> crash

Forget about sound, junk the box, or use OS/2.
