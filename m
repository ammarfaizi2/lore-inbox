Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280855AbRKBWXv>; Fri, 2 Nov 2001 17:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280856AbRKBWXm>; Fri, 2 Nov 2001 17:23:42 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:63411 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S280855AbRKBWXa>; Fri, 2 Nov 2001 17:23:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Sven Heinicke <sven@research.nj.nec.com>, linux-kernel@vger.kernel.org
Subject: Re: Google's mm problems with 2.4.13 and 4G of memory
Date: Fri, 2 Nov 2001 23:24:37 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin> <15329.43498.436892.985755@abasin.nj.nec.com>
In-Reply-To: <15329.43498.436892.985755@abasin.nj.nec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011102222328Z16846-4784+475@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 1, 2001 09:00 pm, Sven Heinicke wrote:
> I got a Dell powerEdge something with 4G of memory locking up pritty
> hard when Danial Phillips test program hits chunk 9:
> 
> mlocking at 401bf000 of size 1048576
> mlock took 12.181794 seconds
> munlock'ed 5999e000
> munmap'ed 5999e000
> Loading data at 5999e000 for slot 1
> Load (/mnt/sdb/sven/chunk9) succeeded!
> mlocking slot 1, 5999e000
> mlocking at 5999e000 of size 1048576
> 
> 
> And nothing.  It's a vanilla 2.4.13 kernel and Mandrake 8.0.
> 
> If I run the program up to like chunk 3 and send an interrupt it
> doesn't free up the memory unless I umount the file system.

Not freeing up the memory until umount is not a bug, it's normal.  The 
(cache) memory is supposed to be freed up when it's needed for something more 
important.

The discussion right now is about whether the mm is supposed to be able to 
handle more than 50% mlocked memory or whether that's a user bug.

(I think we should be able to mlock >90% of memory, but there isn't general 
agreement on this.  The question is not whether it's possible, but whether 
there's a real need for applications to be able to do this.)

> Please suggest idea on how to fix it.  I have this system to abuse for
> several days.

Please stay tuned.

--
Daniel
