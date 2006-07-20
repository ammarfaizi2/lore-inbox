Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbWGTWzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWGTWzw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 18:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWGTWzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 18:55:52 -0400
Received: from lucidpixels.com ([66.45.37.187]:16084 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030396AbWGTWzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 18:55:51 -0400
Date: Thu, 20 Jul 2006 18:55:51 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Nathan Scott <nathans@sgi.com>
cc: Chris Wedgwood <cw@f00f.org>, David Greaves <david@dgreaves.com>,
       Kasper Sandberg <lkml@metanurb.dk>,
       Torsten Landschoff <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com, ml@magog.se, radsaq@gmail.com
Subject: Re: FAQ updated (was Re: XFS breakage...)
In-Reply-To: <20060721085230.F1990742@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0607201855270.2652@p34.internal.lan>
References: <20060718222941.GA3801@stargate.galaxy>
 <20060719085731.C1935136@wobbly.melbourne.sgi.com> <1153304468.3706.4.camel@localhost>
 <20060720171310.B1970528@wobbly.melbourne.sgi.com> <44BF8500.1010708@dgreaves.com>
 <20060720161121.GA26748@tuatara.stupidest.org> <20060721081452.B1990742@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.64.0607201817450.23697@p34.internal.lan>
 <20060721082448.C1990742@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.64.0607201843020.2619@p34.internal.lan>
 <20060721085230.F1990742@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nasty!

         - agno = 37
No modify flag set, skipping phase 5
Phase 6 - check inode connectivity...
         - traversing filesystem starting at / ...
free block 16777216 for directory inode 2684356622 bad nused
free block 16777216 for directory inode 2147485710 bad nused
         - traversal finished ...
         - traversing all unattached subtrees ...
         - traversals finished ...
         - moving disconnected inodes to lost+found ...
Phase 7 - verify link counts...
No modify flag set, skipping filesystem flush and exiting.
p34:~#

I applied the "one line fix" - I should be ok now?



On Fri, 21 Jul 2006, Nathan Scott wrote:

> On Thu, Jul 20, 2006 at 06:43:34PM -0400, Justin Piszcz wrote:
>> p34:~# xfs_check -v /dev/md3
>> xfs_check: out of memory
>> p34:~#
>>
>> D'oh...
>
> xfs_repair -n is another option, it has a cheaper (memory wise,
> usually) checking algorithm.
>
>> As long as it mounted ok with the patched kernel, should one be ok?
>
> Not necessarily, no - mount will only read the root inode.
>
> cheers.
>
> -- 
> Nathan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
