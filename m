Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284761AbRLRTMp>; Tue, 18 Dec 2001 14:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284752AbRLRTLg>; Tue, 18 Dec 2001 14:11:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15365 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284762AbRLRTKv>; Tue, 18 Dec 2001 14:10:51 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: 18 Dec 2001 11:10:27 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vo4b3$iet$1@cesium.transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0112180350550.6100-100000@weyl.math.psu.edu> <T57e612d0dbac1785e6169@pcow028o.blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <T57e612d0dbac1785e6169@pcow028o.blueyonder.co.uk>
By author:    James A Sutherland <james@sutherland.net>
In newsgroup: linux.dev.kernel
>
> On Tuesday 18 December 2001 8:55 am, Alexander Viro wrote:
> > On Tue, 18 Dec 2001, James A Sutherland wrote:
> > > Not necessarily. You could, say, put the modules in a small filesystem
> > > image - say, Minix, or maybe ext2. Then just have the loader put that
> > > disk image into RAM, and have the kernel able to read disk images from
> > > RAM initially.
> > >
> > > Of course, this revolutionary new features needs a name. Something like
> > > initrd, perhaps?
> >
> > Had you actually looked at initrd-related code?  I had and "bloody mess"
> > is the kindest description I've been able to come up with.  Even after
> > cleanups and boy, were they painful...
> 
> With a choice between that, or teaching lilo, grub etc how to link modules - 
> and how to read NTFS and XFS, and losing the ability to boot from fat, minix 
> etc floppies, tftp or nfs servers - almost any level of existing nastiness 
> would be preferable to that sort of insane codebloat!
> 

Note that Al is working on a replacement; he's not just bitching.  The
replacement is called "initramfs" which means populating a ramfs from
an archive or collection of archives passwd by the bootloader.  With
that in there, lots of things can be done in userspace.

I had my own idea for how to do this, but I don't really seem to be
able to get the time to work it...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
