Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSKBVWX>; Sat, 2 Nov 2002 16:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSKBVWX>; Sat, 2 Nov 2002 16:22:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12563 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261426AbSKBVWW>; Sat, 2 Nov 2002 16:22:22 -0500
Date: Sat, 2 Nov 2002 22:28:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, Dave Jones <davej@codemonkey.org.uk>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [announce] swap mini-howto
Message-ID: <20021102212851.GB21280@atrey.karlin.mff.cuni.cz>
References: <20021102165503.GC1983@elf.ucw.cz> <Pine.LNX.4.44L.0211021919230.3411-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211021919230.3411-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > > That has changed in 2.5.  Swapping onto a regular file has no
> > > disadvantage wrt swapping onto a block device.  The kernel does
> > > not need to allocate any memory at all to get a swapcache page
> > > onto disk.
> >
> > Well, you can swsusp to partition. You can't swsusp to a file, as that
> > is very hard to do.
> 
> Why is it very hard to do ?
> 
> For the swap layer, swap to a partition or to a file is the
> same thing.
> 
> Does swsusp rely on restoring memory from the swap partition
> before mounting the root filesystem or is there more behind
> your objection ?

Yep, I rely on that.

[Even read-only mount of ext3 might cause journal replay, which means
data corruption. If there's real-read-only mode, resume-from-file
might be doable.
							Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
