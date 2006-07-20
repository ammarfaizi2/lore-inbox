Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWGTWng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWGTWng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 18:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWGTWng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 18:43:36 -0400
Received: from lucidpixels.com ([66.45.37.187]:58828 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030391AbWGTWnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 18:43:35 -0400
Date: Thu, 20 Jul 2006 18:43:34 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Nathan Scott <nathans@sgi.com>
cc: Chris Wedgwood <cw@f00f.org>, David Greaves <david@dgreaves.com>,
       Kasper Sandberg <lkml@metanurb.dk>,
       Torsten Landschoff <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com, ml@magog.se, radsaq@gmail.com
Subject: Re: FAQ updated (was Re: XFS breakage...)
In-Reply-To: <20060721082448.C1990742@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0607201843020.2619@p34.internal.lan>
References: <20060718222941.GA3801@stargate.galaxy>
 <20060719085731.C1935136@wobbly.melbourne.sgi.com> <1153304468.3706.4.camel@localhost>
 <20060720171310.B1970528@wobbly.melbourne.sgi.com> <44BF8500.1010708@dgreaves.com>
 <20060720161121.GA26748@tuatara.stupidest.org> <20060721081452.B1990742@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.64.0607201817450.23697@p34.internal.lan>
 <20060721082448.C1990742@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Jul 2006, Nathan Scott wrote:

> On Thu, Jul 20, 2006 at 06:18:14PM -0400, Justin Piszcz wrote:
>> Nathan,
>>
>> Does the bug only occur during a crash?
>
> No, its unrelated to crashing.  Only when adding/removing from a
> directory that is in a specific node/btree format (many entries),
> and only under a specific set of conditions (like what directory
> entry names were used, which blocks they've hashed to and how they
> ended up being allocated and in what order each block gets removed
> from the directory).
>
>> I have been running 2.6.17.x for awhile now (multiple XFS filesystems, all
>> on UPS) - no issue?
>
> Could be an issue, could be none.  xfs_check it to be sure.
>
> cheers.
>
> -- 
> Nathan
>
>

p34:~# xfs_check -v /dev/md3
xfs_check: out of memory
p34:~#

D'oh...

1GB ram, 2GB swap trying to check a 2.6T fs, no dice.

As long as it mounted ok with the patched kernel, should one be ok?
