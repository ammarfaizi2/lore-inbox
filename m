Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLOF3G>; Fri, 15 Dec 2000 00:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbQLOF25>; Fri, 15 Dec 2000 00:28:57 -0500
Received: from waste.org ([209.173.204.2]:23651 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129267AbQLOF2p>;
	Fri, 15 Dec 2000 00:28:45 -0500
Date: Thu, 14 Dec 2000 22:58:05 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Stephen Frost <sfrost@snowman.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Netfilter <netfilter@us5.samba.org>
Subject: Re: test13-pre1 changelog
In-Reply-To: <Pine.LNX.4.10.10012141552180.12695-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0012142244200.27741-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2000, Linus Torvalds wrote:

> On Thu, 14 Dec 2000, Stephen Frost wrote:
> >
> > 	Any idea if these issues would cause a general slow-down of a
> > machine?  For no apparent reason after 5 days running 2.4.0test12
> > everything going through my firewall (set up using iptables) I got about
> > 100ms time added on to pings and traceroutes.
>
> Probably not related to that particular bug - the netfilter issue has
> apparently been around forever, and it was just some changes in IP
> fragmentation that just made it show up as an oops.
>
> A 100ms delay sounds like some interrupt shut up or similar (and then
> timer handling makes it limp along).

Possibly related datapoint: after several days of uptime, my
2.4.0-test10pre? machine went into some sort of slow mode after coming
back from suspend (and doing an /etc/init.d/networking restart). Symptoms
seemed to be extra second or so setting up a TCP connection. Ping, etc.,
appeared to work just fine, no packet loss apparent, bandwidth looked good
too. Sadly I had to do actual work that required zippy web access, so I
rebooted rather than doing a thorough diagnostic. This is a VAIO with
compiled in eepro100, no special networking options.

Oh, and btw, test12-pre7 seems to have broken my USB camera, which worked
with the aforementioned kernel. My build of gphoto2 downloads images via
usbdevfs (ugh) and quietly created a bunch of .jpgs that were almost
entirely 0s..

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
