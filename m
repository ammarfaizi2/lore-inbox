Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUHGMi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUHGMi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 08:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUHGMi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 08:38:27 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:40330 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S261602AbUHGMiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 08:38:24 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sat, 7 Aug 2004 08:38:22 -0400
User-Agent: KMail/1.6.82
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Shoemaker <c.shoemaker@cox.net>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       vda@port.imtp.ilyichevsk.odessa.ua, ak@suse.de,
       William Lee Irwin III <wli@holomorphy.com>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040806230924.GA15493@cox.net> <Pine.LNX.4.58.0408062304580.24588@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408062304580.24588@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408070838.22838.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [141.153.89.40] at Sat, 7 Aug 2004 07:38:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 August 2004 02:20, Linus Torvalds wrote:
>On Fri, 6 Aug 2004, Chris Shoemaker wrote:
>> I _was_ able to find the attached oops, but I don't think I have
>> the corresponding object files, so I hope the decoding it contains
>> is good enough.
>
>It's fine.
>
>It oopses on
>
>	inode->i_sb->s_op
>
>where "i_sb" is bad and contains the pointer "0x0b7eebf8" which is
>definitely not a valid kernel pointer.
>
>There's a few other strange details in your oops report too. One
> being that the inode pointer (in %ebx, apparently) doesn't show on
> the stack where I'd expect it to show. Hmm. That might be just a
> different compiler issue, though.
>
>Anyway, this does look somewhat like the ones Gene is seeing. If I
> had to guess, I'd guess that either the inode pointer is bad, or
> it's just stale from an inode that has already been free'd. Most
> likely because of prune_dcache() having had a corrupt LRU list with
> a stale/corrupt entry.
>
>That would blow the prefetch theory out of the water.
>
>		Linus

And I'm still up, no Oops yet.

08:34:07 up 1 day, 21:25,  4 users,  load average: 1.10, 1.08, 1.03

I've also only done 3 seti units since yesterday morning, about 40% to 
50%  of my usual production even with the crashes.  In other words, 
system seems stable, but old dog slow too.  & thats with top showing 
seti getting 97-99% of the cpu.  Ouch!

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
