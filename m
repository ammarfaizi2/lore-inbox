Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBDRTj>; Sun, 4 Feb 2001 12:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129090AbRBDRT3>; Sun, 4 Feb 2001 12:19:29 -0500
Received: from [206.191.149.217] ([206.191.149.217]:15599 "EHLO
	ursa.seattlefirewall.dyndns.org") by vger.kernel.org with ESMTP
	id <S129031AbRBDRTP>; Sun, 4 Feb 2001 12:19:15 -0500
Date: Sun, 4 Feb 2001 09:18:43 -0800 (PST)
From: Tom Eastep <teastep@seattlefirewall.dyndns.org>
To: "Michael B. Trausch" <fd0man@crosswinds.net>
cc: Josh Myer <jbm@joshisanerd.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <Pine.LNX.4.21.0102040756120.5276-100000@fd0man.accesstoledo.com>
Message-ID: <Pine.LNX.4.30.0102040908320.877-100000@wookie.seattlefirewall.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spoke Michael B. Trausch:

> On Sat, 3 Feb 2001, Josh Myer wrote:
>
> > Hello all,
> >
> > I know this _really_ isn't the forum for this, but a friend of mine has
> > noticed major, persistent clock drift over time. After several weeks, the
> > clock is several minutes slow (always slow). Any thoughts on the
> > cause? (Google didn't show up anything worthwhile in the first couple of
> > pages, so i gave up).
> >
>
> I'm having the same problem here.  AMD K6-II, 450 MHz, VIA Chipset, Kernel
> 2.4.1.
>

I've discovered that heavy use of vesafb can be a major source of clock
drift on my system, especially if I don't specify "ypan" or "ywrap". On my
system (similar Hw/Sw configuration to yours), a 2.4 kernel "make dep"
from a vesafb console will cause the system clock to drift 10-12 seconds.
With "ywrap", I can do an entire kernel build and only loose 5 seconds or
so. Even with "ywrap", the drift causes ntpd to loose synchronization. If
I build the kernel from an xterm window, ntpd does not loose sync and
there is no apparent clock drift.

The video on this system is an onboard ATI 3D Rage LT Pro; I use vesafb
rather than atyfb because the latter screws up X.

-Tom
-- 
Tom Eastep             \ Alt Email: tom@seattlefirewall.dyndns.org
ICQ #60745924           \ Websites: http://seawall.sourceforge.net
teastep@evergo.net       \          http://seattlefirewall.dyndns.org
Shoreline, Washington USA \___________________________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
