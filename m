Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290229AbSAOSP3>; Tue, 15 Jan 2002 13:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290232AbSAOSPS>; Tue, 15 Jan 2002 13:15:18 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:41488 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S290229AbSAOSPK>; Tue, 15 Jan 2002 13:15:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: [BUG] symlink problem with knfsd and reiserfs
Date: Tue, 15 Jan 2002 19:14:19 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>,
        "David L. Parsley" <parsley@roanoke.edu>
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de> <20020115163208.785831435@shrek.lisa.de> <15428.27801.724105.557093@laputa.namesys.com>
In-Reply-To: <15428.27801.724105.557093@laputa.namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020115181430.78CE11435@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 15. January 2002 18:53, Nikita Danilov wrote:
> Hans-Peter Jansen writes:
>  > On Tuesday, 15. January 2002 17:47, Nikita Danilov wrote:
>
> 3.6. is advantageous because of many other things, like LFS, etc.
>
>  > How big is the chance to loose data with -o conv?
>
> There were problems with -o conv and remount (for root file system), but
> they were cured in latest Marcelo's kernels.
>
>  > Is there any paper around, which describes this conversion
>  > a bit more detailed? If I understand you correctly, the inode
>  > generation counter doesn't work at all with 3.5?
>
> After file system is mounted with -o conv, all new files will be created
> in a new format. This file system will then no longer be mountable as
> 3.5 (and thus, inaccessible from 2.2 kernels).
>
> New files will store generation counters. The possibility of a stale
> handle lurking undetected is when old-format file was deleted, its
> objectid was reused for new format file, and super-block generation
> counter at that time happens to coincide with objectid of parent
> directory of the old file. Not exactly likely thing to happen, but
> still.

I will meditate over the last paragraph later. I decided to follow your 
first advice...

I think, this is worth a note in the reiserfs-FAQ. And remember: allmost
all linux distributions will use 3.5 to ensure backward compatibility.

Also note, that web man page and mkreiserfs -h disagree on the -v option.
I will believe mkreiserfs.

If I use notail mount option on a already populated partition, what happens
to the "tailed" files? I expect, only newly created ones get there own block.

>
> Nikita.
>
Cheers,
  Hans-Peter
