Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbRELW2f>; Sat, 12 May 2001 18:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261329AbRELW2Z>; Sat, 12 May 2001 18:28:25 -0400
Received: from 213.237.80.42.adsl.he.worldonline.dk ([213.237.80.42]:46203
	"EHLO udgaard.com") by vger.kernel.org with ESMTP
	id <S261328AbRELW2P>; Sat, 12 May 2001 18:28:15 -0400
Date: Sun, 13 May 2001 00:29:47 +0200
From: Peter Rasmussen (udgaard) <plr@udgaard.com>
Message-Id: <200105122229.AAA03353@udgaard.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How can I help with VIA MVP3 problems?
Cc: plr@udgaard.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not on the list so please also reply directly to me. I may soon be done :-)

I was made aware of the following:

>On Sat, May 12, 2001 at 07:37:23PM +0200, Peter Rasmussen wrote:
>> 2.4.4-ac8 doing "time make dep clean bzImage modules modules_install" :
>> 
>> udgaard:/usr/src/linux# cat /proc/meminfo
>>         total:    used:    free:  shared: buffers:  cached:
>> Mem:  328101888 317947904 10153984        0 67219456 130404352
>> Swap: 542859264        0 542859264
>> 
>> ======================== 2.2.16 ===========================
>> 
>> udgaard:~$ cat /proc/meminfo 
>>         total:    used:    free:  shared: buffers:  cached:
>> Mem:  65789952 60755968  5033984 28221440  7872512 24219648
>> Swap: 542859264  1368064 541491200
>
>2.2.16 only recognizes 64 Mb? That makes all of the numbers less
>interesting, I guess.
>
I hadn't noticed that before and it helped me improving the test. By ensuring
that the two kernels looked at the same size RAM I found that the performance
numbers were the same.

However, I then now wonder why my system gets slower when increasing the amount of main RAM?

Is it a RAM caching problem in the chipset or the board similar to the braindead
Intel VX430 chipset that couldn't handle more than 64MB? I hope not, but I can't
see any other reason, even though I thought such problems were of the past?
Please let me know if you know something about it.

I found the following relations with regard to memory settings. As the 2.2 and
2.4 kernels I use performed the same with little RAM (64MB), I stayed with the
2.4.4-ac8 for simplicity's sake.

A 2.4.4-ac8 kernel build:

2.4.4-ac8 with 64MB RAM mem-setting: real    8m26.180s
                                     user    7m5.340s
                                     sys     0m39.430s

2.4.4-ac8 with 128MB RAM mem-setting: real    8m20.902s
                                      user    7m8.810s
                                      sys     0m39.800s

2.4.4-ac8 with 160MB RAM mem-setting: real    8m21.653s
                                      user    7m13.830s
                                      sys     0m37.840s

2.4.4-ac8 with 192MB RAM mem-setting: real    9m48.632s
                                      user    8m39.270s
                                      sys     0m39.740s

So it seems around here the performance starts to decrease.

I am still puzzled why the shared memory like the following is always zero on
the 2.4 kernels? All I can remember checking it on has it like that, but I can't
find any explanations about it?

udgaard:/usr/src/linux# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  64135168 63148032   987136        0  2965504 34447360
Swap: 542859264   147456 542711808

Thank you very much,

Peter
