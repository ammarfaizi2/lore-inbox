Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129687AbQKHSWM>; Wed, 8 Nov 2000 13:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129647AbQKHSWC>; Wed, 8 Nov 2000 13:22:02 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:25097 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129470AbQKHSVp>; Wed, 8 Nov 2000 13:21:45 -0500
Date: Wed, 8 Nov 2000 12:17:32 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
Message-ID: <20001108121732.C11377@vger.timpanogas.org>
In-Reply-To: <3A088A3D.2CD0BC53@timpanogas.org> <Pine.LNX.3.95.1001108091850.258A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.95.1001108091850.258A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Nov 08, 2000 at 09:28:54AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 09:28:54AM -0500, Richard B. Johnson wrote:
> On Tue, 7 Nov 2000, Jeff V. Merkey wrote:
> 
> > 
> > Marc Lehman verified that PII systems will generate tons of AGIs with
> > gcc.  Perhaps this is the cause of this problem.  You could run EMON and
> > see if there is something obvious in the numbers ...
> > 
> > Jeff
> > 
> 
> Here are some tests:
> 
> Before the tests, I do:
> `ifconfig eth0 down`
> `kill -TERM -1`
> 
> Then I disconnect my ethernet cable to get rid of those interrupts.
> 
> 
> This is the test-script:
> make clean
> time make -j 10 bzImage
> 
> It is executed as `sh test.sh &>World.Log &` .
> 
> 
> This is Linux 2.4.0-test9
> 
> This is a kernel build with NMI watchdog turned OFF:
> 349.04user 19.83system 3:21.96elapsed 182%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+0minor)pagefaults 0swaps
> 
> 
> This is a kernel build with NMI watchdog turned ON:
> 348.23user 18.84system 3:57.14elapsed 154%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+0minor)pagefaults 0swaps
> 
> The elapsed time went from 3:21 to 3:57.
> 
> 
> This is Linux 2.2.17
> 
> This is the kernel build (the exact same build as above).
> 214.91user 12.93system 2:37.00elapsed 145%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+0minor)pagefaults 0swaps
> 
> The original elapsed time when booting 2.2.17 was 2:37. It is now 3:57.
> 
> This is, in every case, rebuilding the exact same kernel.
> 
> It doth appearith asthough ithsucks.
> 

I'll attempt to reproduce.  I've got live internet servers running on 2.2.18-19
and am not seeing this.

Jeff

> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
