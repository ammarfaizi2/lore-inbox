Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287750AbSAGHQI>; Mon, 7 Jan 2002 02:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSAGHPs>; Mon, 7 Jan 2002 02:15:48 -0500
Received: from ns2.auctionwatch.com ([64.14.24.2]:64010 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S287750AbSAGHPq>; Mon, 7 Jan 2002 02:15:46 -0500
Date: Sun, 6 Jan 2002 23:15:31 -0800
From: Petro <petro@auctionwatch.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: andihartmann@freenet.de, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020107071531.GC20760@auctionwatch.com>
In-Reply-To: <200201040019.BAA30736@webserver.ithnet.com> <3C360D6E.9020207@athlon.maya.org> <20020105092442.GC26154@auctionwatch.com> <20020105164405.5d9f5232.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020105164405.5d9f5232.skraw@ithnet.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2002 at 04:44:05PM +0100, Stephan von Krawczynski wrote:
> On Sat, 5 Jan 2002 01:24:42 -0800
> Petro <petro@auctionwatch.com> wrote:
> 
> > "We" (Auctionwatch.com) are experiencing problems that appear to be
> > related to VM, I realize that this question was not directed at me:
> 
> And how exactly do the problems look like?

    After some time, ranging from 1 to 48 hours, mysql quits in an
    unclean fashion (dies leaving tables improperly closed) with a dump
    in the mysql log file that looks like: 

> Here is the stack dump:
> 0x807b75f handle_segfault__Fi + 383
> 0x812bcaa pthread_sighandler + 154
> 0x815059c chunk_free + 596
> 0x8152573 free + 155
> 0x811579c my_no_flags_free + 16
> 0x80764d5 _._5ilink + 61
> 0x807b48d end_thread__FP3THDb + 53
> 0x80809cc handle_one_connection__FPv + 996

    Which the Mysql support team says appears to be memory corruption.
    Since this has happened on 4 different machines, and one of them had
    memtest86 run on it (coming up clean), they seem (witness Sasha's
    post) to think this may have something to do with the memory
    handling in the kernel. 

    I haven't run it on a kernel that has debugging enabled yet,
    partially because I've been tracing a completely unrelated problems
    with our hard drives (IBM GXP 75G drives made in Hungary during the
    first 3 months of 2001), and partially because the only way to get
    this to happen is to put the database in production, which results
    in a crash, which takes our site offline, which costs us money and
    pisses off our users. Right now we're running on a sun e4500, and
    it's stable, so until we get the other problem worked out, we're
    waiting to see on this one. 


-- 
Share and Enjoy. 
