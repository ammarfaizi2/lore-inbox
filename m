Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274749AbRIZAgI>; Tue, 25 Sep 2001 20:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274750AbRIZAf7>; Tue, 25 Sep 2001 20:35:59 -0400
Received: from member.michigannet.com ([207.158.188.18]:8722 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S274749AbRIZAfy>; Tue, 25 Sep 2001 20:35:54 -0400
Date: Tue, 25 Sep 2001 20:35:15 -0400
From: Paul <set@pobox.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 much better than previous 2.4.x :-)
Message-ID: <20010925203515.A227@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Rik van Riel <riel@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1001377785.1430.7.camel@gromit.house> <Pine.LNX.4.33L.0109242234410.19147-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109242234410.19147-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Mon, Sep 24, 2001 at 10:35:53PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br>, on Mon Sep 24, 2001 [10:35:53 PM] said:
> 
> If you have the time, could you also test 2.4.9-ac15 ?
> 
> (The -ac VM has basically branched off at 2.4.7 and has
> evolved quite a bit since ... last week I fixed a stupid
> page aging bug and things should be a lot better than
> before now)
> 
> regards,
> 
> Rik

	K6-333 128M ram
	2.4.9-ac15 my impression: Well, running mutt with 80M
folder open, desktop with several aterms and netscape with a few
windows open, I started building a kernel in one term, and a
'find / -type f -exec md5sum {}' in another, then started reading
the mail, and occasionally jumping around the virtual desktop,
exposing netscapes... (this is pretty much my normal working
load, except for the find.)
	I thought it worked very well; exposed netscapes were
either just there, or drew almost instantly. (other kernels I
have used, under the same load would usually take quite a bit
longer for exposed netscape to draw itself.) 'interactiveness'
seemed good.

	Then, I read a post in this thread about swap being
funny. I noticed that no swap was being reported as used all
during my test. So, I forced the issue with an endless malloc.
Very quickly, the system seems to freeze, and the disk is
yammering away. I was waiting for the OOM killer to kick in,
but it never did. <alt><sysrq> works well, and I used it to print
out the Mem stats after several minutes. Eventually, I used
sysrq to sync and kill (couldnt get it to reBoot, though).
	Im not complaining-- Im just curious why no OOM killing, 
and the Mem stats report 337148k swap free (I have 337168k).
Does this memmory report look  proper for a machine thrashing
itself to death from endless mallocs?

Paul
set@pobox.com

SysRq : Show Memory
Mem-info:
Free pages:        1512kB (     0kB HighMem)
( Active: 63, inactive_dirty: 172, inactive_clean: 0, free: 378 (351 702 1053) )
1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB = 508kB)
25*4kB 3*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 1004kB)
= 0kB)
Swap cache: add 5, delete 5, find 0/0
Page cache size: 79
Buffer mem: 156
Ramdisk pages: 0
Free swap:       337148kB
32764 pages of RAM
0 pages of HIGHMEM
1038 reserved pages
115 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:      624kB
