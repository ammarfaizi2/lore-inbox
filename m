Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWFITAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWFITAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWFITAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:00:20 -0400
Received: from relay03.pair.com ([209.68.5.17]:16395 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1030209AbWFITAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:00:17 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 9 Jun 2006 14:00:15 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Chase Venters <chase.venters@clientec.com>
cc: Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
Message-ID: <Pine.LNX.4.64.0606091356340.5541@turbotaz.ourhouse>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
 <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
 <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Chase Venters wrote:

> On Fri, 9 Jun 2006, Linus Torvalds wrote:
>
>> 
>>
>>  On Fri, 9 Jun 2006, Alex Tomas wrote:
>> > 
>> >  would "#if CONFIG_EXT3_EXTENTS" be a good solution then?
>>
>>  Let's put it this way:
>>  - have you had _any_ valid argument at all against "ext4"?
>>
>>  Think about it. Honestly. Tell me anything that doesn't work?
>
> Now, granted, I really do agree with you about the whole code sharing thing. 
> A fresh start is often just what you need. I'm just questioning if it 
> wouldn't be better to do this fresh start immediately after going 48-bit, 
> rather than before. That way, existing users that want that extra umph can 
> have it today.
>

Let me clarify that I don't have a final answer or opinion for whether or 
not 48-bit belongs in ext3 or ext4. But I'm trying to illustrate that it's an 
important question to raise.

In Group A we have some number of users that must have 48-bit support by 
Date B. 48-bit support could be available in ext3 by Date A, before Date 
B. It could also be available in ext4 by Date X, along with a handful of 
other features.

Is Date X before Date B? If it's not, is it worth telling Group A to 
suffer for a while, or asking them to use ext4 before it's ready? These 
are the questions I'd have to know the answers to if I were the one 
casting a final decision.
