Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130618AbRC0RvR>; Tue, 27 Mar 2001 12:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131151AbRC0RvI>; Tue, 27 Mar 2001 12:51:08 -0500
Received: from d83b5259.dsl.flashcom.net ([216.59.82.89]:11394 "EHLO
	home.lameter.com") by vger.kernel.org with ESMTP id <S130618AbRC0RvB>;
	Tue, 27 Mar 2001 12:51:01 -0500
Date: Tue, 27 Mar 2001 09:50:17 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS phenomenon with 2.4.2 ac24/ac12
In-Reply-To: <284560000.985712917@tiny>
Message-ID: <Pine.LNX.4.21.0103270948180.6964-100000@home.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Chris Mason wrote:
> On Tuesday, March 27, 2001 08:21:07 AM -0800 Christoph Lameter
> <christoph@lameter.com> wrote:
> 
> >  
> > <-------------debugreiserfs, 2000------------->
> > reiserfsprogs 3.x.0h
> > 9454 is free in true bitmap
> >  
> > ===================================================================
> > LEAF NODE (9454) contains level=1, nr_items=11, free_space=16 rdkey
> > -------------------------------------------------------------------------
> > ------ |  3|1928 5204 0x0 SD, len 44, entry count 65535, fsck need 0,
> > format new| (NEW SD), mode d---------, size 96, nlink 2, mtime 03/23/2001
> > 20:49:37
> > -------------------------------------------------------------------------
> > ------ |  4|1928 5204 0x1 DIR, len 184, entry count 5, fsck need 0,
> > format old| ###: Name                     length    Object key
> > Hash     Gen number
> >   0: ".                        "(  1)   1928           5204           0
> > 1, loc b0,  state 4 ()
> >   1: "..                       "(  2)      1              2           0
> > 2, loc a8,  state 4 ()
> >   2: "cache3A0F94EA0A00557.html"( 25)   5204           5334  1942043776
> > 0, loc 88,  state 4 ()
> >   3: "cache3A0F94EA0A00557.html"( -6) 263760           5334        5248
> > 86, loc 88,  state 4 (BROKEN)
> >   4: "cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb"( 50) 263760
> > 64136        5248   86, loc 50,  state 4 (BROKEN)
> 
> Ok, notice how entry 2 and 3 are the same file name?  That is a big part of
> your problem, and it should never happen with the normal kernel code.  The
> two lines that show up as (BROKEN) mean their hash values are incorrect.
> 
> So, were there errors present before you ran reiserfsck -x?  Had you run
> any version of reiserfsck (with -x or --rebuild-tree) before that?

The problems were present before I ran reiserfsck. I never ran
--rebuild-tree

> I'm guessing these problems were caused by reiserfsck, things caused by
> kernel bug would tend towards much more random errors.  The solution will
> probably be an upgrade to the latest fsck version, but I'd like to make
> sure we've got the problem nailed down.

I think this is a problem with the reiserfs code in the kernel. I never
ran reiserfsck before this problem surfaced. The problem arose in the
netscape cache directory with lots of small files. Guess the tail handling
is not that stable yet?

How do I get rid of the /a/yy directory now?


