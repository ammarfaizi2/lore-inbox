Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278038AbRJ3Usk>; Tue, 30 Oct 2001 15:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278073AbRJ3UsU>; Tue, 30 Oct 2001 15:48:20 -0500
Received: from colorfullife.com ([216.156.138.34]:48655 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S278038AbRJ3UsH>;
	Tue, 30 Oct 2001 15:48:07 -0500
Message-ID: <3BDF1228.E38185A1@colorfullife.com>
Date: Tue, 30 Oct 2001 21:48:40 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Patch and Performance of larger pipes
In-Reply-To: <OF2428DABF.B9AD95A4-ON86256AEA.005A4949@raleigh.ibm.com> <20011024153930.A12944@watson.ibm.com> <20011030133124.A16257@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> 
> Manfred, here is some more performance measurement and comparision
> to round up some of the stuff we have been doing.
> It would be nice if you could make some comments. As usual raw numbers
> is not everything and there are other issues to consider.
> Comments ?
> 
I'm that much interested at SMP performance right now - most of the SMP
problems are bad interactions with the scheduler. The current scheduler
and the pipe implementation are "optimized" for each other, e.g.
wake_up_sync() is IIRC exclusively used by pipes.

> 
> UP
> --
>                                    %imp
> R.Size    W.Size    R.Compute W.Compute  2.4.9.pipe     Manfred
> ------    ------    -------------------     ----------   --------------
> 512        32k      500           0           0           1.04
> 512        32k        0         500       -0.91           7.72
> 
> 32k        512      500           0         1.09       -78.3
> 32k        512        0         500         0            0
>
I'll try to check that one ASAP. An uniprocessor performance degration
points to an implementation bug in my code.

--
	Manfred
