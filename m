Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129127AbRBIVaT>; Fri, 9 Feb 2001 16:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRBIVaK>; Fri, 9 Feb 2001 16:30:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9088 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129127AbRBIV3y>; Fri, 9 Feb 2001 16:29:54 -0500
Date: Fri, 9 Feb 2001 16:29:25 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ashish Gupta <gashish@cse.iitk.ac.in>
cc: kernelnewbies@humbolt.nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: problem in BOGOmips
In-Reply-To: <Pine.LNX.4.04.10102100210150.12228-100000@csews12.cse.iitk.ac.in>
Message-ID: <Pine.LNX.3.95.1010209162809.4101A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2001, Ashish Gupta wrote:

> Hi,
> 	I want to use bogomips as the indicator of CPU capability for
> different architectures. I have found following values from /proc/cpuinfo
> for different CPUs.
> 

In a nutshell, you can't!

There is the requirement for some small delays when performing
certain kernel functions. Therefore, upon startup, a delay
loop is calibrated by checking how many times the delay-loop
gets executed between two or more hardware interrupts. The
hardware interrupts occur at quite precise intervals so the
calibration can be quite accurate.

A side-effect of the calibration is a loop-count variable.
I should have been called "Loop count", but instead, it
was called "bogomips". Many persons assume that "bogomips"
has some relationship to CPU speed or machine capability.
It doesn't. It can only be claimed that a CPU with a faster
core clock might result in a larger loop-count. In fact
a CPU with a faster core-clock might even show a lesser
loop-count because of differences in internal cache management
or branch-prediction with different CPUs.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
