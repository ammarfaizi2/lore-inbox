Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbTCOJMt>; Sat, 15 Mar 2003 04:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261367AbTCOJMs>; Sat, 15 Mar 2003 04:12:48 -0500
Received: from holomorphy.com ([66.224.33.161]:8145 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261362AbTCOJMo>;
	Sat, 15 Mar 2003 04:12:44 -0500
Date: Sat, 15 Mar 2003 01:23:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: Andrew Morton <akpm@digeo.com>, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030315092311.GS20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alex Tomas <bzzz@tmi.comex.ru>, Andrew Morton <akpm@digeo.com>,
	adilger@clusterfs.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <20030313165641.H12806@schatzie.adilger.int> <m38yvixvlz.fsf@lexa.home.net> <20030315043744.GM1399@holomorphy.com> <20030314205455.49f834c2.akpm@digeo.com> <20030315054910.GN20188@holomorphy.com> <20030315062025.GP20188@holomorphy.com> <20030314224413.6a1fc39c.akpm@digeo.com> <m3r899yrhx.fsf@lexa.home.net> <20030315082927.GR20188@holomorphy.com> <m3wuj1xc6b.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wuj1xc6b.fsf@lexa.home.net>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> William Lee Irwin (WLI) writes:
>> I simple use own pretty simple test. btw, you may disable
>> preallocation to increase allocation rate

WLI> This looks very interesting, but it may have to wait ca. 24
WLI> hours for some benchmark time b/c of the long boot times and
WLI> late hour in .us.
WLI> This also looks like it would be a much better stress test, and
WLI> the NUMA-Q is known for bringing out many rare races. There is
WLI> are good reasons to run this test even aside from performance.

On Sat, Mar 15, 2003 at 11:32:28AM +0300, Alex Tomas wrote:
> fine. it's really interesting to see results for so big iron.
"
So maybe it's pointless to elaborate on this in particular, but...

I actually borrowed time on the extra quads (I have 4 that are primarily
used by me; these systems support static partitioning, so as long as the
cabling is done right, you can make 4 4 quad systems from 16 quads, or
2 8 quad systems from 16 quads, or 1 16 quad system from 16 quads, etc.;
the other 4 are actually primarily used by Dave Hansen, but he's been
tied up with tasks that need him to use other systems this week and so
lent them to me) for the purpose of hardening pgcl (my forward port of
Hugh Dickins' page clustering patch), but when the issue of lock
contention came up, I thought it would be a good idea to utilize the
elevated cpu count to highlight the lock contention you were trying to
address with this patch. I'd be more than happy to see an effective
case for it made or otherwise demonstrate its merits.

I guess it's mostly OT and/or organizational, but it might (for those
who are interested) give an idea of how the time on these larger
systems is spent. In this case, the larger system is dynamically put
together from two smaller systems when another kernel hacker isn't
focusing on that system and nicely cooperates to give other people time
to test/benchmark/etc. on the hardware that can be glued together with
stuff regularly used by some other kernel hacker to form a larger system.
To some it might sound inconvenient, but I'm grateful for every minute
of time I get on the things.

There are other situations or "typical patterns" for getting at the
larger systems. What's probably the most typical pattern of all is that
the vendors themselves can't afford the larger models of their own
machines for kernel hacking purposes, and so the hackers (and their
managers and other kinds of helpers) scramble to beg, borrow, and steal
time on such machines from whatever places they can.

I have no idea what possessed me to describe all this, but I'll go on.
And sorry that this is probably very irrelevant to you Alex, but:

To all those who help get me in front of these, things, i.e. Dave, Hans,
Martin, Gerrit, Hubertus, et al, thanks a million! I love hacking on
big boxen, and (at least from the above) it's clear I can't do it alone.


-- wli
