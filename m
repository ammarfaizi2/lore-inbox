Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRBEGOl>; Mon, 5 Feb 2001 01:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbRBEGOc>; Mon, 5 Feb 2001 01:14:32 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:59465 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129030AbRBEGOU>;
	Mon, 5 Feb 2001 01:14:20 -0500
Message-ID: <3A7E4454.82DDB73C@sgi.com>
Date: Sun, 04 Feb 2001 22:12:36 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.2-pre1 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>
Subject: 2.4.2-test1 better on disk lock/freezups
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In trying to apply Jens's patch I upgraded to 2.4.2-pre1.  The figures on it(242-p1) look
better at this point: a vmstat dump, same data...notice this time it only took maybe 45
seconds to write out the data.  I also got better interactive performance.
So write speed is up to about 3.5Mb/s.  Fastest reads using 'hdparm' are in the 12-14Mb/s
range.  Sooo...IDE hdparm block dev read vs. file writes...3-4:1 ratio?

I honestly have little clue as to what would be considered 'good' numbers.

Note the maximum 'system freeze' seems under 10 seconds now -- alot more 
tolerable.  

Note also, this was without my applying Jens's patch -- as I could not figure out how
to get it to apply cleanly  :-(.


 0  0  0      0  77564  80220 280164   0   0     0   348  287  1367  10   7  83
 0  0  1      0  77560  80220 280164   0   0     0   304  193   225   0   1  99
 0  1  1      0  77572  80220 280156   0   0     0   162  241   354   4   2  95
 0  1  1      0  77572  80220 280156   0   0     0   156  218   182   0   1  99
 1  1  1      0  77560  80220 280164   0   0     0   165  217   218   0   1  99
 0  1  1      0  77328  80220 280164   0   0     0   134  213   215   1   1  97
 0  1  1      0  77328  80220 280164   0   0     0   138  217   177   0   1  98
 0  1  1      0  77328  80220 280164   0   0     0   206  215   178   0   1  99
 0  1  1      0  77332  80220 280164   0   0     0   166  219   206   1   1  98
 0  0  0      0  85632  80220 280172   0   0    14    12  192   360   1   1  98
 
-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
