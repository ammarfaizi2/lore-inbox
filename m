Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSEUWVi>; Tue, 21 May 2002 18:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316752AbSEUWVh>; Tue, 21 May 2002 18:21:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58122 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316750AbSEUWVg>; Tue, 21 May 2002 18:21:36 -0400
Date: Wed, 22 May 2002 00:21:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Pavel Machek <pavel@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020521222139.GJ22878@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3CEAC020.4F63A181@zip.com.au> <Pine.LNX.4.33.0205211500530.1307-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Pavel makes a reasonable point that copy_*_user may elect
> > to copy the data in something other than strictly ascending
> > user virtual addresses.  In which case it's not possible to return
> > a sane "how much was copied" number.
> 
> I don't agree that that is true.
> 
> Do you have _any_ reasonable implementation taht would do that_

I believe I seen some strange memcpy for PPro (or something that
obscure) that done out-of-order accesses to trigger prefetch logic. I
can't find it any more, so I can't be sure...
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
