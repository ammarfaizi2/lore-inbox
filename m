Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132074AbQK2UfJ>; Wed, 29 Nov 2000 15:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132077AbQK2Ue7>; Wed, 29 Nov 2000 15:34:59 -0500
Received: from rsn-rby-gw.hk-r.se ([194.47.128.222]:42411 "EHLO
        tux.rsn.hk-r.se") by vger.kernel.org with ESMTP id <S132074AbQK2Uex>;
        Wed, 29 Nov 2000 15:34:53 -0500
Date: Wed, 29 Nov 2000 21:03:32 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Adam <adam@eax.com>
cc: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: 'holey files' not holey enough.
In-Reply-To: <Pine.LNX.4.21.0011291554110.1152-100000@eax.student.umd.edu>
Message-ID: <Pine.LNX.4.21.0011292056090.23505-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Adam wrote:

> On Wed, 29 Nov 2000, Tigran Aivazian wrote:
> 
> > > 	[adam@pepsi /tmp]$  dd if=/dev/zero of=holed.file bs=1000 seek=5000 count=1000
> > > 	[adam@pepsi /tmp]$ ls -l holed.file 
> > > 	-rw-rw-r--    1 adam     adam      6000000 Nov 29 08:52 holed.file
> > > 	[adam@pepsi /tmp]$ du -sh holed.file 
> > > 	1.9M    holed.file
> > 
> > what filesystem type? on ext2 filesystem on 2.4.0-test12-pre3 I get
> > expected result:
> 
> More datapoints. I have asked around, and I have two users of
> 2.4.0-test10. One is getting expected 1mb, other is getting (just like me)
> 1.9mb.
> 
> So far I don't see pattern, here. It does not seems to depend on block
> size, nor packet writing patches.

I don't use ext2, I use reiserfs and it works fine here (test10)

tux:~$dd if=/dev/zero of=holed.file bs=1000 seek=5000 count=1000
1000+0 records in
1000+0 records out
tux:~$ls -l holed.file 
-rw-r--r--    1 gandalf  gandalf   6000000 Nov 29 20:55 holed.file
tux:~$du -sh holed.file 
980k    holed.file

tested on a router (with test10 and ext2 and reiserfs) and it works fine
on both filsystems

tested on another router with reiserfs and ext2 running test11
works fine there too on both filesystems

works fine on test8 with both ext2 and reiserfs

(1k blocksize on ext2 and 4k blocksize on reiserfs)

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
