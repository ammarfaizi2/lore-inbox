Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUALMiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUALMiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:38:13 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:15562 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S266163AbUALMiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:38:04 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Date: Mon, 12 Jan 2004 07:38:02 -0500
User-Agent: KMail/1.5.1
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <20040109014003.3d925e54.akpm@osdl.org> <200401120147.36032.gene.heskett@verizon.net> <20040111230526.72780162.akpm@osdl.org>
In-Reply-To: <20040111230526.72780162.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401120738.02594.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.56.190] at Mon, 12 Jan 2004 06:38:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 January 2004 02:05, Andrew Morton wrote:
>Gene Heskett <gene.heskett@verizon.net> wrote:
>>  Or maybe not, what do I do when "vmstat 1" prints its column
>> headers and segfaults?:
>
>You probably need a new vmstat.  There were quite a few buggy ones
> around. Make sure you have a current procps.

Ripped out 2.0.7 and put in 3.15.something.
rebooted to 2.6.1-rc1-mm2, started x, open a shell and ran vmstat 1
switched to #6, that one really big backdrop window, 8 or 9
seconds to show the backdrop.  Switched back to window 1, instant,
then back to 6, instant.  Back to 1 & kill vmstat.
Here is the vmstat 1 output for that time period.
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0      0 292944  11480  96676    0    0   715   134 1084  2191 59 10 21 10
 1  0      0 293264  11480  96676    0    0     0     0 1273  4856 96  4  0  0
 1  0      0 292400  11488  96676    0    0     0   376 1303  4726 96  4  0  0
 1  0      0 292400  11496  96676    0    0     0    36 1311  3546 98  2  0  0
 1  0      0 292400  11496  96676    0    0     0     0 1071  2414 99  1  0  0
 2  1      0 280352  11528  97252    0    0   600    24 1077  2770 97  3  0  0
 3  0      0 242400  11528  98404    0    0  1152     0 1076  2477 97  3  0  0
 2  0      0 204384  11536  99556    0    0  1152    12 1059  2466 95  5  0  0
 2  0      0 166304  11544 100708    0    0  1152    16 1063  2332 94  6  0  0
 2  0      0 130400  11552 101700    0    0  1000     0 1060  2335 96  4  0  0
 2  0      0 118256  11552 101700    0    0     0     0 1064  2416 98  2  0  0
 2  0      0 116400  11560 101700    0    0     0    12 1052  2363 99  1  0  0
 2  0      0 113520  11568 101700    0    0     0    12 1050  2371 100  0  0  0
 1  0      0 286936  11576 101700    0    0     0    16 1050 13575 83 17  0  0
 1  0      0 287448  11576 101700    0    0     0     0 1128  2649 99  1  0  0
 1  0      0 286936  11576 101700    0    0     0     0 1083  2470 98  2  0  0
 1  0      0 286872  11576 101728    0    0    28     0 1062  2793 98  2  0  0
 1  0      0 287320  11584 101728    0    0     0    16 1052  2306 99  1  0  0
 1  0      0 287712  11592 101728    0    0     0    16 1122  2524 99  1  0  0
 1  0      0 286816  11592 101728    0    0     0     0 1096  2526 99  1  0  0
 1  0      0 286816  11592 101728    0    0     0     0 1056  3281 99  1  0  0
 1  0      0 287648  11592 101728    0    0     0     0 1050  2335 100  0  0  0
 2  0      0 286816  11600 101728    0    0     0   136 1080  2295 99  1  0  0
 1  0      0 287264  11608 101728    0    0     0    16 1057  2315 99  1  0  0
 1  0      0 287584  11608 101728    0    0     0     0 1063  3037 99  1  0  0
 1  0      0 286752  11608 101728    0    0     0     0 1164  2709 95  5  0  0
 1  0      0 287200  11608 101728    0    0     0     0 1061  2785 99  1  0  0
 1  0      0 286688  11616 101728    0    0     0   112 1362  2862 90 10  0  0
 1  0      0 287520  11624 101728    0    0     0    16 1227  2612 94  6  0  0

So it looks as if this fix was there before I noticed it. Now I'll try another
even older boot.
Here is for 2.6.0-test10, the oldest currently in my grub.conf
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0      0 291648  11640  97344    0    0   866   158 1098  2424 54 12 23 12
 1  0      0 291648  11648  97344    0    0     0    36 1204  2788 99  1  0  0
 1  0      0 291648  11656  97344    0    0     0    12 1060  2697 99  1  0  0
 1  0      0 291584  11656  97344    0    0     0     0 1050  2379 99  1  0  0
 1  0      0 292416  11656  97344    0    0     0     0 1049  2365 99  1  0  0
 2  0      0 291584  11664  97344    0    0     0   304 1199  3357 98  2  0  0
 1  0      0 291520  11672  97344    0    0     0    16 1136  3077 99  1  0  0
 3  0      0 284704  11712  97864    0    0   544    36 1101  2856 95  5  0  0
 2  0      0 245216  11712  99016    0    0  1152     0 1076  2375 95  5  0  0
 2  0      0 207584  11712 100296    0    0  1280     0 1060  3062 96  4  0  0
 2  0      0 169184  11712 101448    0    0  1152   788 1201  2370 96  4  0  0
 2  0      0 132384  11736 102368    0    0   928   220 1065  2423 96  4  0  0
 2  0      0 118080  11736 102368    0    0     0     0 1048  2411 97  3  0  0
 2  0      0 115200  11736 102368    0    0     0     0 1051  2399 99  1  0  0
 2  0      0 112384  11736 102368    0    0     0     0 1050  2425 99  1  0  0
 1  0      0 286952  11740 102368    0    0     0     4 1050 13626 83 17  0  0
 1  0      0 286120  11740 102368    0    0     0     0 1052  2362 100  0  0  0
 1  0      0 286952  11748 102368    0    0     0    16 1131  2608 95  5  0  0
 1  0      0 286120  11748 102368    0    0     0     0 1051  2362 100  0  0  0
 1  0      0 286120  11748 102368    0    0     0     0 1050  2346 99  1  0  0
 1  0      0 286000  11756 102396    0    0    28    12 1064  2824 99  1  0  0
 1  0      0 286000  11756 102396    0    0     0     0 1200  2728 96  4  0  0
 1  0      0 286000  11764 102396    0    0     0    16 1056  2704 99  1  0  0
 2  0      0 286000  11764 102396    0    0     0     0 1052  2358 100  0  0  0
 1  0      0 286768  11772 102396    0    0     0    16 1058  2567 99  1  0  0
 1  0      0 285936  11772 102396    0    0     0     0 1061  2422 99  1  0  0
 1  0      0 285936  11772 102396    0    0     0     0 1176  2697 99  1  0  0
 1  0      0 286768  11780 102396    0    0     0    16 1050  3050 98  2  0  0
 1  0      0 285872  11780 102396    0    0     0     0 1051  2382 100  0  0  0
 1  0      0 286704  11780 102396    0    0     0     0 1064  2830 98  2  0  0
 1  0      0 285872  11788 102396    0    0     0    12 1174  2708 99  1  0  0
 1  0      0 286640  11788 102396    0    0     0     0 1053  2590 99  1  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0      0 286640  11796 102396    0    0     0    16 1098  2513 98  2  0  0
 1  0      0 285744  11796 102396    0    0     0     0 1112  2876 98  2  0  0
 1  0      0 286576  11796 102396    0    0     0     0 1227  2881 97  3  0  0
 1  0      0 286576  11796 102396    0    0     0     0 1054  2434 99  1  0  0
 1  0      0 285760  11804 102396    0    0     0    12 1086  2463 99  1  0  0

So it appears that whatever was done, was done even that early.  Anyway, back to
2.6.1-mm2 for the last one.  But I have to build it first, brb :)
Done, and booted to 2.6.1-mm2.  "vmstat 1" now shows:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0      0 293120  11696  97416    0    0   869   160 1099  2513 53 12 24 11
 1  0      0 293136  11696  97416    0    0     0     0 1358  5053 96  4  0  0
 1  0      0 293136  11696  97416    0    0     0     0 1135  2651 99  1  0  0
 3  0      0 270656  11720  98248    0    0   856     0 1083  2726 97  3  0  0
 2  1      0 231872  11728  99528    0    0  1280    36 1093  2775 95  5  0  0
 2  0      0 193552  11744 100680    0    0  1152   304 1128  2450 96  4  0  0
 2  0      0 154832  11752 101832    0    0  1160     0 1068  2406 96  4  0  0
 2  0      0 125328  11752 102440    0    0   608     0 1054  2374 95  5  0  0
 2  0      0 118224  11752 102440    0    0     0     0 1048  2357 99  1  0  0
 2  0      0 115360  11760 102440    0    0     0    16 1098  2414 99  1  0  0
 2  0      0 133920  11764 102440    0    0     0   876 1178  3047 98  2  0  0
 1  0      0 287752  11772 102440    0    0     0    12 1096 13784 85 15  0  0
 1  0      0 287752  11772 102440    0    0     0     0 1132  2601 99  1  0  0
 1  0      0 287688  11772 102468    0    0    28     0 1145  2995 99  1  0  0
 3  0      0 287624  11780 102468    0    0     0    16 1121  2636 99  1  0  0
 1  0      0 287624  11788 102468    0    0     0    16 1169  2640 98  2  0  0
 1  0      0 287624  11788 102468    0    0     0     0 1109  2982 99  1  0  0
 1  0      0 287632  11788 102468    0    0     0     0 1215  2797 100  0  0  0
----
for 5 window switches. 1-6-1-6-1.  And that covers the range of whats still
available here on this system.  I hope all this noise is usefull data, but I
suspect it just demos that the old man wasn't paying sufficient attention.
My apologies for the noise.  During the build, I noticed that the advansis
check_region patch was still good.  Its working here just fine and probably
should be pushed.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

