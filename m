Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317418AbSFMCm7>; Wed, 12 Jun 2002 22:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSFMCm6>; Wed, 12 Jun 2002 22:42:58 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:55688 "EHLO
	completely") by vger.kernel.org with ESMTP id <S317418AbSFMCm5>;
	Wed, 12 Jun 2002 22:42:57 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: Kurt Wall <kwall@kurtwerks.com>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Date: Wed, 12 Jun 2002 19:42:53 -0700
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020612215014.6c2aeaf6.kwall@kurtwerks.com> <Pine.GSO.4.21.0206122152300.16357-100000@weyl.math.psu.edu> <20020612222540.23e38e0a.kwall@kurtwerks.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200206121942.56046.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On June 12, 2002 19:25, Kurt Wall wrote:
> That's *precisely* the point I tried to make. .desktop files are just
> plain text files, as far as Unix is concerned. They do not map neatly
> to Windows .lnk files because the kernel's file system layer does
> not handle them specially, as it does symlinks. God and Bill Gates
> alone know how Windows handles .lnk files, but it does seem that Windows
> imputes to them special semantics, rather like a shell script.

No, some people actually know how Windows works. The kernel has very little to 
do with .lnk files, and in fact it sees them as regular files. If you run 
"notepad foo.lnk", you will see the link's binary contents. If you use the 
CreateFile or OpenFile kernel calls, you will get a file handle pointing to 
the link's contents. If you attempt to execute a .lnk file from the command 
line or using CreateProcess, it will horribly fail.

In fact, to dereference a link in userspace, you must open the .lnk file, 
examine its contents with a library call, and then open the destination file.  
This is extremely similar to how Gnome or KDE handle .desktop files: mainly 
in the shell.

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9CAawLGMzRzbJfbQRAm05AJ4gUYliitP5APHO/IM5jPB7wukGCgCgoPFg
qGH7VCkKap7mSFAET9T3n88=
=5Oer
-----END PGP SIGNATURE-----
