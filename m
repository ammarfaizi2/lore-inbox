Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWHAF71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWHAF71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 01:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWHAF71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 01:59:27 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:13485 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1161088AbWHAF70
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 01:59:26 -0400
Message-ID: <44CEEDBA.6040403@slaphack.com>
Date: Tue, 01 Aug 2006 00:59:22 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of   view"expressedby
 kernelnewbies.org regarding reiser4 inclusion]
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>   <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>   <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>   <44CE7C31.5090402@gmx.de>   <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com>   <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz>   <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com>   <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz>   <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com>   <20060801010215.GA24946@merlin.emma.line.org>  <44CEAEF4.9070100@slaphack.com>  <Pine.LNX.4.63.0607312114500.15179@qynat.qvtvafvgr.pbz> <44CED95C.10709@slaphack.com> <Pine.LNX.4.63.0607312142020.15179@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0607312142020.15179@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Mon, 31 Jul 2006, David Masover wrote:

>> Aha, so back to the usual argument:  UPS!  It takes a fraction of a 
>> second to flush that cache.
> 
> which does absolutly no good if someone trips over the power cord, the 
> fuse blows in the power supply, someone yanks the drive out of the 
> hot-swap bay, etc.

Power supply fuse...  Yeah, it happens.  Drives die, too.  This seems 
fairly uncommon.  And dear God, please tell me anyone smart enough to 
set up a UPS would also be smart enough to make tripping over the power 
cord rare or impossible.

My box has a cable that runs down behind a desk, between the desk and 
the wall.  Power strip is on the floor, where a UPS will be when I get 
around to buying one.  If someone kicks any cable, it would be where the 
UPS hits the wall -- but that's also behind the same desk.


> as I understand it flash reads are fast (ram speeds), but writes are 
> pretty slow (comparable or worse to spinning media)
> 
> writing to a ram cache, but having a flash drive behind it doesn't gain 
> you any protection. and I don't think you need it for reads

Does gain you protection if you're not using the RAM cache, if you're 
that paranoid.  I don't know if it's cheaper than RAM, but more read 
cache is always better.  And losing power seems a lot less likely than 
crashing, especially on a Windows laptop, so it does make sense as a 
product.  And a laptop, having a battery, will give you a good bit of 
warning before it dies.  My Powerbook syncs and goes into Sleep mode 
when it runs low on power (~1%/5mins)

>>> external battery backed cache is readily available, either on 
>>> high-end raid controllers or as seperate ram drives (and in raid 
>>> array boxes), but nothing on individual drives.
>>
>> Ah.  Curses.
>>
>> UPS, then.  If you have enough time, you could even do a Software 
>> Suspend first -- that way, when power comes back on, you boot back up, 
>> and if it's done quickly enough, connections won't even be dropped...
> 
> remember, it can take 90W of power to run your CPU, 100+ to run your 
> video card, plus everything else. even a few seconds of power for this 
> is a very significant amount of energy storage.

Suspend2 can take about 10-20 seconds.  It should be possible to work 
out the maximum amount of time it can take.

Anyway, according to a quick Google search, my CPU is more like 70W. 
Video card isn't required on a server, but you may be right on mine.  I 
haven't looked at UPSes lately, though.  I need about 3 seconds for a 
sync, maybe 10 for a suspend, so to be safe I can say for sure I'd be 
down in about 30 seconds.

So, another Google search, and while you can get a cheap UPS for 
anywhere from $10 to $100, the sweet spot seems to be a little over $200.

$229, and it's 865W, supposedly for 3.7 minutes.  Here's a review:

"This is a great product. It powers an AMD 64 3200+ with beefy (6800GT) 
graphics card, 21" CRT monitor, secondary 19" CRT, a linux server, a 15" 
CRT, Cisco 2800XL switch, Linksys WRTG54GS, cable modem, speakers, and 
many other things. The software says I will get 9 minutes runtime with 
all of that hooked up, realistically it's about 4 minutes."

This was the lowest time reported.  Most of the other reviews say at 
least 15 minutes, sometimes 30 minutes, with fairly high-end computers 
listed (and monitors, sometimes two computers/monitors), but nowhere 
near as much stuff as this guy has.

I checked most of these for Linux support, and UPSes in general seem 
well supported.  So yes, the box will shut off automatically.  On a 
network, it shouldn't be too hard to get one box to shut off all the rest.

It's a lot of money, even at the low end, but when you're already 
spending a pile of money on a new computer, keep power in mind.  And 
really, even 11 minutes would be fine, but 40 minutes of power is quite 
a lot compared to less than a minute of time taken to shut down normally 
-- not even suspend, but a normal shut down.  I'd be tempted to try to 
ride it out for the first 20 minutes, see if power comes back up...

> however, I did get a pointer recently at a company makeing super-high 
> capcity caps, up to 2600F (F, not uF!) in a 138mmx tall 57mm dia 
> cyliner, however it only handles 2.7v (they have modules that handle 
> higher voltages available)
> http://www.maxwell.com/ultracapacitors/index.html
> 
> however I don't see these as being standard equipment in systems or on 
> drives anytime soon

This seems to be a whole different approach -- more along the lines of 
in the drive, which would be cool...
