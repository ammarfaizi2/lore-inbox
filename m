Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274270AbRJBOv3>; Tue, 2 Oct 2001 10:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275037AbRJBOvT>; Tue, 2 Oct 2001 10:51:19 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:56747 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S274270AbRJBOvP>; Tue, 2 Oct 2001 10:51:15 -0400
Date: Tue, 2 Oct 2001 11:07:14 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11-ac3 -- unresolved symbols in cramfs.o --
In-Reply-To: <E15oQIF-0004nT-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0110021057490.114-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001, Alan Cox wrote:

> > This problem is still present in 2.4.11-ac3.
> >
> > > Frank Davis <fdavis@si.rr.com> wrote:
> > >
> > > Hello all,
> > >     I received the following while 'make modules_install'
> > > depmod: *** Unresolved symbols in
> > > /lib/modules/2.4.9-ac17/kernel/fs/cramfs/cramfs/cramfs.o
> > > depmod:  zlib_fs_inflateInit_
> > > depmod:  zlib_fs_inflateEnd
>
> In what circumstances do you get this . I do cross chekx the -ac trees
> for module symbol problems so Im curious what config is triggering it.
>
> Right now I can only trigger a couple of acpi module ones

I get something similar without module support just doing a "make bzImage"
of 2.4.10-ac3.

This is on the laptop that I'm just now setting up so I don't have gpm on
it yet, but let me see what I can get, compiling...

Looks like zconf.h included from zlib_fs.h can't be found.  zconf.h
defines voidpf so all hell breaks loose when zconf.h desides to use it.

At least that is what I'm seeing here.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

