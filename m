Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWHAEcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWHAEcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWHAEcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:32:33 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:41888 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1751222AbWHAEcc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:32:32 -0400
Message-ID: <44CED95C.10709@slaphack.com>
Date: Mon, 31 Jul 2006 23:32:28 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of  view"expressed
 by kernelnewbies.org regarding reiser4 inclusion]
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>  <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>  <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>  <44CE7C31.5090402@gmx.de>  <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com>  <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz>  <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com>  <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz>  <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com>  <20060801010215.GA24946@merlin.emma.line.org> <44CEAEF4.9070100@slaphack.com> <Pine.LNX.4.63.0607312114500.15179@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0607312114500.15179@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Mon, 31 Jul 2006, David Masover wrote:
> 
>> Oh, I'm curious -- do hard drives ever carry enough 
>> battery/capacitance to cover their caches?  It doesn't seem like it 
>> would be that hard/expensive, and if it is done that way, then I think 
>> it's valid to leave them on.  You could just say that other 
>> filesystems aren't taking as much advantage of newer drive features as 
>> Reiser :P
> 
> there are no drives that have the ability to flush their cache after 
> they loose power.

Aha, so back to the usual argument:  UPS!  It takes a fraction of a 
second to flush that cache.

> now, that being said, /. had a story within the last couple of days 
> about hard drive manufacturers adding flash to their hard drives. they 
> may be aiming to add some non-volitile cache capability to their drives, 
> although I didn't think that flash writes were that fast (needed if you 
> dump the cache to flash when you loose power), or that easy on power 
> (given that you would first loose power), and flash has limited write 
> cycles (needed if you always use the cache).

But, the point of flash was not to replace the RAM cache, but to be 
another level.  That is, you have your Flash which may be as fast as the 
disk, maybe faster, maybe less, and you have maybe a gig worth of it. 
Even the bloatiest of OSes aren't really all that big -- my OS X came 
installed, with all kinds of apps I'll never use, in less than 10 gigs.

And I think this story was awhile ago (a dupe?  Not surprising), and the 
point of the Flash is that as long as your read/write cache doesn't run 
out, and you're still in that 1 gig of Flash, you're a bit safer than 
the RAM cache, and you can also leave the disk off, as in, spinned down. 
  Parked.

Very useful for a laptop -- I used to do this in Linux by using Reiser4, 
setting the disk to spin down, and letting lazy writes do their thing, 
but I didn't have enough RAM, and there's always the possibility of 
losing data.  But leaving the disk off is nice, because in the event of 
sudden motion, it's safer that way.  Besides, most hardware gets 
designed for That Other OS, which doesn't support any kind of Laptop 
Mode, so it's nice to be able to enforce this at a hardware level, in a 
safe way.

> I've heard to many fancy-sounding drive technologies that never hit the 
> market, I'll wait until thye are actually available before I start 
> counting on them for anything  (let alone design/run a filesystem that 
> requires them :-)

Or even remember their names.

> external battery backed cache is readily available, either on high-end 
> raid controllers or as seperate ram drives (and in raid array boxes), 
> but nothing on individual drives.

Ah.  Curses.

UPS, then.  If you have enough time, you could even do a Software 
Suspend first -- that way, when power comes back on, you boot back up, 
and if it's done quickly enough, connections won't even be dropped...

