Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUAVTYf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266298AbUAVTYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:24:35 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4333 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266292AbUAVTYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:24:09 -0500
Date: Thu, 22 Jan 2004 20:24:01 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Valdis.Kletnieks@vt.edu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanitychecking
Message-ID: <20040122192401.GM6441@fs.tum.de>
References: <Pine.LNX.4.56.0401090437060.11276@jju_lnx.backbone.dif.dk> <Pine.LNX.4.44.0401092105070.1739-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401092105070.1739-100000@gaia.cela.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 09:20:53PM +0100, Maciej Zenczykowski wrote:
> > I know of the document, but thank you for pointing it out, it's quite an
> > interresting read. Actually, reading that exact document ages ago was what
> > initially caused me to start reading the ELF loading code (thinking
> > "there's got to be something wrong here").
> > I've actually been planning to use some of the crazy stunts he pulls
> > with that code as validity checks of the code I want to implement (in
> > adition to specially tailored test-cases ofcourse).
> 
> I think this points to an 'issue', if we're going to increase the checks
> in the ELF-loader (and thus increase the size of the minimal valid ELF
> file we can load, thus effectively 'bloating' (lol) some programs) we
> should probably allow some sort of direct binary executable files [i.e.
> header 'XBIN386\0' followed by Read/Execute binary code to execute by
> mapping as RX at any offset and jumping to offset 8] to allow writing
> minimal executables.  Minimalizing executables is useful for embedded
> systems, portable devices, floppy distributions and ramdisk/initrd
> situations.  Sure many of these solve this problem by UPX compressing
> busybox/crunchbox one-file-many-executables files, but it would still be
> nice to be able to dump all the extra crud in some cases.  Some of these
> distributions already contain non-standards conforming ELF files. I have a
> 933 byte less and a 305 byte strings command on my initrd (taken from some
>...

The best non-standards conforming ELF program I know is e3 [1] - a
10 kB Editor that supports Emacs-, Vi-, Pico-, Nedit- and Wordstar-like 
key bindings. Additionally, it includes a numeric calculator.

> Cheers,
> MaZe.

cu
Adrian

[1] http://www.sax.de/~adlibit/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

