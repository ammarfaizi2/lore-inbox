Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWFIU1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWFIU1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWFIU1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:27:32 -0400
Received: from relay01.pair.com ([209.68.5.15]:4616 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1751385AbWFIU1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:27:31 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 9 Jun 2006 15:27:29 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com, torvalds@osdl.org,
       alex@clusterfs.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <4489C8FA.4070403@garzik.org>
Message-ID: <Pine.LNX.4.64.0606091520190.5541@turbotaz.ourhouse>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
 <20060609181020.GB5964@schatzie.adilger.int> <4489C0B8.7050400@garzik.org>
 <20060609115936.2fdda6d0.akpm@osdl.org> <4489C8FA.4070403@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Jeff Garzik wrote:

> I disagree with the "years to stabilize ext4" argument, because we are 
> starting from a known good point.  I think ext4 will be easier to maintain 
> and tune for modern storage systems, if we don't have to worry as much about 
> that stuff for ext3.

Let's say we

# cp ext3 ext4
# cat extents 48bit | patch

and then roll it out in 2.6.18. That in and of itself is probably fine and 
stable (though it's no different than ext3 except for the name and the two 
new additions).

But are you going to do this again for ext5 when more features come along? 
Or are you going to warn ext4 users that the FS is not expected to be stable?

If you do the latter, be prepared for people to be wary of using it for a 
long while. The difference is between actual and perceived stability.

To put a finer point on it - I've got a system that's been running 
flawlessly for years on 2.5.3. It's actually been stable - never had any 
sort of crashing problem at all. But I'm essentially crazy for running 
that kernel. At the time I installed it, it certainly wasn't perceived as 
stable. If the computer in question were any more than a file server / 
iptables box for my home, I'd have said "well, hell, I think I'm going to 
have to do without 2.5 so that I can have something trustworthy."

(Amusingly enough, I started assembling a replacement for it recently, 
if only to have something newer and more capable. Having gone from 
Slackware to Gentoo I decided to give the April stable 
Debian release a whirl. Imagine my shock and awe when I watched Debian 
boot into a 2.4 kernel :P)

> 	Jeff
>

Cheers,
Chase
