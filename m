Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264970AbRFUOAU>; Thu, 21 Jun 2001 10:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbRFUOAK>; Thu, 21 Jun 2001 10:00:10 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:1540 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S264970AbRFUOAA>; Thu, 21 Jun 2001 10:00:00 -0400
Date: Thu, 21 Jun 2001 09:59:18 -0400
From: Chris Mason <mason@suse.com>
To: Christian Robottom Reis <kiko@async.com.br>, NFS@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] NFS insanity 
Message-ID: <424880000.993131958@tiny>
In-Reply-To: <Pine.LNX.4.32.0106202015380.2976-100000@blackjesus.async.com.br>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, June 20, 2001 08:23:06 PM -0300 Christian Robottom Reis
<kiko@async.com.br> wrote:

> 
> I've got an NFS server, version 2.4.4, using reiserfs with trond's NFS
> patches and the reiser-2.4.4 nfs patch.
> 
> On a client running 2.4.5 with trond's patches and the corresponding
> reiser patches, I get the wierdest behaviour:
> 
> # on client
> cp libgkcontent.so libgkcontent.so.x
> diff libgkcontent.so libgkcontent.so.x
> # no diff
> 
> # on server
> diff libgkcontent.so libgkcontent.so.x
> Binary files libgkcontent.so and libgkcontent.so.x differ
> 
> It _only_ happens in this file of all files I've tried out so far. I'm
> trying to get xdelta to show me what's differing so I can see if there's a
> pattern or something, but it's awful - data corruption not only possibly
> but happening. :-)
> 
> I haven't tried remounting yet to see what I get, but I don't see the
> problems on unpatched 2.4.2. I'll wait a bit to see if anyone has seen
> this. Anyone?

Sounds like some of the problems fixed in 2.4.5 and 2.4.6pre kernels, where
NFS data didn't get flushed right away, but I thought that only involved
mmap'd files.

-chris



