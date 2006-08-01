Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbWHAE4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbWHAE4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbWHAE4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:56:30 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:33492 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1160998AbWHAE43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:56:29 -0400
Date: Mon, 31 Jul 2006 21:53:55 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: David Masover <ninja@slaphack.com>
cc: Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of  
 view"expressedby kernelnewbies.org regarding reiser4 inclusion]
In-Reply-To: <44CED95C.10709@slaphack.com>
Message-ID: <Pine.LNX.4.63.0607312142020.15179@qynat.qvtvafvgr.pbz>
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>  
 <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>  
 <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>   <44CE7C31.5090402@gmx.de>
   <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com>  
 <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz>  
 <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com>  
 <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz>  
 <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com>  
 <20060801010215.GA24946@merlin.emma.line.org>  <44CEAEF4.9070100@slaphack.com>
  <Pine.LNX.4.63.0607312114500.15179@qynat.qvtvafvgr.pbz> <44CED95C.10709@slaphack.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006, David Masover wrote:

> David Lang wrote:
>> On Mon, 31 Jul 2006, David Masover wrote:
>> 
>>> Oh, I'm curious -- do hard drives ever carry enough battery/capacitance to 
>>> cover their caches?  It doesn't seem like it would be that hard/expensive, 
>>> and if it is done that way, then I think it's valid to leave them on.  You 
>>> could just say that other filesystems aren't taking as much advantage of 
>>> newer drive features as Reiser :P
>> 
>> there are no drives that have the ability to flush their cache after they 
>> loose power.
>
> Aha, so back to the usual argument:  UPS!  It takes a fraction of a second to 
> flush that cache.

which does absolutly no good if someone trips over the power cord, the fuse 
blows in the power supply, someone yanks the drive out of the hot-swap bay, etc.

>> now, that being said, /. had a story within the last couple of days about 
>> hard drive manufacturers adding flash to their hard drives. they may be 
>> aiming to add some non-volitile cache capability to their drives, although 
>> I didn't think that flash writes were that fast (needed if you dump the 
>> cache to flash when you loose power), or that easy on power (given that you 
>> would first loose power), and flash has limited write cycles (needed if you 
>> always use the cache).
>
> But, the point of flash was not to replace the RAM cache, but to be another 
> level.  That is, you have your Flash which may be as fast as the disk, maybe 
> faster, maybe less, and you have maybe a gig worth of it. Even the bloatiest 
> of OSes aren't really all that big -- my OS X came installed, with all kinds 
> of apps I'll never use, in less than 10 gigs.
>
> And I think this story was awhile ago (a dupe?  Not surprising), and the 
> point of the Flash is that as long as your read/write cache doesn't run out, 
> and you're still in that 1 gig of Flash, you're a bit safer than the RAM 
> cache, and you can also leave the disk off, as in, spinned down.  Parked.

as I understand it flash reads are fast (ram speeds), but writes are pretty slow 
(comparable or worse to spinning media)

writing to a ram cache, but having a flash drive behind it doesn't gain you any 
protection. and I don't think you need it for reads


>> external battery backed cache is readily available, either on high-end raid 
>> controllers or as seperate ram drives (and in raid array boxes), but 
>> nothing on individual drives.
>
> Ah.  Curses.
>
> UPS, then.  If you have enough time, you could even do a Software Suspend 
> first -- that way, when power comes back on, you boot back up, and if it's 
> done quickly enough, connections won't even be dropped...

remember, it can take 90W of power to run your CPU, 100+ to run your video card, 
plus everything else. even a few seconds of power for this is a very significant 
amount of energy storage.

however, I did get a pointer recently at a company makeing super-high capcity 
caps, up to 2600F (F, not uF!) in a 138mmx tall 57mm dia cyliner, however it 
only handles 2.7v (they have modules that handle higher voltages available)
http://www.maxwell.com/ultracapacitors/index.html

however I don't see these as being standard equipment in systems or on drives 
anytime soon

David Lang
