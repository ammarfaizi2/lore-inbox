Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293013AbSB1UOy>; Thu, 28 Feb 2002 15:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293441AbSB1UNE>; Thu, 28 Feb 2002 15:13:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21779 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293716AbSB1UMx>; Thu, 28 Feb 2002 15:12:53 -0500
Date: Thu, 28 Feb 2002 21:12:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Sync over loop devices takes ages? [2.4.17]
Message-ID: <20020228201248.GA20466@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020228095955.GH774@elf.ucw.cz> <3C7E716E.9DC59B12@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7E716E.9DC59B12@zip.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have a script (attached). At one point it tries to do sync... That
> > sync take a long time, with disk mostly unused.
> 
> When doing (say) ext2-on-loop-on-ext2 you should always ensure
> that the blocksize for the topmost filesystem is the same as
> the one underneath.  So probably you wanted `mkfs.ext2 -b 4096'.
> 
> If you have a 1k blocksize filesystem loop-mounted on a 4k blocksize
> filesystem, every write of a 1k block requires a read of the underlying
> 4k block. Which is excrutiatingly slow.

Oh, but I *want* to do 1k filesystem test!

Performance seems okay in 2.4.19-pre?aa?.... And even 2.4.18 is
slightly faster. [BTW it is fully cached (100MB test on 256MB machine)
so 4k reads should not be such a big problem.]
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


