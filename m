Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSFIWaG>; Sun, 9 Jun 2002 18:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSFIWaF>; Sun, 9 Jun 2002 18:30:05 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:27581 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S315275AbSFIWaE>; Sun, 9 Jun 2002 18:30:04 -0400
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
From: Nicholas Miell <nmiell@attbi.com>
To: christoph@lameter.com
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Jan Pazdziora <adelton@informatics.muni.cz>,
        linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <Pine.LNX.4.33.0206091502580.17808-100000@melchi.fuller.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2002 15:30:00 -0700
Message-Id: <1023661800.1511.23.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-09 at 15:06, christoph@lameter.com wrote:
> On 9 Jun 2002, Nicholas Miell wrote:
> 
> > Why would bash even want to interpret shortcut files? They're a proprietary,
> > Windows-only format that have no real use beyond icons in the Start Menu
> > or on the desktop. Hacking the filesystem to treat something that
> > fundamentally is not a symlink as a symlink is even stupider than
> > hacking bash to do the same thing.
> 
> vfat is a proprietary windows-only format. Why are we supporting it?

It may be proprietary, but it is well documented (by Microsoft, even)
and well understood.

And note that trying to fully support VFAT in Linux has been problematic
in the past, especially w.r.t. NFS exports.
 
> If we do then lets make it as easy to use as possible including symlinks.
> 
> > One can also live with "foo.lnk". (It's much easier and saner, too.)
> 
> No one cannot untar a source tarball with symlinks in a vfat fs without
> the patch. We cannot live with foo.lnk. Its insane not to carry over the
> semantics as much as possible.

Beating a square peg into a round hole is also rather crazy.

Note that there's nothing stopping you from unpacking the tarball in
cygwin, with it's own (nicely contained, and not nearly as ugly) symlink
hack.
 
> > > > Finally, I haven't seen any justification for why symlinks on VFAT are
> > > > needed, beyond some vague statements that it's useful when dual booting.
> > > > Face it, VFAT isn't a Unix filesystem and introducing ugly hacks to make
> > > > it more similar to one will only cause problems in the long run. If you
> > > > want symlinks, use a real filesystem or use umsdos on your favorite FAT
> > > > filesystem. (Assuming that umsdos still works...).
> 
> vfat is the only fs that can be shared between microsoft oses and linux.
> umsdos mangles filenames and does other ugly things. umsdos is an example
> of what not to do with a fs. umsdos is a hack. vfat+symlinks is the
> completion of an implementation.
>

Don't forget NTFS, SMBFS, ISO-9660, HPFS (if Windows still supports
it...), and plain old FAT.

There's also third-party support for NFS, HFS, VxFS and others.

