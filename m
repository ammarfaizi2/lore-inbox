Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbSKJTNW>; Sun, 10 Nov 2002 14:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265104AbSKJTNW>; Sun, 10 Nov 2002 14:13:22 -0500
Received: from [195.39.17.254] ([195.39.17.254]:27908 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265102AbSKJTNP>;
	Sun, 10 Nov 2002 14:13:15 -0500
Date: Sun, 10 Nov 2002 20:18:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: vojtech@ucw.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46
Message-ID: <20021110191822.GA1237@elf.ucw.cz>
References: <20021110163012.GB1564@elf.ucw.cz> <Pine.LNX.4.44.0211101050170.9581-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211101050170.9581-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Unfortunately, this means "bye bye vsyscalls for gettimeofday".
> 
> Not necessarily. All of the fastpatch and the checking can be done by the
> vsyscall, and if the vsyscall notices that there is a backwards jump
> in

I believe you need to *store* last value given to userland. Checking
backwards jump can be dealt with, but to check for time going
backwards you need to *store* result each result of vsyscall. I do not
think that can be done from userlnad.

> That said, I suspect that the real issue with vsyscalls is that they don't
> really make much sense. The only system call we've ever found that matters
> at all is gettimeofday(), and the vsyscall implementation there looks like
> a "cool idea, but doesn't really matter (and complicates things a lot)".

I don't like vsyscalls at all...
									Pavel
-- 
When do you have heart between your knees?
