Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSHKJaW>; Sun, 11 Aug 2002 05:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSHKJaW>; Sun, 11 Aug 2002 05:30:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21513 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313190AbSHKJaV>;
	Sun, 11 Aug 2002 05:30:21 -0400
Message-ID: <3D5631E0.200E37D4@zip.com.au>
Date: Sun, 11 Aug 2002 02:44:00 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Tom Vier <tmv@comcast.net>,
       JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Testing of filesystems
References: <20020730094902.GA257@prester.freenet.de> <20020811025018.GE17886@zero> <3D562498.9020901@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> 
> Tom Vier wrote:
> 
> >On Tue, Jul 30, 2002 at 11:49:02AM +0200, Axel Siebenwirth wrote:
> >
> >
> >>I wonder what a good way is to stress test my JFS filesystem. Is there a tool
> >>
> >>
> ><snip>
> >
> >fsx.c came up a while ago on l-k. it's an old (but still very useful) fs
> >stressor(sp) from neXT. i have a copy davej modded for linux. if you can't
> >find it, i can send it to you. i haven't been brave enough to run it myself,
> >on my alpha's reiserfs. 8) it found some hard to find bugs in ext2 that were
> >lurking for years (iirc).
> >
> >
> >
> It found bugs in reiserfs and we fixed them.:)

fsx-linux is great.  Caused me no end of grief in 2.5.13.  Running
it on small blocksize fs alongside really heavy memory pressure 
touches all sorts of corner cases.

I have a version which is tricked up to understand O_DIRECT
in http://www.zip.com.au/~akpm/linux/ext3-tools.tar.gz
