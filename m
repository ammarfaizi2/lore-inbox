Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSFNAhr>; Thu, 13 Jun 2002 20:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317862AbSFNAhq>; Thu, 13 Jun 2002 20:37:46 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:43463 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317859AbSFNAhp>;
	Thu, 13 Jun 2002 20:37:45 -0400
Date: Thu, 13 Jun 2002 20:37:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Stevie O <stevie@qrpff.net>
cc: Francois Gouget <fgouget@free.fr>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <5.1.0.14.2.20020613195114.0225abd0@whisper.qrpff.net>
Message-ID: <Pine.GSO.4.21.0206132029130.21548-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jun 2002, Stevie O wrote:

> >_If_ you want to use "add magical 4 bytes to the end of component to
> >indicate a symlink" - more power to you, but that's nothing but a
> >detail of your filesystem layout.  You are making a directory with
> >both 'foo' and 'foo.!nk' invalid, but that's the matter of fsck for
> >your filesystem and ability of fs driver to cope with such error
> >gracefully.
> 
> Sounds great.
> 
> Now add this to NTFS, iso9660, and vfat, without directly modifying any of the three filesystems (otherwise you'd need to maintain patches for different versions of these filesystem drivers).

_I_ wouldn't need that since I'm not interested in internal business of
either of these filesystems (BTW, iso9660 is perfectly capable of supporting
symlinks - google for rockridge or just take a look at any "live fs" ISO
image from damn next to any distro).

And no, this stuff will stay on fs level.  There will be no magic flag
saying "this fs has funny symlinks implementation".  Consider that one
vetoed - and I _really_ doubt that going directly to Linus will give
you anything but LARTing in that case.  Severe LARTing, judging by
the precedents...

If modifications for vfat and ntfs will happen to have common functions -
just put them into a library and use them in both filesystems.  _If_ you
manage to convince the maintainers of VFAT and NTFS resp. that it's worth
the trouble, in the first place.

