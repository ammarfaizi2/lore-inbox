Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310180AbSCKQHj>; Mon, 11 Mar 2002 11:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310179AbSCKQHR>; Mon, 11 Mar 2002 11:07:17 -0500
Received: from smtp-1.llnl.gov ([128.115.250.81]:1255 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id <S310178AbSCKQHN>;
	Mon, 11 Mar 2002 11:07:13 -0500
Message-ID: <3C8CD629.5090003@llnl.gov>
Date: Mon, 11 Mar 2002 08:07:05 -0800
From: "Tom Epperly" <tepperly@llnl.gov>
Organization: Lawrence Livermore National Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: RH7.2 running 2.4.9-21-SMP (dual Xeon's) yields "Illegal instructions"
In-Reply-To: <E16dxoe-0007l6-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Do you agree that this is likely to be a kernel problem?  Is upgrading
>>the kernel my best course of action?
>>
>
>Almost every other report I have ever seen that looked like that one has always
>turned out to be hardware related. The randomness in paticular tends to be 
>a pointer to thinks like cache faults.
>
>You do have ECC main memory which is good.
>
>What other hardware is in the machine ?
>
>
To recap from an earlier email, my nightly build & regression tests (a 
roughly 2 hour process involving Sun's JDK, GNU make, gcc, g++, g77 & 
Bourne shell scripts) has been failing intermittently on a dual-Xeon 
system usually with an "Illegal intruction" signal. I've tried removing 
the sound card and disabling the X11 server to avoid loading the nVidia 
kernel mod. The intermittent failures disappear when I run non-SMP. I've 
tried swapping the processors on the motherboard, and both processors 
appear to work fine individually. Most of the boxes I've run on have >= 
512MB ECC RAM. I've run Dell's hardware diagnostics (especially the 
memory ones) twice. The diagnostics don't seem to have SMP tests where 
both CPUs are being stressed.

FYI when I upgraded to the 2.4.18-1smp kernel, the failure rate went 
from 20% to 100%. I have tried running the nightly build & regression on 
roughly 6 different dual processors Pentium III or better machines 
(cylcing it over and over), and they all have intermittent failures of 
one kind or another. All these machines are made by Dell, but they 
provide some evidence that it is not a hardware problem.

Tom

