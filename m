Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131503AbRC0TeU>; Tue, 27 Mar 2001 14:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131507AbRC0TeB>; Tue, 27 Mar 2001 14:34:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:24455 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131503AbRC0Tdu>;
	Tue, 27 Mar 2001 14:33:50 -0500
Date: Tue, 27 Mar 2001 14:33:08 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: J Sloan <jjs@toyota.com>
cc: "Mohammad A. Haque" <mhaque@haque.net>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: "mount -o loop" lockup issue
In-Reply-To: <3AC0E14A.782A91C9@toyota.com>
Message-ID: <Pine.GSO.4.21.0103271404490.23356-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Mar 2001, J Sloan wrote:

> "Mohammad A. Haque" wrote:
> 
> > David Konerding wrote:
> >
> > > And this is described in what release notes?  It worked just fine on Red Hat 7.0's 2.4
> > > kernel.... oh wait, I see that they fixed it before they released it.
> >
> > And hmm..gee .. did they bother contributing back the code?
> 
> Based on their track record that's a silly question.

Especially since patches in question had been written by Jens Axboe (who
has nothing to RH) and announced (many times) on l-k.

I've fixed several races in Jens' patch and fed them back to him. His patch
+ these fixes were the only loop-related patches in RH tree[1]. Until fixes got
merged into Jens' loop-6 which, in turn, was merged into -ac and into
the main tree, that is.

I don't give a flying fsck through the rolling doughnut for "their" track
record (whatever "their" means), but I'm somewhat partial to mine. Care to
grep through l-k archives, check your facts and STFU?
								Al

[1] there's also changeloop patch - adds an ioctl for switching the underlying
file under opened /dev/loop; API is ugly and thing has so limited use that
IMO it should die. Completely unrelated to the problems in question, anyway.

