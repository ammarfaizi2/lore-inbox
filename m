Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135382AbRDLXWO>; Thu, 12 Apr 2001 19:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135383AbRDLXWE>; Thu, 12 Apr 2001 19:22:04 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:14854
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S135382AbRDLXVx>; Thu, 12 Apr 2001 19:21:53 -0400
Date: Thu, 12 Apr 2001 16:21:35 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
In-Reply-To: <E14nqGQ-0001i5-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10104121616070.4564-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Apr 2001, Alan Cox wrote:

> > Okay but what will be used for a base for hardware that has critical
> > timing issues due to the rules of the hardware?
> 
> > #define WAIT_MIN_SLEEP  (2*HZ/100)      /* 20msec - minimum sleep time */
> > 
> > Give me something for HZ or a rule for getting a known base so I can have
> > your storage work and not corrupt.
> 
> 
> The same values would be valid with add_timer and friends regardless. Its just
> that people who do
> 
> 	while(time_before(jiffies, started+DELAY))
> 	{
> 		if(poll_foo())
> 			break;
> 	}
> 
> would need to either use add_timer or we could implement get_jiffies()

Okay regardless of the call what is it going to be or do we just random
and go oh-crap data!?!?

Since HZ!==100 of all archs that have ATA/ATAPI support, it is a mircale
that FS corruption and system death is not more rampant, except for the
fact that hardware is quick by a factor of 10+ so that 1000 does not quite
do as much harm but the associated mean of HZ changes and that is a
problem with slower hardware.

Nevermind just going nuts over the issues...
Just trying to keep the flamage down and stuff like that....

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

