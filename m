Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314073AbSEVONG>; Wed, 22 May 2002 10:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSEVONF>; Wed, 22 May 2002 10:13:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62474 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S314073AbSEVONE>; Wed, 22 May 2002 10:13:04 -0400
Date: Wed, 22 May 2002 16:13:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
        Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020522141306.GB29028@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020521222139.GJ22878@atrey.karlin.mff.cuni.cz> <E17AWSq-0001l6-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I believe I seen some strange memcpy for PPro (or something that
> > obscure) that done out-of-order accesses to trigger prefetch logic. I
> > can't find it any more, so I can't be sure...
> 
> Its festering quietly in the glibc source tree where all large and 
> dubiously justifiable hacks seem to end up

In such case, linus, here is your "reasonable" example. For PPro, it
is faster to copy out-of-order, and if we wanted to use that for
copy_to_user, you'd have your example.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
