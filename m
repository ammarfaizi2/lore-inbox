Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273424AbRINQ0K>; Fri, 14 Sep 2001 12:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273423AbRINQ0B>; Fri, 14 Sep 2001 12:26:01 -0400
Received: from [209.10.41.242] ([209.10.41.242]:31669 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S273422AbRINQZu>;
	Fri, 14 Sep 2001 12:25:50 -0400
Date: Fri, 14 Sep 2001 15:12:14 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Athlon problems fixed tweaking BIOS memory settings
To: aia21@cus.cam.ac.uk,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3BA2022E.F33FA9B6@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov (aia21@cus.cam.ac.uk) wrote :

> Hi all, 
> 
> I had a few random crashes on my Athlon EPOX 8KTA3 mobo Athlon 1.33GHz 
> (BIOS from 06/14/2001) and Alan Cox suggested to run memtest as the oops 
> apparently looked like memory corruption. Sure enough memtest showed 
> problems above 256MiB but swapping the chips around still showed problems 
> above 256MiB which meant it couldn't be the chips at fault (failing tests 
> were 5 and 8 in memtest86 supplied with SuSE 7.2). 

To eliminate any doubt about the chips, I suggest testing each of them separately.

> 
> Playing with the memory settings I found that using the "DRAM 
> Timing by SPD" option was unstable but setting it to manual and using the 
> settings: 133MHz, CL2, Bank interleave disabled as well as Pre charge to 
> active 3T, active to precharge 6T, active to cmd 3T. Makes it fully 
> stable even with Page-Mode enabled. 
> 
> Changing the precharge/act/cmd value to faster caused increasing amounts 
> of errors in memtest to appear and enabling Timing by SPD did the same. 
> Memory now running at 23.1 MiB/sec according to memtest86 compared to 26 
> MiB/sec at previous, faster but unstable settings. 
> 
> It seems there is some kind of problem with the "Timing by SPD" option. 

SPD EEPROMs on many ( especially no-name ) RAM modules are programmed incorrectly
( according to C'T magazine - http://www.heise.de/ct/ ) so "Timing by SPD" does
not work at all, or sets a wrong timing.

> Also no matter what the settings are the system is always error free below 
> 256MiB, which means that might explain why some people are having problems 
> and some are not... Until I upgraded the 256 to 768MiB I didn't have any 
> problems. 
> 
> Just a datapoint... 
> 
> Best regards, 
> 
>         Anton 

-- 
David Balazic
--------------
"Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore Logan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
