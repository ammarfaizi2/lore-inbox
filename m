Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282217AbRKWUBj>; Fri, 23 Nov 2001 15:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282215AbRKWUBb>; Fri, 23 Nov 2001 15:01:31 -0500
Received: from lilly.ping.de ([62.72.90.2]:55558 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S282217AbRKWUBU>;
	Fri, 23 Nov 2001 15:01:20 -0500
Date: 23 Nov 2001 21:00:11 +0100
Message-ID: <20011123210011.A487@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.15: results of kernel compilation bench
In-Reply-To: <Pine.LNX.4.33.0111031740330.9962-100000@penguin.transmeta.com> <20011104192725.A847@planetzork.spacenet> <20011105084633.A32243@planetzork.spacenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20011105084633.A32243@planetzork.spacenet>; from jogi on Mon, Nov 05, 2001 at 08:46:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here are the results of my parallel kernel compilation benchmark
for 2.4.15-pre7, 2.4.15-pre7aa1 and 2.4.15. The old results are
included for reference:

                         j25       j50       j75      j100
                                                                                          
2.4.13-pre5aa1:        5:02.63   5:09.18   5:26.27   5:34.36
2.4.13-pre5aa1:        4:58.80   5:12.30   5:26.23   5:32.14
2.4.13-pre5aa1:        4:57.66   5:11.29   5:45.90   6:03.53
2.4.13-pre5aa1:        4:58.39   5:13.10   5:29.32   5:44.49
2.4.13-pre5aa1:        4:57.93   5:09.76   5:24.76   5:26.79
                                                            
2.4.14-pre6:           4:58.88   5:16.68   5:45.93   7:16.56
2.4.14-pre6:           4:55.72   5:34.65   5:57.94   6:50.58
2.4.14-pre6:           4:59.46   5:16.88   6:25.83   6:51.43
2.4.14-pre6:           4:56.38   5:18.88   6:15.97   6:31.72
2.4.14-pre6:           4:55.79   5:17.47   6:00.23   6:44.85
                                                            
2.4.14-pre7:           4:56.39   5:22.84   6:09.05   9:56.59
2.4.14-pre7:           4:56.55   5:25.15   7:01.37   7:03.74
2.4.14-pre7:           4:59.44   5:15.10   6:06.78   12:51.39*
2.4.14-pre7:           4:58.07   5:30.55   6:15.37      *
2.4.14-pre7:           4:58.17   5:26.80   6:41.44      *
                    
2.4.14-pre8:           4:57.14   5:10.72   5:54.42   6:37.39
2.4.14-pre8:           4:59.57   5:11.63   6:34.97   11:23.77
2.4.14-pre8:           4:58.18   5:16.67   6:07.88   6:32.38
2.4.14-pre8:           4:56.23   5:16.57   6:15.01   7:02.45
2.4.14-pre8:           4:58.53   5:19.98   5:39.09   12:08.69

2.4.14-pre8vmscan2:    5:01.64   5:12.03   6:08.62   6:19.32
2.4.14-pre8vmscan2:    4:56.70   5:15.50   6:17.80   6:50.60
2.4.14-pre8vmscan2:    4:56.86   5:14.12   6:02.09   6:16.18
2.4.14-pre8vmscan2:    4:59.43   5:18.02   5:58.50   6:16.87
2.4.14-pre8vmscan2:    4:56.75   5:17.18   5:52.73   6:15.04

2.4.15-pre7:           4:57.45   5:09.25   6:13.70   6:01.78
2.4.15-pre7:           4:57.21   5:13.46   5:50.80   5:53.45
2.4.15-pre7:           4:54.31   5:14.19   5:57.90   6:36.95
2.4.15-pre7:           4:56.50   5:16.22   5:25.88   6:10.21
2.4.15-pre7:           4:56.49   5:16.89   5:39.14   6:09.24

2.4.15-pre7aa1:        4:56.01   5:05.83   5:26.82   5:29.45
2.4.15-pre7aa1:        4:54.33   5:09.11   5:26.04   10:06.2
2.4.15-pre7aa1:        4:52.63   5:06.34   5:46.49   5:55.70
2.4.15-pre7aa1:        4:56.01   5:05.26   5:24.36   6:09.84
2.4.15-pre7aa1:        4:52.92   5:05.31   5:52.71   5:48.47

2.4.15-greased-turkey: 4:57.23   5:15.64   7:05.20   7:44.06
2.4.15-greased-turkey: 4:55.74   5:23.00   7:14.78   12:47.08*
2.4.15-greased-turkey: 4:56.78   5:21.90   6:27.78      *
2.4.15-greased-turkey: 4:56.68   5:17.78   6:24.33      *
2.4.15-greased-turkey: 5:00.65   5:20.16   6:52.77      *


* These builds did not complete because processes were killed
by the OOM killer.


If I have a look at the changelog I see no VM changes anymore
so I am wondering why 2.4.15 is not as good as -pre7 was ...

If you want me to test any patches just let me know.


Kind regards,

   Jogi


-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
