Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280949AbRKCMsH>; Sat, 3 Nov 2001 07:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280950AbRKCMr6>; Sat, 3 Nov 2001 07:47:58 -0500
Received: from www.wen-online.de ([212.223.88.39]:9747 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S280949AbRKCMrn>;
	Sat, 3 Nov 2001 07:47:43 -0500
Date: Sat, 3 Nov 2001 13:47:19 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: <jogi@planetzork.ping.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
In-Reply-To: <20011102174835.B479@planetzork.spacenet>
Message-ID: <Pine.LNX.4.33.0111031304250.311-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Nov 2001 jogi@planetzork.ping.de wrote:

> I did my usual kernel compile testings and here are the resuls:
>
>                     j25       j50       j75      j100
>
> 2.4.13-pre5aa1:   5:02.63   5:09.18   5:26.27   5:34.36
> 2.4.13-pre5aa1:   4:58.80   5:12.30   5:26.23   5:32.14
> 2.4.13-pre5aa1:   4:57.66   5:11.29   5:45.90   6:03.53
> 2.4.13-pre5aa1:   4:58.39   5:13.10   5:29.32   5:44.49
> 2.4.13-pre5aa1:   4:57.93   5:09.76   5:24.76   5:26.79
>
> 2.4.14-pre6:      4:58.88   5:16.68   5:45.93   7:16.56
> 2.4.14-pre6:      4:55.72   5:34.65   5:57.94   6:50.58
> 2.4.14-pre6:      4:59.46   5:16.88   6:25.83   6:51.43
> 2.4.14-pre6:      4:56.38   5:18.88   6:15.97   6:31.72
> 2.4.14-pre6:      4:55.79   5:17.47   6:00.23   6:44.85
>
> 2.4.14-pre7:      4:56.39   5:22.84   6:09.05   9:56.59
> 2.4.14-pre7:      4:56.55   5:25.15   7:01.37   7:03.74
> 2.4.14-pre7:      4:59.44   5:15.10   6:06.78   12:51.39*
> 2.4.14-pre7:      4:58.07   5:30.55   6:15.37      *
> 2.4.14-pre7:      4:58.17   5:26.80   6:41.44      *

<snip>

> Otherwise -pre5aa1 still seems to be the fastest kernel *in this test*.

My box agrees.  Notice pre5aa1/ac IO numbers below.  I'm getting
~good %user/wallclock with pre6/pre7 despite (thrash?) IO numbers.

	-Mike

fresh boot -> time make -j30 bzImage && procinfo >> /stats

2.4.13-pre2.virgin
real    8m44.484s
user    6m37.800s
sys     0m27.040s

user  :       0:06:44.26  68.4%  page in :   653397
nice  :       0:00:00.00   0.0%  page out:   617078
system:       0:01:22.68  14.0%  swap in :   112202
idle  :       0:01:43.93  17.6%  swap out:   149382

2.4.13-pre2.aa1
real    8m5.204s
user    6m38.590s
sys     0m27.220s

user  :       0:06:44.90  74.8%  page in :   560202
nice  :       0:00:00.00   0.0%  page out:   568467
system:       0:01:09.70  12.9%  swap in :    97083
idle  :       0:01:06.55  12.3%  swap out:   137374

2.4.13-pre5.virgin
real    9m1.709s
user    6m37.310s
sys     0m53.880s

user  :       0:06:44.49  66.1%  page in :   519473
nice  :       0:00:00.00   0.0%  page out:   521926
system:       0:01:51.32  18.2%  swap in :    93794
idle  :       0:01:35.91  15.7%  swap out:   125145

2.4.13-pre5.aa1
real    7m30.261s
user    6m35.930s
sys     0m28.500s

user  :       0:06:42.74  76.8%  page in :   402421
nice  :       0:00:00.00   0.0%  page out:   390429
system:       0:01:21.20  15.5%  swap in :    70652
idle  :       0:00:40.51   7.7%  swap out:    90871

2.4.13.virgin
real    9m13.976s
user    6m36.910s
sys     0m27.510s

user  :       0:06:43.67  64.3%  page in :   523516
nice  :       0:00:00.00   0.0%  page out:   547148
system:       0:00:41.29   6.6%  swap in :    85945
idle  :       0:03:02.39  29.1%  swap out:   131574

2.4.14-pre2.virgin
real    8m0.051s
user    6m34.060s
sys     0m31.020s

user  :       0:06:40.77  72.9%  page in :   425768
nice  :       0:00:00.00   0.0%  page out:   494520
system:       0:00:44.65   8.1%  swap in :    82020
idle  :       0:01:44.23  19.0%  swap out:   117066

2.4.14-pre2.virgin+p2p3
real    8m0.094s
user    6m35.450s
sys     0m29.810s

user  :       0:06:41.38  73.2%  page in :   432894
nice  :       0:00:00.00   0.0%  page out:   483079
system:       0:00:43.71   8.0%  swap in :    82909
idle  :       0:01:42.92  18.8%  swap out:   113578

2.4.14-pre3.virgin
real    8m30.454s
user    6m35.760s
sys     0m29.770s

user  :       0:06:42.40  69.6%  page in :   430062
nice  :       0:00:00.00   0.0%  page out:   610021
system:       0:00:42.29   7.3%  swap in :    84529
idle  :       0:02:13.18  23.0%  swap out:   147283

2.4.14-pre6.virgin
real    7m58.841s
user    6m37.220s
sys     0m30.370s

user  :       0:06:43.37  73.6%  page in :   576081
nice  :       0:00:00.00   0.0%  page out:   704720
system:       0:00:42.87   7.8%  swap in :   120317
idle  :       0:01:41.45  18.5%  swap out:   170619

2.4.14-pre7.virgin
real    7m56.357s
user    6m36.580s
sys     0m30.600s

user  :       0:06:42.88  74.5%  page in :   646265
nice  :       0:00:00.00   0.0%  page out:   704490
system:       0:00:43.11   8.0%  swap in :   136957
idle  :       0:01:34.61  17.5%  swap out:   171134

2.4.14-pre6aa1
real    8m29.484s
user    6m38.650s
sys     0m27.940s

user  :       0:06:45.45  70.6%  page in :   641298
nice  :       0:00:00.00   0.0%  page out:   634494
system:       0:00:41.73   7.3%  swap in :   118869
idle  :       0:02:06.90  22.1%  swap out:   154141

2.4.12-ac1
real    8m12.184s
user    6m35.170s
sys     0m33.630s

user  :       0:06:41.35  71.8%  page in :   402144
nice  :       0:00:00.00   0.0%  page out:   382625
system:       0:01:44.76  18.7%  swap in :    65589
idle  :       0:00:53.25   9.5%  swap out:    89164

2.4.12-ac3
real    8m8.200s
user    6m36.230s
sys     0m32.340s

user  :       0:06:43.05  71.7%  page in :   419527
nice  :       0:00:00.00   0.0%  page out:   385711
system:       0:00:49.29   8.8%  swap in :    70491
idle  :       0:01:49.46  19.5%  swap out:    89771

2.4.13-ac6
real    8m15.366s
user    6m35.710s
sys     0m33.570s

user  :       0:06:42.25  71.6%  page in :   461270
nice  :       0:00:00.00   0.0%  page out:   494015
system:       0:00:49.03   8.7%  swap in :    82114
idle  :       0:01:50.74  19.7%  swap out:   117766

