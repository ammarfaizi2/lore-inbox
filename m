Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUEXGOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUEXGOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 02:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbUEXGOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 02:14:42 -0400
Received: from web90009.mail.scd.yahoo.com ([66.218.94.67]:46243 "HELO
	web90009.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264058AbUEXGO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:14:26 -0400
Message-ID: <20040524061425.55367.qmail@web90009.mail.scd.yahoo.com>
Date: Sun, 23 May 2004 23:14:25 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: Help understanding slow down
To: "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0405240509320.16974-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, here we go:
./configure;/usr/bin/time make
make[1]: Leaving directory `/var/tmp/bison-1.875'
9.39user 1.18system 0:11.59elapsed 91%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+147530minor)pagefaults 0swaps

 0  0      0 8151040  19704  87396    0    0     0  
148 1673  1230  3  6 90  1
 0  0      0 8150912  19712  87456    0    0     0    
0 2697  2553 10 13 78  0
 0  0      0 8150712  19712  87388    0    0     4    
0 3233  3404 15 19 66  0
 1  0      0 8147512  19724  87716    0    0   276    
0 2477  2671 23 15 60  2
 1  0      0 8149944  19736  87840    0    0   132    
0 2940  3048 17 17 65  1
 1  1      0 8148144  19736  87840    0    0     0   
32 2647  2466 22 16 62  1
 1  0      0 8150176  19744  87832    0    0     0  
212 2831  2837 19 17 63  0
 1  0      0 8148704  19744  87832    0    0    12    
0 2983  3051 18 18 63  0
 1  0      0 8149984  19744  87832    0    0     0    
0 3260  3632 20 22 58  0
 1  0      0 8149792  19744  87832    0    0     0    
0 3165  3366 19 22 59  0
 0  1      0 8150240  19760  87952    0    0   108   
36 2810  2795 16 17 64  3
 1  0      0 8148768  19768  87944    0    0    12  
208 2851  2775 18 15 65  1
 1  0      0 8149152  19784  88472    0    0   576  
200 2670  2681 16 15 64  5
 1  0      0 8148960  19796  88596    0    0    80    
0 3387  4263 10 20 71  0
 1  0      0 8147864  19800  88728    0    0     0    
0 3070  3834 23 16 60  0
 0  1      0 8148440  19812  88988    0    0     0  
468 3914  4592  7 18 73  1
procs                      memory      swap         
io     system         cpu
 r  b   swpd   free   buff  cache   si   so    bi   
bo   in    cs us sy id wa
 1  0      0 8147352  19844  89228    0    0   120  
300 3070  3900 15 17 65  4
 1  0      0 8144600  19852  89288    0    0     0  
104 1850  1008 35  8 57  1
 1  0      0 8143576  19864  89412    0    0     0    
0 1416   501 43  5 52  0


A little faster than the result you published,
however, it sheds no light for me.  Any thing that
seems to point out some issues?

Thanks,
Phy

--- "Robert M. Stockmann" <stock@stokkie.net> wrote:
> Hi
> 
> > procs memory swap io system cpu
> >
> > r b swpd free    buff  cache si so bi bo  in   cs 
>  us sy id wa
> > 1 0 0    8153848 17000 82348 0  0  0  0   4568
> 4028 6  16 78 0
> > 0 1 0    8154168 17008 82340 0  0  0  160 4596
> 4079 7  17 76 1
> > 1 0 0    8153848 17008 82340 0  0  0  0   4511
> 3998 7  16 76 0
> > 1 0 0    8153912 17008 82340 0  0  0  0   4460
> 3952 7  14 79 0
> > 1 0 0    8153784 17016 82332 0  0  0  0   4437
> 3962 7  16 77 0
> > 1 0 0    8153528 17016 82332 0  0  0  0   4444
> 3927 7  14 78 0
> > 1 1 0    8153784 17024 82392 0  0  0  144 4399
> 3895 7  15 77 1
> > 0 0 0    8153592 17024 82392 0  0  0  0   4367
> 3821 7  15 78 0
> > 1 0 0    8153848 17024 82392 0  0  0  0   4393
> 3926 6  16 78 0
> > 1 0 0    8153528 17024 82460 0  0  0  0   4438
> 3960 8  14 78 0
> > 1 0 0    8154040 17024 82460 0  0  0  0   4415
> 3912 6  15 78 0
> > 1 1 0    8153720 17032 82452 0  0  0  140 4457
> 3953 7  15 77 1
> > 1 0 0    8153784 17032 82452 0  0  0  0   4437
> 3889 7  14 79 0
> > 0 0 0    8153784 17040 82444 0  0  0  0   4398
> 3903 8  15 77 0
> > 1 0 0    8153464 17040 82444 0  0  0  0   4398
> 3902 7  14 79 0
> > 0 0 0    8153528 17040 82444 0  0  0  0   4447
> 3922 6  17 77 0
> > 0 1 0    8153720 17052 82432 0  0  0  144 4490
> 3960 6  16 77 1
> > 0 0 0    8153656 17056 82428 0  0  0  0   4449
> 3954 7  15 78 0
> 
> FIELD DESCRIPTION FOR VM MODE
>    Procs
>        r: The number of processes waiting for run
> time.
>        b: The number of processes in uninterruptible
> sleep.
> 
> During the 18 seconds of displayed stats, you have
> 12 seconds in which
> 1 process is waiting for run time. Which process is
> that, and where is
> it waiting for ?
> 
> Is your custom excecutable compile project causing
> this or does a simple
> compile task display the same slowdowns? As a small
> bench test with a source
> we all can download, try to compile
> bison-1.75.tar.bz2 :
> 
> # ./configure ; time make
> ...
> make[1]: Leaving directory
> `/home/stock/tmp/src/bison-1.75'
> 37.33user 3.64system 0:40.66elapsed 100%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (121059major+64165minor)pagefaults
> 0swaps
> 
> regards,
> 
> Robert
> -- 
> Robert M. Stockmann - RHCE
> Network Engineer - UNIX/Linux Specialist
> crashrecovery.org  stock@stokkie.net
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
