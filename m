Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288637AbSANLaR>; Mon, 14 Jan 2002 06:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288638AbSANLaI>; Mon, 14 Jan 2002 06:30:08 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:9226 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S288637AbSANL34>; Mon, 14 Jan 2002 06:29:56 -0500
Date: Mon, 14 Jan 2002 11:40:09 +0000
From: Matt Dainty <matt@bodgit-n-scarper.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Where's all my memory going?
Message-ID: <20020114114009.A31918@mould.bodgit-n-scarper.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16OMpF-0001pj-00@the-village.bc.nu> <Pine.LNX.4.33L.0201092034590.2985-100000@imladris.surriel.com> <20020110024520.A29045@em.ca> <20020110030537.C771@lynx.adilger.int> <20020110145542.B2499@mould.bodgit-n-scarper.com> <20020110134657.A26688@lynx.adilger.int> <20020110162445.A13236@em.ca> <20020110153639.H26688@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020110153639.H26688@lynx.adilger.int>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 on i686 SMP (mould)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 03:36:39PM -0700, Andreas Dilger wrote:
> 
> In any case, you also pointed out the same thing I did, namely that these
> slab entries (while having some high numbers) do not account for the large
> amount of used memory in the system.  Maybe SysRQ-M output can help a bit?

Running this on the box after it's settled down a bit, (over the weekend,
the usage hasn't altered), with all mail delivered and collected so the box
is currently quiet, produces the following 'free' output:

root@plum:~# free
             total       used       free     shared    buffers     cached
Mem:       1029524     965344      64180          0      45204      22936
-/+ buffers/cache:     897204     132320
Swap:      2097136        116    2097020

And SysRQ+M yields the following:

SysRq : Show Memory
Mem-info:
Free pages:       66612kB (  4424kB HighMem)
Zone:DMA freepages:  4848kB min:   128kB low:   256kB high:   384kB
Zone:Normal freepages: 57340kB min:  1020kB low:  2040kB high:  3060kB
Zone:HighMem freepages:  4424kB min:  1020kB low:  2040kB high:  3060kB
( Active: 160155, inactive: 58253, free: 16653 )
124*4kB 98*8kB 41*16kB 13*32kB 3*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 1*2048kB = 4848kB)
11029*4kB 1097*8kB 140*16kB 7*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB = 57340kB)
328*4kB 55*8kB 19*16kB 10*32kB 2*64kB 3*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB = 4424kB)
Swap cache: add 48, delete 24, find 13/14, race 0+0
Free swap:       2097020kB
262128 pages of RAM
32752 pages of HIGHMEM
4747 reserved pages
20447 pages shared
24 pages swap cached
0 pages in page table cache
Buffer memory:    44424kB
    CLEAN: 209114 buffers, 836405 kbyte, 188 used (last=209112), 0 locked, 0 dirty
                           ^^^^^^ Is this our magic value?
    DIRTY: 8 buffers, 32 kbyte, 0 used (last=0), 0 locked, 8 dirty

Cheers

Matt
-- 
"Phased plasma rifle in a forty-watt range?"
"Hey, just what you see, pal"
