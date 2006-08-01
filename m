Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWHAEYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWHAEYF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161001AbWHAEYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:24:04 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:9355 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1161000AbWHAEYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:24:03 -0400
Date: Mon, 31 Jul 2006 21:21:05 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: David Masover <ninja@slaphack.com>
cc: Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of 
 view"expressed by kernelnewbies.org regarding reiser4 inclusion]
In-Reply-To: <44CEAEF4.9070100@slaphack.com>
Message-ID: <Pine.LNX.4.63.0607312114500.15179@qynat.qvtvafvgr.pbz>
References: <20060731175958.1626513b.reiser4@blinkenlights.ch> 
 <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl> 
 <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>  <44CE7C31.5090402@gmx.de>
  <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com> 
 <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz> 
 <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com> 
 <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz> 
 <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com> 
 <20060801010215.GA24946@merlin.emma.line.org> <44CEAEF4.9070100@slaphack.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006, David Masover wrote:

> Oh, I'm curious -- do hard drives ever carry enough battery/capacitance to 
> cover their caches?  It doesn't seem like it would be that hard/expensive, 
> and if it is done that way, then I think it's valid to leave them on.  You 
> could just say that other filesystems aren't taking as much advantage of 
> newer drive features as Reiser :P

there are no drives that have the ability to flush their cache after they loose 
power.

now, that being said, /. had a story within the last couple of days about hard 
drive manufacturers adding flash to their hard drives. they may be aiming to add 
some non-volitile cache capability to their drives, although I didn't think that 
flash writes were that fast (needed if you dump the cache to flash when you 
loose power), or that easy on power (given that you would first loose power), 
and flash has limited write cycles (needed if you always use the cache).

I've heard to many fancy-sounding drive technologies that never hit the market, 
I'll wait until thye are actually available before I start counting on them for 
anything  (let alone design/run a filesystem that requires them :-)

external battery backed cache is readily available, either on high-end raid 
controllers or as seperate ram drives (and in raid array boxes), but nothing on 
individual drives.

David Lang
