Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSKJTlj>; Sun, 10 Nov 2002 14:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSKJTlj>; Sun, 10 Nov 2002 14:41:39 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:28619 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265134AbSKJTlg>;
	Sun, 10 Nov 2002 14:41:36 -0500
Date: Sun, 10 Nov 2002 20:48:11 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46
Message-ID: <20021110204811.B15515@ucw.cz>
References: <20021110191822.GA1237@elf.ucw.cz> <Pine.LNX.4.44.0211101127460.9581-100000@home.transmeta.com> <20021110194204.GF3068@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021110194204.GF3068@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Sun, Nov 10, 2002 at 08:42:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 08:42:04PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > I believe you need to *store* last value given to userland.
> > 
> > But that's trivially done: it doesn't even have to be thread-specific, so 
> > it can be just a global entry anywhere in the process data
> > structures.
> 
> > This is just a random sanity check thing, after all. It doesn't have to be 
> > system-global or even per-cpu. The only really important thing is that 
> > "gettimeofday()" should return monotonically increasing data - and if it 
> > doesn't, the vsyscall would have to ask why (sometimes it's fine, if 
> > somebody did a settimeofday, but usually it's a sign of trouble).
> 
> I believe you need it system-global. If task A tells task B "its
> 10:30:00" and than task B does gettimeofday and gets "10:29:59", it
> will be confused for sure.

You just need to make sure the time difference is less than the speed of
light in the system times the distance between the two tasks. ;) Really,
relativity, and the limited speed of travel of information kicks in and
saves us here.

-- 
Vojtech Pavlik
SuSE Labs
