Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSFIWHQ>; Sun, 9 Jun 2002 18:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSFIWHP>; Sun, 9 Jun 2002 18:07:15 -0400
Received: from melchi.fuller.edu ([65.118.138.13]:40461 "EHLO
	melchi.fuller.edu") by vger.kernel.org with ESMTP
	id <S315278AbSFIWHO>; Sun, 9 Jun 2002 18:07:14 -0400
Date: Sun, 9 Jun 2002 15:06:16 -0700 (PDT)
From: <christoph@lameter.com>
X-X-Sender: <christoph@melchi.fuller.edu>
To: Nicholas Miell <nmiell@attbi.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Jan Pazdziora <adelton@informatics.muni.cz>,
        <linux-kernel@vger.kernel.org>, <adelton@fi.muni.cz>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <1023658610.1518.12.camel@entropy>
Message-ID: <Pine.LNX.4.33.0206091502580.17808-100000@melchi.fuller.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jun 2002, Nicholas Miell wrote:

> Why would bash even want to interpret shortcut files? They're a proprietary,
> Windows-only format that have no real use beyond icons in the Start Menu
> or on the desktop. Hacking the filesystem to treat something that
> fundamentally is not a symlink as a symlink is even stupider than
> hacking bash to do the same thing.

vfat is a proprietary windows-only format. Why are we supporting it?

If we do then lets make it as easy to use as possible including symlinks.

> One can also live with "foo.lnk". (It's much easier and saner, too.)

No one cannot untar a source tarball with symlinks in a vfat fs without
the patch. We cannot live with foo.lnk. Its insane not to carry over the
semantics as much as possible.

> > > Finally, I haven't seen any justification for why symlinks on VFAT are
> > > needed, beyond some vague statements that it's useful when dual booting.
> > > Face it, VFAT isn't a Unix filesystem and introducing ugly hacks to make
> > > it more similar to one will only cause problems in the long run. If you
> > > want symlinks, use a real filesystem or use umsdos on your favorite FAT
> > > filesystem. (Assuming that umsdos still works...).

vfat is the only fs that can be shared between microsoft oses and linux.
umsdos mangles filenames and does other ugly things. umsdos is an example
of what not to do with a fs. umsdos is a hack. vfat+symlinks is the
completion of an implementation.


