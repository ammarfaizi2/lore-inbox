Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317924AbSGWMzM>; Tue, 23 Jul 2002 08:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317928AbSGWMzM>; Tue, 23 Jul 2002 08:55:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:45000 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317924AbSGWMzL>; Tue, 23 Jul 2002 08:55:11 -0400
Date: Tue, 23 Jul 2002 14:58:15 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Witek Krecicki <adasi@kernel.pl>
cc: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Build Errors] kernel version 2.5.27
In-Reply-To: <018c01c23245$c8434820$0201a8c0@witek>
Message-ID: <Pine.NEB.4.44.0207231451050.10993-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002, Witek Krecicki wrote:

> > Don't know if this can be helpful at all, but having a "powerful" (AMD XP
> > 1700+, 256 MB DDR and 7200 rpm IDE disk) PC doing nothing most of the
> > time, I thought it could be doing something useful for the ongoing
> > development of the linux kernel. So I decided to do a full kernel compile
> > (that is, a compile of the linux kernel with _all_ options enabled to be
> > compiled built-in, just a few as modules, those that can't be built
> > otherwise). And report errors that can happen, in the hope to unveil
> > them and make maintainers aware of them, should they still aren't.
> >
> > .config file was created the "easy" way: going to all options shown in a
> > "make menuconfig" session, enabling everything to be built-in (when
> > possible), and making a second pass to check if some options were
> > activated by enabling some others. The file is 2206 lines long, but is
> > NOT attached, to help save bandwidth.
> IMHO building everything as a module is much better in this case. Some
> things are working built-in but not working as modules (eg.
> probably-still-not-fixed 2.5 IDE with 2 symbols not exported properly). It
> would be better to build everything as a module and then check it with
> depmod so any unresolved deps could be shown

Why not try both? I do currently use three .configs:
- everything modular
- everything but no module support at all
- everything and no module support at all but without hotplug support

For 2.5 I use similar .configs but without all the things that don't
compile for a longer time.

Trying to compile kernels with these three .configs helps to avoid that my
fast 500 MHz K6-2 is nearly always idle.  ;-)

> WK

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

