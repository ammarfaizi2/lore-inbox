Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLOPkE>; Fri, 15 Dec 2000 10:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbQLOPjq>; Fri, 15 Dec 2000 10:39:46 -0500
Received: from waste.org ([209.173.204.2]:24384 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129348AbQLOPjh>;
	Fri, 15 Dec 2000 10:39:37 -0500
Date: Fri, 15 Dec 2000 09:09:05 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Stephen Frost <sfrost@snowman.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Netfilter <netfilter@us5.samba.org>
Subject: Re: test13-pre1 changelog
In-Reply-To: <20001215093016.S26953@ns>
Message-ID: <Pine.LNX.4.30.0012150906270.18387-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2000, Stephen Frost wrote:

> * Oliver Xymoron (oxymoron@waste.org) wrote:
> > On Thu, 14 Dec 2000, Linus Torvalds wrote:
> >
> > > A 100ms delay sounds like some interrupt shut up or similar (and then
> > > timer handling makes it limp along).
> >
> > Possibly related datapoint: after several days of uptime, my
> > 2.4.0-test10pre? machine went into some sort of slow mode after coming
> > back from suspend (and doing an /etc/init.d/networking restart). Symptoms
> > seemed to be extra second or so setting up a TCP connection. Ping, etc.,
> > appeared to work just fine, no packet loss apparent, bandwidth looked good
> > too. Sadly I had to do actual work that required zippy web access, so I
> > rebooted rather than doing a thorough diagnostic. This is a VAIO with
> > compiled in eepro100, no special networking options.
>
> 	Actually, I figured out what it was and I feel kind of stupid, and
> suprised.  I knew I should have tried rebooting before complaining.  It
> turns out it actually was something in my firewall rules, it appears that
> for every logged packet there is something along the lines of a 100ms
> delay that gets added on.

Hmmm, that's seems rather extreme - does it have to wait for klogd to get
scheduled before it proceeds? I would expect the filtering to be down in
the noise except at fairly high loads.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
