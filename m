Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279822AbRKFRCB>; Tue, 6 Nov 2001 12:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279814AbRKFRBv>; Tue, 6 Nov 2001 12:01:51 -0500
Received: from pasky.ji.cz ([62.44.12.54]:49145 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S279812AbRKFRBk>;
	Tue, 6 Nov 2001 12:01:40 -0500
Date: Tue, 6 Nov 2001 18:01:37 +0100
From: Petr Baudis <pasky@pasky.ji.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jakob ?stergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org,
        Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011106180137.C11619@pasky.ji.cz>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Jakob ?stergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org,
	Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <20011106092133.X11619@pasky.ji.cz> <Pine.GSO.4.21.0111060326100.27713-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0111060326100.27713-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > As far as I can see, I cannot read /proc/[pid]/* info using sysctl.
> > That can be added. We just have existing interface, and I don't propose to
> > stick on its actual state as it isn't convenient, but to extend it to cope
> > our needs.
> No, that cannot.  Guys, you've been told: it won't happen.  I think that was
> loud and clear enough.
So, if we want to be clear, we should freeze sysctl interface and focus to
/proc/? And sysctl is expected to disappear from the kernel by the time? If
not, I admit that I wasn't very much sure if exactly [pid] should go there.  If
answer is not, fine, as specially /proc/[pid]/ should be parsed with no
problems with scanf() (expect "(procname)" in /proc/[pid]/stat ;), as a
difference to some nightmares in device specific proc files etc. _Those_ are
which I propose to mirror in sysctl tree. You still can put nice progress bars
here to help humans (which is great), and you won't make programmers run around
crying something about linux [developers] stupidity. And I don't see any
disadvantage in this - /proc/ should remain supported forever and nothing stops
you using it, and you won't fill it with .bloat files.. (and that actually was
what Linus told he won't accept, iirc)

> Can it.  Get a dictionary and look up the meaning of "veto".
Well, 'veto' was for binary **** in /proc/. This is something completely
different. And actually done ;).

-- 

				Petr "Pasky" Baudis

UN*X programmer, UN*X administrator, hobbies = IPv6, IRC
Real Users hate Real Programmers.
Public PGP key, geekcode and stuff: http://pasky.ji.cz/~pasky/
