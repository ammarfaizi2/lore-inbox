Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbSKJToa>; Sun, 10 Nov 2002 14:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbSKJToa>; Sun, 10 Nov 2002 14:44:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38919 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265139AbSKJTo3>; Sun, 10 Nov 2002 14:44:29 -0500
Date: Sun, 10 Nov 2002 20:42:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: vojtech@ucw.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46
Message-ID: <20021110194204.GF3068@atrey.karlin.mff.cuni.cz>
References: <20021110191822.GA1237@elf.ucw.cz> <Pine.LNX.4.44.0211101127460.9581-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211101127460.9581-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I believe you need to *store* last value given to userland.
> 
> But that's trivially done: it doesn't even have to be thread-specific, so 
> it can be just a global entry anywhere in the process data
> structures.

> This is just a random sanity check thing, after all. It doesn't have to be 
> system-global or even per-cpu. The only really important thing is that 
> "gettimeofday()" should return monotonically increasing data - and if it 
> doesn't, the vsyscall would have to ask why (sometimes it's fine, if 
> somebody did a settimeofday, but usually it's a sign of trouble).

I believe you need it system-global. If task A tells task B "its
10:30:00" and than task B does gettimeofday and gets "10:29:59", it
will be confused for sure.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
