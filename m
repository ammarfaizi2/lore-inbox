Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284894AbRLFAQS>; Wed, 5 Dec 2001 19:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284842AbRLFAQJ>; Wed, 5 Dec 2001 19:16:09 -0500
Received: from femail3.sdc1.sfba.home.com ([24.0.95.83]:10996 "EHLO
	femail3.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S284886AbRLFAPt>; Wed, 5 Dec 2001 19:15:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Larry McVoy <lm@bitmover.com>, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
Date: Wed, 5 Dec 2001 09:33:42 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Lars Brinkhoff <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011204163646.M7439@work.bitmover.com> <2527982215.1007550329@mbligh.des.sequent.com> <20011205111115.T11801@work.bitmover.com>
In-Reply-To: <20011205111115.T11801@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011206001548.OPWU485.femail3.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 December 2001 02:11 pm, Larry McVoy wrote:
> > If I give you 16 SMP systems, each with 4 processors and a gigabit
> > ethernet card, and connect those ethers through a switch, would that
> > be sufficient hardware?
>
> You've completely misunderstood the message, sorry, I must not have been
> clear. What I am proposing is to cluster *OS* images on a *single* SMP as a
> way of avoiding most of the locks necessary to scale up a single OS image
> on the same number of CPUs.
>
> It has nothing to do with clustering more than one system, it's not that
> kind of clustering.  It's clustering OS images.

So basically, you're just turning the per-processor data into a tree?

> To make it easy, let's imagine you have a 16 way SMP box and an OS image
> that runs well on one CPU.  Then a ccCluster would be 16 OS images, each
> running on a different CPU, all on the same hardware.
>
> DEC has done this, Sun has done this, IBM has really done this, but what
> none of them have done is make mmap() work across OS boundaries.

The shared memory clustering people are basically trying to make 
mmap+semaphores work across a high speed LAN.  Why?  Because it's cheap, and 
the programming model's familiar.

Approaching it all from a different direction, though.  Probably not of help 
to you...

Rob
