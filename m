Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267390AbTBDVYb>; Tue, 4 Feb 2003 16:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbTBDVYb>; Tue, 4 Feb 2003 16:24:31 -0500
Received: from hunnerberg.nijmegen.internl.net ([217.149.192.32]:3026 "EHLO
	hunnerberg.nijmegen.internl.net") by vger.kernel.org with ESMTP
	id <S267390AbTBDVYa>; Tue, 4 Feb 2003 16:24:30 -0500
Date: Tue, 4 Feb 2003 22:28:12 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isofs hardlink bug (inode numbers different)
Message-ID: <20030204212812.GA32465@iapetus.localdomain>
References: <20030126235556.GA5560@paradise.net.nz> <b1nd5m$rhp$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1nd5m$rhp$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 07:48:06PM -0800, H. Peter Anvin wrote:
> 
> There are inode numbers stored in RockRidge attributes, but using them
> comes with some humongous caveats:
> 
> First: You have absolutely no guarantee that they are actually
> unique.  Broken software could easily have written them with all
> zeroes.
> 
> Second: If there are files on the CD-ROM *without* RockRidge
> attributes, you can get collisions with the synthesized inode numbers
> for non-RR files.

Suppose that the root of a iso9660 has entries such as '/', '.' and '..'
all with inode 2 and maybe that there are  some other indications that
the creator applied UNIX style inode numbering, wouldn't it be reasonable
to assume that inode numbers should be trusted?

In which case any wrong inode should be declared a bug in the program
that created the image?

A mount option to handle this could be useful as well.

> 
> Third: If you actually rely on inode numbers to be able to find your
> files, like most versions of Unix including old (but not current)
> versions of Linux, then they are completely meaningless.

No need to change that part, well, except maybe for knfsd if we cannot
safely export a CD-ROM but that's something I don't know.


It is annoying that wonderful zisofs backups need fixup scripts for the
hard links after a restore.

-- 
Frank
