Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264869AbRGENyY>; Thu, 5 Jul 2001 09:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbRGENyP>; Thu, 5 Jul 2001 09:54:15 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:53629 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264869AbRGENyF>; Thu, 5 Jul 2001 09:54:05 -0400
Date: Thu, 5 Jul 2001 15:53:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT please; Sybase 12.5
Message-ID: <20010705155350.O17051@athlon.random>
In-Reply-To: <3B3C4CB4.6B3D2B2F@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B3C4CB4.6B3D2B2F@kegel.com>; from dank@kegel.com on Fri, Jun 29, 2001 at 02:39:00AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2001 at 02:39:00AM -0700, Dan Kegel wrote:
> At work I had to sit through a meeting where I heard
> the boss say "If Linux makes Sybase go through the page cache on
> reads, maybe we'll just have to switch to Solaris.  That's
> a serious performance problem."
> All I could say was "I expect Linux will support O_DIRECT
> soon, and Sybase will support that within a year."  
> 
> Er, so did I promise too much?  Andrea mentioned O_DIRECT recently
> ( http://marc.theaimsgroup.com/?l=linux-kernel&m=99253913516599&w=2,
>  http://lwn.net/2001/0510/bigpage.php3 )
> Is it supported yet in 2.4, or is this a 2.5 thing?

all 2.4 kernel in SuSE 7.2 ships with O_DIRECT enabled by default for
ext2, just open your files with O_DIRECT as luser and there you go.
Today I got in my inbox a patch from Chris Wedgwood for reiserfs, and
Andrew Morton took care of ext3 O_DIRECT support (included into the ext3
patch and conditional to #ifdef KERNEL_HAS_O_DIRECT that he asked me to
add to the latest o_direct patches). (you know O_DIRECT is 99% common
code, so supporting new fs is almost a no brainer)

I will send the o_direct patch to Linus for 2.4 too but possibly this is
2.5 material, however I will fully support it for 2.4 too indeed as it
is rock solid and you can just use it in production, same thing that
everybody has to do for rawio in 2.2.

I will release a new patch soon against 2.4.7pre2 in the next aa
patchkit as soon as I finished to synchronize my tree.

Andrea
