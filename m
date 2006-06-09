Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWFIQZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWFIQZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWFIQZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:25:03 -0400
Received: from relay00.pair.com ([209.68.5.9]:30982 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S1030283AbWFIQZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:25:00 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 9 Jun 2006 11:24:58 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Jeff Garzik <jeff@garzik.org>
cc: Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <44899D93.5030008@garzik.org>
Message-ID: <Pine.LNX.4.64.0606091120580.4969@turbotaz.ourhouse>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
 <44899D93.5030008@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Jeff Garzik wrote:

> Alex Tomas wrote:
>> > > > > >  Linus Torvalds (LT) writes:
>>
>> 
>> LT>  Quite frankly, at this point, there's no way in hell I believe we can 
>> LT>  do major surgery on ext3. It's the main filesystem for a lot of users, 
>> LT>  and it's just not worth the instability worries unless it's something 
>> LT>  very obviously transparent.
>>
>>  I believe it's as stable as before until you mount with extents
>>  mount option.
>
> If it will remain a mount option, if it is never made the default (either in 
> kernel or distro level), then only 1% of users will ever use the feature. 
> And we shouldn't merge a 1% use feature into the _main_ filesystem for Linux.

Pardon me because I haven't made it all the way through this discussion 
yet, so I don't know if this has been suggested or dismissed. But I'm 
curious - rather than 'stealth upgrade' by way of mount options, why not 
just enable the functionality either via tune2fs or mkfs.ext3?

New distribution versions could ship installers that enable it, because users 
aren't really going to switch from a new distribution they just install to 
an older version (same story on the kernel).

Users that want the functionality today can have it by asking for it with 
tune2fs, they just have to bypass the warning that tells them they're not 
going to be able to boot kernels before 2.6.xx

> 	Jeff

Cheers,
Chase
