Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSFJLA3>; Mon, 10 Jun 2002 07:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSFJLA2>; Mon, 10 Jun 2002 07:00:28 -0400
Received: from relay.muni.cz ([147.251.4.35]:32232 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S314553AbSFJLA1>;
	Mon, 10 Jun 2002 07:00:27 -0400
Date: Mon, 10 Jun 2002 13:00:25 +0200
From: Jan Pazdziora <adelton@informatics.muni.cz>
To: Nicholas Miell <nmiell@attbi.com>
Cc: linux-kernel@vger.kernel.org, adelton@fi.muni.cz
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Message-ID: <20020610130025.G13232@anxur.fi.muni.cz>
In-Reply-To: <200206092053.g59Krsl506602@saturn.cs.uml.edu> <1023658610.1518.12.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 02:36:49PM -0700, Nicholas Miell wrote:
> > 
> > WINE needs to be able to handle a symlink on ext2, so it can
> > damn well convert back. It's OK to give WINE some hack to get at
> > the content; it's not OK to hack bash to interpret .lnk files.
> 
> Why would bash even want to interpret shortcut files? They're a proprietary,
> Windows-only format that have no real use beyond icons in the Start Menu
> or on the desktop. Hacking the filesystem to treat something that

Well, you could say that about FAT as well.

> fundamentally is not a symlink as a symlink is even stupider than
> hacking bash to do the same thing.

The symlink file can have more functions as you have stated, and one
of them is symlink. It works in Windows and it works in cygwin. Support
for symlinks on vfat is similar to long names, for example -- you
could live with abbreviations but it's reasonable to be compatible
with the other party.

> > One can live with an occasional broken symlink:
> > "foo" --> "[UNIMPLEMENTED LINK TYPE]"
> 
> One can also live with "foo.lnk". (It's much easier and saner, too.)

It's not. The content of the file is not nicely readable. And
operation done on the file in Windows and on Linux (like writing the
file) now differs because Windows (and cygwin) follow the symlink
while Linux with vfat mounted does not.

> > > Finally, I haven't seen any justification for why symlinks on VFAT are
> > > needed, beyond some vague statements that it's useful when dual booting.

Similar reason why the vfat support is in, isn't it? :-)

> > > Face it, VFAT isn't a Unix filesystem and introducing ugly hacks to make
> > > it more similar to one will only cause problems in the long run. If you
> > > want symlinks, use a real filesystem or use umsdos on your favorite FAT
> > > filesystem. (Assuming that umsdos still works...).

It's not "want symlinks", it's more like "want similar behaviour" and
"be compatible".

-- 
------------------------------------------------------------------------
  Jan Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
      ... all of these signs saying sorry but we're closed ...
------------------------------------------------------------------------
