Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313906AbSDPWCi>; Tue, 16 Apr 2002 18:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313907AbSDPWCh>; Tue, 16 Apr 2002 18:02:37 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:59151 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S313906AbSDPWCh>; Tue, 16 Apr 2002 18:02:37 -0400
Message-ID: <3CBC9F6D.3F4E6579@zip.com.au>
Date: Tue, 16 Apr 2002 15:02:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: jjs@lexus.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 final - another data point
In-Reply-To: <20020416174827.A1845@rushmore>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
> 
> >>Running dbench 128 on ext2 mounted with delalloc and Andrew's
> >>patches from http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.8/
> >>was 7.5x faster than 2.5.8 vanilla and 1.5x faster than
> 
> > Wow, good stuff - I'll have to pull those down
> 
> Hmm, I had to run e2fsck -f twice on the filesystem that ran
> dbench, tiobench, bonnie++ on nfs, and osdb.  The filesystem
> was showing 52% used and is normally 1% used before/after
> testing.  No big files on the fs. The directory where
> bonnie++ on nfs runs had some temporary directories that
> were not deletable.  A bunch of files/directories were in
> lost+found after e2fsck.  After removing the files, the
> fs was back to 1% used.
> 

ho-hum.  Presumably an unreservepage() got lost somewhere
in the diff shuffling.

All I'm doing with the delayed-allocation code at present
is keeping the diffs up to date.  I haven't even compiled
that stuff for over a week.  All work at present is against
dallocbase-70-writeback.   It's probably not a good use of
your time to test anything beyond that.  Sorry about that.

I'll leave the later diffs available so anyone who's interested
can see the multipage bio assembly stuff, but "dont use".

-
