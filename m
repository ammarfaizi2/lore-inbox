Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVIMUrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVIMUrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVIMUrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:47:09 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:38160 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S932462AbVIMUrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:47:07 -0400
Message-ID: <43273AC5.2030509@rainbow-software.org>
Date: Tue, 13 Sep 2005 22:47:01 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2.6.13] i386: Ignore masked FPU exceptions
References: <200509130458_MC3-1-AA03-D8AA@compuserve.com>
In-Reply-To: <200509130458_MC3-1-AA03-D8AA@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> I think ignoring masked FPU exceptions on i386 is the right thing to do.
> Although there is no documentation available for Cyrix MII, I did find
> erratum F-7 for Winchip C6, "FPU instruction may result in spurious
> exception under certain conditions" which seems to indicate that this can
> happen.
> 
> Ondrej, this patch on top of 2.6.13 should fix your Cyrix problems.
> Can you confirm?  There was another bug which was already fixed,
> so this should be all that's needed now.

Thanks, it seems to work fine:

rainbow@pentium:~$ ./mprime
              Main Menu

          1.  Test/Primenet
          2.  Test/User Information
          3.  Test/Vacation or Holiday
          4.  Test/Status
          5.  Test/Continue
          6.  Test/Exit
          7.  Advanced/Test
          8.  Advanced/Time
          9.  Advanced/P-1
         10.  Advanced/ECM
         11.  Advanced/Priority
         12.  Advanced/Manual Communication
         13.  Advanced/Unreserve Exponent
         14.  Advanced/Quit Gimps
         15.  Options/CPU
         16.  Options/Preferences
         17.  Options/Torture Test
         18.  Options/Benchmark
         19.  Help/About
         20.  Help/About PrimeNet Server
Your choice: 17

Beginning a continuous self-test to check your computer.
Please read stress.txt.  Hit ^C to end this test.
Test 1, 400 Lucas-Lehmer iterations of M19922945 using 1024K FFT length.
Self-test 1024K passed!
Test 1, 1000 Lucas-Lehmer iterations of M164865 using 8K FFT length.
Test 2, 1000 Lucas-Lehmer iterations of M172031 using 8K FFT length.
Test 3, 1000 Lucas-Lehmer iterations of M157695 using 8K FFT length.
Test 4, 1000 Lucas-Lehmer iterations of M159745 using 8K FFT length.
Test 5, 1000 Lucas-Lehmer iterations of M163839 using 8K FFT length.
Test 6, 1000 Lucas-Lehmer iterations of M150529 using 8K FFT length.
Test 7, 1000 Lucas-Lehmer iterations of M153599 using 8K FFT length.
Test 8, 1000 Lucas-Lehmer iterations of M155649 using 8K FFT length.
Test 9, 1000 Lucas-Lehmer iterations of M141311 using 8K FFT length.
Test 10, 1000 Lucas-Lehmer iterations of M143361 using 8K FFT length.
Test 11, 1000 Lucas-Lehmer iterations of M147455 using 8K FFT length.
Test 12, 1000 Lucas-Lehmer iterations of M135169 using 8K FFT length.
Test 13, 1000 Lucas-Lehmer iterations of M136191 using 8K FFT length.
Test 14, 1000 Lucas-Lehmer iterations of M139265 using 8K FFT length.
Test 15, 1000 Lucas-Lehmer iterations of M129023 using 8K FFT length.
Test 16, 1000 Lucas-Lehmer iterations of M131073 using 8K FFT length.
Test 17, 1000 Lucas-Lehmer iterations of M133119 using 8K FFT length.
Test 18, 1000 Lucas-Lehmer iterations of M117761 using 8K FFT length.
Test 19, 1000 Lucas-Lehmer iterations of M121855 using 8K FFT length.
Self-test 8K passed!
Test 1, 1000 Lucas-Lehmer iterations of M215041 using 10K FFT length.
Test 2, 1000 Lucas-Lehmer iterations of M204799 using 10K FFT length.
Test 3, 1000 Lucas-Lehmer iterations of M208897 using 10K FFT length.
Test 4, 1000 Lucas-Lehmer iterations of M212991 using 10K FFT length.
Test 5, 1000 Lucas-Lehmer iterations of M194561 using 10K FFT length.
Test 6, 1000 Lucas-Lehmer iterations of M196607 using 10K FFT length.
Test 7, 1000 Lucas-Lehmer iterations of M200705 using 10K FFT length.
Test 8, 1000 Lucas-Lehmer iterations of M184319 using 10K FFT length.
Test 9, 1000 Lucas-Lehmer iterations of M186369 using 10K FFT length.
Test 10, 1000 Lucas-Lehmer iterations of M188415 using 10K FFT length.
Test 11, 1000 Lucas-Lehmer iterations of M164865 using 10K FFT length.
Test 12, 1000 Lucas-Lehmer iterations of M172031 using 10K FFT length.
Test 13, 1000 Lucas-Lehmer iterations of M180225 using 10K FFT length.
Test 14, 1000 Lucas-Lehmer iterations of M157695 using 10K FFT length.
Test 15, 1000 Lucas-Lehmer iterations of M159745 using 10K FFT length.
Test 16, 1000 Lucas-Lehmer iterations of M163839 using 10K FFT length.
Test 17, 1000 Lucas-Lehmer iterations of M150529 using 10K FFT length.
Test 18, 1000 Lucas-Lehmer iterations of M153599 using 10K FFT length.
Self-test 10K passed!
Test 1, 400 Lucas-Lehmer iterations of M17825793 using 896K FFT length.
Self-test 896K passed!
Test 1, 400 Lucas-Lehmer iterations of M14942209 using 768K FFT length.
Self-test 768K passed!
Test 1, 1000 Lucas-Lehmer iterations of M243713 using 12K FFT length.
Test 2, 1000 Lucas-Lehmer iterations of M245759 using 12K FFT length.
Test 3, 1000 Lucas-Lehmer iterations of M258049 using 12K FFT length.
Test 4, 1000 Lucas-Lehmer iterations of M229375 using 12K FFT length.
Test 5, 1000 Lucas-Lehmer iterations of M233473 using 12K FFT length.
Test 6, 1000 Lucas-Lehmer iterations of M235519 using 12K FFT length.
Test 7, 1000 Lucas-Lehmer iterations of M215041 using 12K FFT length.
Test 8, 1000 Lucas-Lehmer iterations of M221183 using 12K FFT length.
Test 9, 1000 Lucas-Lehmer iterations of M225281 using 12K FFT length.
Test 10, 1000 Lucas-Lehmer iterations of M204799 using 12K FFT length.
Test 11, 1000 Lucas-Lehmer iterations of M208897 using 12K FFT length.
Test 12, 1000 Lucas-Lehmer iterations of M212991 using 12K FFT length.
Test 13, 1000 Lucas-Lehmer iterations of M194561 using 12K FFT length.
Test 14, 1000 Lucas-Lehmer iterations of M196607 using 12K FFT length.
Test 15, 1000 Lucas-Lehmer iterations of M200705 using 12K FFT length.
Test 16, 1000 Lucas-Lehmer iterations of M184319 using 12K FFT length.
Test 17, 1000 Lucas-Lehmer iterations of M186369 using 12K FFT length.
Test 18, 1000 Lucas-Lehmer iterations of M188415 using 12K FFT length.
Test 19, 1000 Lucas-Lehmer iterations of M164865 using 12K FFT length.
Test 20, 1000 Lucas-Lehmer iterations of M172031 using 12K FFT length.
Self-test 12K passed!
Test 1, 1000 Lucas-Lehmer iterations of M286719 using 14K FFT length.
Test 2, 1000 Lucas-Lehmer iterations of M294913 using 14K FFT length.
Test 3, 1000 Lucas-Lehmer iterations of M301055 using 14K FFT length.
Test 4, 1000 Lucas-Lehmer iterations of M272385 using 14K FFT length.
Test 5, 1000 Lucas-Lehmer iterations of M278527 using 14K FFT length.
Test 6, 1000 Lucas-Lehmer iterations of M282625 using 14K FFT length.
Test 7, 1000 Lucas-Lehmer iterations of M262143 using 14K FFT length.
Test 8, 1000 Lucas-Lehmer iterations of M266241 using 14K FFT length.
Test 9, 1000 Lucas-Lehmer iterations of M270335 using 14K FFT length.
Test 10, 1000 Lucas-Lehmer iterations of M243713 using 14K FFT length.
Test 11, 1000 Lucas-Lehmer iterations of M245759 using 14K FFT length.
Test 12, 1000 Lucas-Lehmer iterations of M258049 using 14K FFT length.
Test 13, 1000 Lucas-Lehmer iterations of M229375 using 14K FFT length.
Test 14, 1000 Lucas-Lehmer iterations of M233473 using 14K FFT length.
Test 15, 1000 Lucas-Lehmer iterations of M235519 using 14K FFT length.
Test 16, 1000 Lucas-Lehmer iterations of M215041 using 14K FFT length.
Self-test 14K passed!
Test 1, 400 Lucas-Lehmer iterations of M12451841 using 640K FFT length.
Self-test 640K passed!
Test 1, 400 Lucas-Lehmer iterations of M10223617 using 512K FFT length.
Self-test 512K passed!
Test 1, 1000 Lucas-Lehmer iterations of M344065 using 16K FFT length.
Test 2, 1000 Lucas-Lehmer iterations of M319487 using 16K FFT length.
Test 3, 1000 Lucas-Lehmer iterations of M327681 using 16K FFT length.
Test 4, 1000 Lucas-Lehmer iterations of M329727 using 16K FFT length.
Test 5, 1000 Lucas-Lehmer iterations of M307201 using 16K FFT length.
Test 6, 1000 Lucas-Lehmer iterations of M311295 using 16K FFT length.
Test 7, 1000 Lucas-Lehmer iterations of M315393 using 16K FFT length.
Test 8, 1000 Lucas-Lehmer iterations of M286719 using 16K FFT length.
Test 9, 1000 Lucas-Lehmer iterations of M294913 using 16K FFT length.
Test 10, 1000 Lucas-Lehmer iterations of M301055 using 16K FFT length.
Test 11, 1000 Lucas-Lehmer iterations of M272385 using 16K FFT length.
Test 12, 1000 Lucas-Lehmer iterations of M278527 using 16K FFT length.
Test 13, 1000 Lucas-Lehmer iterations of M282625 using 16K FFT length.
Test 14, 1000 Lucas-Lehmer iterations of M262143 using 16K FFT length.
Test 15, 1000 Lucas-Lehmer iterations of M266241 using 16K FFT length.
Self-test 16K passed!
Test 1, 1000 Lucas-Lehmer iterations of M417791 using 20K FFT length.
Test 2, 1000 Lucas-Lehmer iterations of M425985 using 20K FFT length.
Test 3, 1000 Lucas-Lehmer iterations of M430079 using 20K FFT length.
Test 4, 1000 Lucas-Lehmer iterations of M393217 using 20K FFT length.
Test 5, 1000 Lucas-Lehmer iterations of M401407 using 20K FFT length.
Test 6, 1000 Lucas-Lehmer iterations of M409601 using 20K FFT length.
Test 7, 1000 Lucas-Lehmer iterations of M372735 using 20K FFT length.
Test 8, 1000 Lucas-Lehmer iterations of M376833 using 20K FFT length.
Test 9, 1000 Lucas-Lehmer iterations of M389119 using 20K FFT length.
Test 10, 1000 Lucas-Lehmer iterations of M344065 using 20K FFT length.
Test 11, 1000 Lucas-Lehmer iterations of M360447 using 20K FFT length.
Self-test 20K passed!
Test 1, 400 Lucas-Lehmer iterations of M8716289 using 448K FFT length.
Self-test 448K passed!
Test 1, 400 Lucas-Lehmer iterations of M7471105 using 384K FFT length.
Test 2, 400 Lucas-Lehmer iterations of M7471103 using 384K FFT length.
Self-test 384K passed!
Test 1, 1000 Lucas-Lehmer iterations of M491521 using 24K FFT length.
Test 2, 1000 Lucas-Lehmer iterations of M466943 using 24K FFT length.
Test 3, 1000 Lucas-Lehmer iterations of M471041 using 24K FFT length.
Test 4, 1000 Lucas-Lehmer iterations of M487423 using 24K FFT length.
Test 5, 1000 Lucas-Lehmer iterations of M442369 using 24K FFT length.
Test 6, 1000 Lucas-Lehmer iterations of M450559 using 24K FFT length.
Test 7, 1000 Lucas-Lehmer iterations of M458753 using 24K FFT length.
Test 8, 1000 Lucas-Lehmer iterations of M417791 using 24K FFT length.
Test 9, 1000 Lucas-Lehmer iterations of M425985 using 24K FFT length.
Self-test 24K passed!
Test 1, 1000 Lucas-Lehmer iterations of M589823 using 28K FFT length.
Test 2, 1000 Lucas-Lehmer iterations of M557057 using 28K FFT length.
Test 3, 1000 Lucas-Lehmer iterations of M565247 using 28K FFT length.
Test 4, 1000 Lucas-Lehmer iterations of M573441 using 28K FFT length.
Test 5, 1000 Lucas-Lehmer iterations of M532479 using 28K FFT length.
Test 6, 1000 Lucas-Lehmer iterations of M540673 using 28K FFT length.
Test 7, 1000 Lucas-Lehmer iterations of M544767 using 28K FFT length.
Self-test 28K passed!
Test 1, 400 Lucas-Lehmer iterations of M6422529 using 320K FFT length.
Test 2, 400 Lucas-Lehmer iterations of M6422527 using 320K FFT length.
Self-test 320K passed!
Test 1, 400 Lucas-Lehmer iterations of M5242881 using 256K FFT length.
Torture Test ran 6 hours, 6 minutes - 0 errors, 0 warnings.


> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
>  arch/i386/kernel/traps.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> --- 2.6.13a.orig/arch/i386/kernel/traps.c
> +++ 2.6.13a/arch/i386/kernel/traps.c
> @@ -804,8 +804,9 @@ void math_error(void __user *eip)
>  	cwd = get_fpu_cwd(task);
>  	swd = get_fpu_swd(task);
>  	switch (swd & ~cwd & 0x3f) {
> -		case 0x000:
> -		default:
> +		case 0x000: /* No unmasked exception */
> +			return;
> +		default:    /* Multiple exceptions */
>  			break;
>  		case 0x001: /* Invalid Op */
>  			/*
> __
> Chuck
> 


-- 
Ondrej Zary
