Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284710AbRLEVEK>; Wed, 5 Dec 2001 16:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284728AbRLEVDj>; Wed, 5 Dec 2001 16:03:39 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24057 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284729AbRLEVD0>; Wed, 5 Dec 2001 16:03:26 -0500
Date: Wed, 05 Dec 2001 13:02:24 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Larry McVoy <lm@bitmover.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Lars Brinkhoff <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
Message-ID: <2534997012.1007557344@mbligh.des.sequent.com>
In-Reply-To: <20011205111115.T11801@work.bitmover.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If I give you 16 SMP systems, each with 4 processors and a gigabit
>> ethernet card, and connect those ethers through a switch, would that
>> be sufficient hardware?
> 
> You've completely misunderstood the message, sorry, I must not have been clear.

Oops ... that's twice now ;-) Maybe I'm reading it with too many preconceived
notions of what you're doing from conversations I've had with other people
about ccClusters. I'll try to do a mental reset, and start from a clean slate.

> What I am proposing is to cluster *OS* images on a *single* SMP as a way of
> avoiding most of the locks necessary to scale up a single OS image on the 
> same number of CPUs.

Which, to me, makes the whole thing much less interesting, since there aren't
SMP systems about that are really large that I know of anyway. Scaling to 
the size of current SMP systems is a much less difficult problem than scaling
to the size of NUMA systems.

BUT ... much of the rest of the message I sent you still applies anyway.
You can create virtual "pools" or "resource domains" within an SMP system
in the same way nodes exist on NUMA and work from the starting point of
a single OS image, instead of multiple.

The main advantage of starting with a single OS image, as I see it, is
that you have a system that works fine, but performs badly, from the
outset. Makes it easier to do development on - that's where I have the
NUMA-Q platform at the moment - it thinks it's an SMP box.

Martin.

