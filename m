Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283771AbRLSJ1d>; Wed, 19 Dec 2001 04:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284608AbRLSJ1Y>; Wed, 19 Dec 2001 04:27:24 -0500
Received: from pcow035o.blueyonder.co.uk ([195.188.53.121]:65041 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S283771AbRLSJ1K>;
	Wed, 19 Dec 2001 04:27:10 -0500
Message-ID: <T57ead5b988ac1785ed28e@pcow035o.blueyonder.co.uk>
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <james@sutherland.net>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Wed, 19 Dec 2001 09:27:29 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.GSO.4.21.0112180350550.6100-100000@weyl.math.psu.edu> <T57e612d0dbac1785e6169@pcow028o.blueyonder.co.uk> <9vo4b3$iet$1@cesium.transmeta.com>
In-Reply-To: <9vo4b3$iet$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 December 2001 7:10 pm, H. Peter Anvin wrote:
> Followup to:  <T57e612d0dbac1785e6169@pcow028o.blueyonder.co.uk>
> By author:    James A Sutherland <james@sutherland.net>
> In newsgroup: linux.dev.kernel
>
> > On Tuesday 18 December 2001 8:55 am, Alexander Viro wrote:
> > > On Tue, 18 Dec 2001, James A Sutherland wrote:
> > > > Not necessarily. You could, say, put the modules in a small
> > > > filesystem image - say, Minix, or maybe ext2. Then just have the
> > > > loader put that disk image into RAM, and have the kernel able to read
> > > > disk images from RAM initially.
> > > >
> > > > Of course, this revolutionary new features needs a name. Something
> > > > like initrd, perhaps?
> > >
> > > Had you actually looked at initrd-related code?  I had and "bloody
> > > mess" is the kindest description I've been able to come up with.  Even
> > > after cleanups and boy, were they painful...
> >
> > With a choice between that, or teaching lilo, grub etc how to link
> > modules - and how to read NTFS and XFS, and losing the ability to boot
> > from fat, minix etc floppies, tftp or nfs servers - almost any level of
> > existing nastiness would be preferable to that sort of insane codebloat!
>
> Note that Al is working on a replacement; he's not just bitching. The
> replacement is called "initramfs" which means populating a ramfs from
> an archive or collection of archives passwd by the bootloader.  With
> that in there, lots of things can be done in userspace.

What I was suggesting is that using an initfs (whether initrd, initramfs or 
something else) is a better approach than trying to get the bootloader 
grovelling around in the kernel innards - initramfs strengthens this 
argument, I think. Just put the modules into archives, and use initramfs to 
access them and a copy of insmod...


James.
