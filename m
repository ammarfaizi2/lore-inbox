Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316825AbSFJKXa>; Mon, 10 Jun 2002 06:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316826AbSFJKX3>; Mon, 10 Jun 2002 06:23:29 -0400
Received: from relay.muni.cz ([147.251.4.35]:9943 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S316825AbSFJKX2>;
	Mon, 10 Jun 2002 06:23:28 -0400
Date: Mon, 10 Jun 2002 12:23:27 +0200
From: Jan Pazdziora <adelton@informatics.muni.cz>
To: joe.mathewson@btinternet.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Message-ID: <20020610122327.F13232@anxur.fi.muni.cz>
In-Reply-To: <Pine.LNX.4.33.0206091502580.17808-100000@melchi.fuller.edu> <TiM$20020610084203$1595@fusion.mathewson.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 07:42:03AM +0000, Joseph Mathewson wrote:
> 
> Does the proposed patch give full symlink support or does it just read .lnk
> files?  Most source tarballs will not have .lnk files in them, they will have

It provides read and write and create support, for the types that are
reasonably supportable. The description is on

	http://www.fi.muni.cz/~adelton/linux/vfat-symlink/vfat-symlink.readme

and the patch is next to it.

> symlinks.  Would tar create the .lnk files if it was extracting to vfat?  If the

Right. The patch adds support for creating symlinks via .lnk files.

> patch gives symlink support in some other way than .lnk files, why can't we just
> use that and not meddle with reading the .lnk files to allow Linux to run in a
> vfat partition.

Well, because the .lnk approach in the patch is compatible both with
the Windows behaviour and the cygwin behaviour, you're getting rather
transparent symlink support.

> This is why I think MS will (and are) killing FAT 32 as quickly as they can (the
> last properly understood MS filesystem...).  To really entice users from Windows

That may be true but the notebook I got last October came with Win ME
-- just FAT32, no NTFS. So they may be killing it but it's still
around and it will be for some time to come.

> in the future, this kind of patch is going to have to work on NTFS, not FAT. 
> Now that the NT codebase is the "home" codebase as well (with the advent of XP),
> NTFS is going to take massive inroads into FAT's market share.  And there have
> been rumours for a while that MS SQL Server is going to form the basis of the
> next MS filesystem.

Can't comment on that as I don't have NTFS handy. The patch makes it
possible to mount vfat aprtition in such a way that .lnk files are not
shown as a binary mess but as a symlink, the same way they look (from
user's perspective) in Windows and in cygwin.

-- 
------------------------------------------------------------------------
  Jan Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
      ... all of these signs saying sorry but we're closed ...
------------------------------------------------------------------------
