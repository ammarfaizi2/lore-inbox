Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282080AbRK1HkM>; Wed, 28 Nov 2001 02:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282081AbRK1HkD>; Wed, 28 Nov 2001 02:40:03 -0500
Received: from c842c.nat.may.ka0.zugschlus.de ([212.126.200.66]:40713 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S281815AbRK1Hjw>; Wed, 28 Nov 2001 02:39:52 -0500
Date: Wed, 28 Nov 2001 08:39:50 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16, 8139too not loadable as a module - unresolved symbols
Message-ID: <20011128083950.A30510@torres.ka0.zugschlus.de>
In-Reply-To: <20011127150800.A25438@torres.ka0.zugschlus.de> <1006903886.1285.2.camel@marek.almaran.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1006903886.1285.2.camel@marek.almaran.home>; from marpet@linuxpl.org on Wed, Nov 28, 2001 at 12:31:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 12:31:15AM +0100, Marek Pætlicki wrote:
> W li¶cie z wto, 27-11-2001, godz. 15:08, Marc Haber pisze: 
> > on my only 2.4.16 system, modprobe 8139too gives the following errors:
> [...]
> > The same kernel, with the only config change being "y" instead of "m"
> > for 8139too, works fine, and the network interface is useable.
> > 
> > Did I do something wrong?
> 
> maybe you did, works fine for me as a module, although this driver
> doesn't want to compile with gcc 3.0.x (as said in another thread a few
> days ago).

*shrug*

> did you do the _full_ recompile of the kernel? (cp .config /tmp;make
> mrproper;cp /tmp/.config .;make oldconfig dep install modules_install)
> or did you just make modules modules_install after changing the config?

I am using Debian's kernel-package [1], and did the usual procedure for
both kernels, that I usually do:
make-kpkg clean
make-kpkg --revision=3:today.0 build
fakeroot debian/rules kernel-image-deb

This procedure has resulted in a useable kernel .deb package for the
last 18 months, and has resulted in a useable kernel .deb package for
2.4.16 with non-modularized 8139too.

Greetings
Marc

[1] which provides a comfortable way to produce self-contained .deb
packages including maintainer scripts that take care of modules,
System.map and the boot loader, from vanilla kernel sources. I repeat:
Using kernel package does not mean that vendor kernel sources are
used, the kernels are built with vanilla kernels from kernel.org.

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
