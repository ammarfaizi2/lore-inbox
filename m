Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266150AbRG1B7t>; Fri, 27 Jul 2001 21:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266158AbRG1B7j>; Fri, 27 Jul 2001 21:59:39 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:15378 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266150AbRG1B73>; Fri, 27 Jul 2001 21:59:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Steven Cole <elenstev@mesatop.com>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.8-pre1 and dbench -20% throughput
Date: Sat, 28 Jul 2001 04:04:02 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <200107272112.f6RLC3d28206@maila.telia.com> <0107280034050V.00285@starship> <01072718351100.01369@localhost.localdomain>
In-Reply-To: <01072718351100.01369@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <0107280404020Y.00285@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Saturday 28 July 2001 02:35, Steven Cole wrote:
> I also saw a significant drop in dbench 32 results.
> Here are a few more data points, this time comparing 2.4.8-pre1 with
> 2.4.7.
>
> 2.4.7   9.3422 MB/sec vs 2.4.8-pre1   6.88884 MB/sec average of 3
> runs
>
> The system under test has 384 MB of memory, and did not go
> into swap during the test.  I performed a set of three runs
> immediately after a boot, and with no pauses in between individual
> runs.  I used time ./dbench 32 and caputured the output in a file
> using script `uname -r`.  The tests were done with X and KDE running,
> but no other activity.

The variation is accounted for almost entirely by the change in system 
time.  Does this mean more IO's or more scanning?  I don't know, more 
research needed.

We need Marcelo's vm statistics patch, I wonder what the status of that 
is.

Thanks for the nice clear results, I'll try it here now. ;-)

> Here are the results of the six runs:
>
> Steven
> ---------------------------------------------------------------------
>-------- 2.4.7       average 9.3422 MB/sec
>
> Throughput 9.2929 MB/sec (NB=11.6161 MB/sec  92.929 MBit/sec)
> 34.11user 238.89system 7:34.59elapsed 60%CPU (0avgtext+0avgdata
> 0maxresident)k 0inputs+0outputs (1008major+1402minor)pagefaults
> 0swaps
>
> Throughput 9.56338 MB/sec (NB=11.9542 MB/sec  95.6338 MBit/sec)
> 34.07user 262.44system 7:22.72elapsed 66%CPU (0avgtext+0avgdata
> 0maxresident)k 0inputs+0outputs (1008major+1402minor)pagefaults
> 0swaps
>
> Throughput 9.17032 MB/sec (NB=11.4629 MB/sec  91.7032 MBit/sec)
> 33.79user 248.46system 7:41.62elapsed 61%CPU (0avgtext+0avgdata
> 0maxresident)k 0inputs+0outputs (1008major+1402minor)pagefaults
> 0swaps
>
> ---------------------------------------------------------------------
>-------- 2.4.8-pre1  average 6.88884 MB/sec
>
> Throughput 6.8078 MB/sec (NB=8.50975 MB/sec  68.078 MBit/sec)
> 34.30user 358.35system 10:21.57elapsed 63%CPU (0avgtext+0avgdata
> 0maxresident)k 0inputs+0outputs (1008major+1402minor)pagefaults
> 0swaps
>
> Throughput 6.91993 MB/sec (NB=8.64992 MB/sec  69.1993 MBit/sec)
> 33.62user 369.55system 10:11.43elapsed 65%CPU (0avgtext+0avgdata
> 0maxresident)k 0inputs+0outputs (1008major+1402minor)pagefaults
> 0swaps
>
> Throughput 6.93879 MB/sec (NB=8.67349 MB/sec  69.3879 MBit/sec)
> 33.33user 341.58system 10:09.77elapsed 61%CPU (0avgtext+0avgdata
> 0maxresident)k 0inputs+0outputs (1008major+1402minor)pagefaults
> 0swaps
