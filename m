Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136115AbRASAnb>; Thu, 18 Jan 2001 19:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135463AbRASAnV>; Thu, 18 Jan 2001 19:43:21 -0500
Received: from innerfire.net ([208.181.73.33]:19981 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S136126AbRASAnM>;
	Thu, 18 Jan 2001 19:43:12 -0500
Date: Thu, 18 Jan 2001 16:43:15 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: Mike Kravetz <mkravetz@sequent.com>
cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: multi-queue scheduler update
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com>
Message-ID: <Pine.LNX.4.10.10101181642200.16244-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What affect does this scheduler have on 1 - 5 tasks??

	Gerhard


On Thu, 18 Jan 2001, Mike Kravetz wrote:

> I just posted an updated version of the multi-queue scheduler
> for the 2.4.0 kernel.  This version also contains support for
> realtime tasks.  The patch can be found at:
> 
> http://lse.sourceforge.net/scheduling/
> 
> Here are some very preliminary numbers from sched_test_yield
> (which was previously posted to this (lse-tech) list by Bill
> Hartner).  Tests were run on a system with 8 700 MHz Pentium
> III processors.
> 
>                            microseconds/yield
> # threads      2.2.16-22           2.4        2.4-multi-queue
> ------------   ---------         --------     ---------------
> 16               18.740            4.603         1.455
> 32               17.702            5.134         1.456
> 64               23.300            5.586         1.466
> 128              47.273           18.812         1.480
> 256             105.701           71.147         1.517
> 512               FRC            143.500         1.661
> 1024              FRC            196.425         6.166
> 2048              FRC              FRC          23.291
> 4096              FRC              FRC          47.117
> 
> *FRC = failed to reach confidence level
> 
> -- 
> Mike Kravetz                                 mkravetz@sequent.com
> IBM Linux Technology Center
> 15450 SW Koll Parkway
> Beaverton, OR 97006-6063                     (503)578-3494
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
