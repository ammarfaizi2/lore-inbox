Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278700AbRJTAQG>; Fri, 19 Oct 2001 20:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278701AbRJTAPr>; Fri, 19 Oct 2001 20:15:47 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:56580 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S278700AbRJTAPj>; Fri, 19 Oct 2001 20:15:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Andrei Lahun <Uman@editec-lotteries.com>
Subject: Re: problems with I/O performance with 2.4.12-ac3
Date: Fri, 19 Oct 2001 20:16:11 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Uman@editec-lotteries.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011019163058.1bb7c6f7.uman@chert> <20011019191446.7748bd80.uman@chert>
In-Reply-To: <20011019191446.7748bd80.uman@chert>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011020001546Z278700-17408+2563@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 October 2001 13:14, Andrei Lahun wrote:
> On Fri, 19 Oct 2001 09:27:35 -0400
>
> safemode <safemode@speakeasy.net> wrote:
> > You should give ide and drive chipset info.  This is not a problem seen
> > by everyone using the ac3 kernel.  Mine for instance run just fine.  What
> > settings did you use with bonnie++?  all of this is required info if
> > someone wanted to look and see why you are getting those numbers.
>
> My chipset is VIA apollo 133-A ( old shirt).
> I have run bonnie++ just like bonnie -s 256 , and i have 128 MB of memory,
> disk is MAXTOR 52049H4.With old kernels i always had results something like
> i have with 2.4.13-pre now . And i have read one post in lkml about 2 times
> less write output with 2.4.13 -pre comparing with ac, mine result are
> opposite.

2.4.12-ac3-preempt-hogstop   (no vm patches after the hogstop patch of a 
couple days ago).
PDC20262: chipset revision 1
(my drive on the VIA vt82c686a (rev 22)  is too full to run the test) 
Maxtor 32049H2, ATA DISK drive
All tests were done on this drive.  

(not clean boot) 

test results (bonnie++)  no extra arguments.
Version  1.02       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec 
%CP
psuedomode    1504M  6668  95 27108  39  5429   8  6217  82 22005  11  76.9   
0
                    ------Sequential Create------ --------Random 
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec 
%CP
                 16  1501  97 +++++ +++ +++++ +++  1548  99 +++++ +++  4056  
99
psuedomode,1504M,6668,95,27108,39,5429,8,6217,82,22005,11,76.9,0,16,1501,97,+++++,+++,+++++,+++,1548,99,+++++,+++,4056,99

hdparm results 
 Timing buffered disk reads:  64 MB in  2.26 seconds = 28.32 MB/sec
 Timing buffer-cache reads:   128 MB in  1.00 seconds =128.00 MB/sec
(run in that order)

dbench results (./dbench 32)
Throughput 47.3829 MB/sec (NB=59.2286 MB/sec  473.829 MBit/sec)

