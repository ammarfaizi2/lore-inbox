Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313430AbSDESnx>; Fri, 5 Apr 2002 13:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313432AbSDESno>; Fri, 5 Apr 2002 13:43:44 -0500
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:61710 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S313430AbSDESni>; Fri, 5 Apr 2002 13:43:38 -0500
Message-ID: <007901c1dcd1$c446bb90$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "dean gaudet" <dean-list-linux-kernel@arctic.org>,
        "Andrew Morton" <akpm@zip.com.au>
Cc: <joeja@mindspring.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204042330270.10358-100000@twinlark.arctic.org>
Subject: Re: faster boots?
Date: Fri, 5 Apr 2002 10:43:21 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It may be interesting to note that SGI's XFS has a
"realtime section" or some such, which has no metadata,
only data blocks.  Perhaps DMAPI has methods for moving
files around on a live fs.  If you know what you want in there.

Jeremy

----- Original Message -----
From: "dean gaudet" <dean-list-linux-kernel@arctic.org>
To: "Andrew Morton" <akpm@zip.com.au>
Cc: <joeja@mindspring.com>; <linux-kernel@vger.kernel.org>
Sent: Thursday, April 04, 2002 11:45 PM
Subject: Re: faster boots?


> On Thu, 4 Apr 2002, Andrew Morton wrote:
>
> > I guess the greatest benefit would come from reorganising the
> > layout of the root filesystem's data and metadata so the
> > pagecache prepopulation doesn't have to seek all over the place.
>
> windows xp does this automatically (but it takes a lot of idle time before
> it'll start playing with your disk)... search for "bootvis" at
> microsoft.com, that tool can force the reorganization to occur.  it's
> worth 10%ish there as well (quite noticeable on laptops).  they appear to
> reorganize the boot-time files into one big contiguous region.  that's
> fetched into their equivalent of the page cache with sequential reads.
>
> it's certainly interesting theory -- trying to do disk layout which is
> optimised for particular access patterns... it's kind of a hack to do this
> just for boot time, but definitely educational :)
>
> in some ways, the filesystem is the wrong place to do this type of
> activity -- you could approach the problem as a block layer device between
> the fs and the hardware which maintains statistics on access patterns and
> moves blocks around to optimise access time -- which lets you fix all
> sorts of seeking problems.  i guess the challenge would be maintaining a
> map of logical block number to physical block number.  hmm.  guess that's
> kind of hard.
>
> -dean
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

