Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSFIXDo>; Sun, 9 Jun 2002 19:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSFIXDn>; Sun, 9 Jun 2002 19:03:43 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:19393 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S315285AbSFIXDn>; Sun, 9 Jun 2002 19:03:43 -0400
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
From: Nicholas Miell <nmiell@attbi.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: christoph@lameter.com, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Jan Pazdziora <adelton@informatics.muni.cz>,
        linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <Pine.LNX.4.44.0206091643120.8715-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2002 16:03:38 -0700
Message-Id: <1023663819.1511.35.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-09 at 15:49, Thunder from the hill wrote:
> Hi,
> 
> On 9 Jun 2002, Nicholas Miell wrote:
> > Note that there's nothing stopping you from unpacking the tarball in
> > cygwin, with it's own (nicely contained, and not nearly as ugly) symlink
> > hack.
> 
> That's a hack in the cygwin libc, isn't it? It's the lib which opens 
> another file instead of the original, isn't it?
 
Yeah, and it uses the native IShellLink COM interface to do it, which
guarantees future (Windows) compatibility. Misusing the comment field to
store the path is a bit questionable, though.

Actually, if people are so hell-bent on making symlinks work on VFAT,
I'd suggest that they make a LD_PRELOAD'd shared library that intercepts
the open, lstat, symlink, etc. calls and Does The Right Thing on VFAT
filesystems. Much cleaner than putting it in the kernel or in all the
apps that might be used on a VFAT filesystem.
 
> I think VFAT is really the only real flexible transport fs for 
> linux->windows.

Yeah, I'd agree with that (until NTFS can do writing, anyway). I was
just pointing out that there are lots of filesystems that Windows can
use, not just VFAT.

- Nicholas


