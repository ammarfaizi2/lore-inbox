Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSFIWC6>; Sun, 9 Jun 2002 18:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSFIWC5>; Sun, 9 Jun 2002 18:02:57 -0400
Received: from melchi.fuller.edu ([65.118.138.13]:26893 "EHLO
	melchi.fuller.edu") by vger.kernel.org with ESMTP
	id <S315265AbSFIWC5>; Sun, 9 Jun 2002 18:02:57 -0400
Date: Sun, 9 Jun 2002 15:02:10 -0700 (PDT)
From: <christoph@lameter.com>
X-X-Sender: <christoph@melchi.fuller.edu>
To: Nicholas Miell <nmiell@attbi.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jan Pazdziora <adelton@informatics.muni.cz>,
        <linux-kernel@vger.kernel.org>, <adelton@fi.muni.cz>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <1023648813.1188.19.camel@entropy>
Message-ID: <Pine.LNX.4.33.0206091457230.17808-100000@melchi.fuller.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jun 2002, Nicholas Miell wrote:

> Putting shortcut support into the VFAT driver is as bad a decision as
> the automatic text-file CRLF->LF conversions was, for several reasons.

I think these are two different cases. One is the file semantics the other
is the file format itself. CRLF->LF conversion has always been bad even on
the native windows platforms.

> First of all, some programs (WINE) will actually want to use the .lnk
> files, and transparently converting them to symlinks will complicate
> that.

Only the .lnk files that can be properly interpreted as symlinks are
showing up as symlink as far as I can tell. This is quite ok and very
helpful. .lnk file interpretation can be switched off and on as a boot
option.

> More importantly, shortcuts are a hell of a lot more complicated than
> has been implied. Not only can they point to local files or UNCs (the
> \\server\share\path notation), they can also point to any object in the
> (Windows) shell's namespace, which includes lots of virtual objects that
> don't actually exist on disk. With the release of the Windows Installer
> package manager, Microsoft has also added support for shortcuts that
> will either invoke the target application or prompt for that
> application's installation when they're activiated, leading to much more
> complexity to either deal with such a shortcut, or to recognize it and
> ignore it.

As said before the vfat fs would only display the convertable shortcuts
and not all.

> Finally, I haven't seen any justification for why symlinks on VFAT are
> needed, beyond some vague statements that it's useful when dual booting.
> Face it, VFAT isn't a Unix filesystem and introducing ugly hacks to make
> it more similar to one will only cause problems in the long run. If you
> want symlinks, use a real filesystem or use umsdos on your favorite FAT
> filesystem. (Assuming that umsdos still works...).

I cannot decompress a tarball with symlinks on a vfat volume without that
patch. With that patch I can use the vfat volume like a unix fs. I can
boot XP running Cygwin and build another binary from the same sources.

vfat with the patch can *create* symlinks that are compatible with other
oses.

The patch is a must have ....


