Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284600AbRLETNG>; Wed, 5 Dec 2001 14:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284594AbRLETMv>; Wed, 5 Dec 2001 14:12:51 -0500
Received: from bitmover.com ([192.132.92.2]:18305 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284576AbRLETLQ>;
	Wed, 5 Dec 2001 14:11:16 -0500
Date: Wed, 5 Dec 2001 11:11:15 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        Lars Brinkhoff <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
Message-ID: <20011205111115.T11801@work.bitmover.com>
Mail-Followup-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
	Lars Brinkhoff <lars.spam@nocrew.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011204163646.M7439@work.bitmover.com> <2527982215.1007550329@mbligh.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2527982215.1007550329@mbligh.des.sequent.com>; from Martin.Bligh@us.ibm.com on Wed, Dec 05, 2001 at 11:05:29AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I give you 16 SMP systems, each with 4 processors and a gigabit
> ethernet card, and connect those ethers through a switch, would that
> be sufficient hardware?

You've completely misunderstood the message, sorry, I must not have been clear.
What I am proposing is to cluster *OS* images on a *single* SMP as a way of
avoiding most of the locks necessary to scale up a single OS image on the 
same number of CPUs.

It has nothing to do with clustering more than one system, it's not that kind
of clustering.  It's clustering OS images.  

To make it easy, let's imagine you have a 16 way SMP box and an OS image that
runs well on one CPU.  Then a ccCluster would be 16 OS images, each running
on a different CPU, all on the same hardware.

DEC has done this, Sun has done this, IBM has really done this, but what none
of them have done is make mmap() work across OS boundaries.  If all OS images
could share the same page cache, that's a first order approximation of an 
16-way SMP OS with out all the locking.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
