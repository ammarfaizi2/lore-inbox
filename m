Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318883AbSHEVJN>; Mon, 5 Aug 2002 17:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318892AbSHEVJN>; Mon, 5 Aug 2002 17:09:13 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:12970 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318883AbSHEVJM>; Mon, 5 Aug 2002 17:09:12 -0400
Date: Mon, 5 Aug 2002 22:10:39 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
Message-ID: <20020805221039.A8692@kushida.apsleyroad.org>
References: <Pine.LNX.4.44.0208041131380.10314-100000@home.transmeta.com> <200208041530.24661.frankeh@watson.ibm.com> <15694.44775.232380.718847@napali.hpl.hp.com> <200208051321.15368.frankeh@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208051321.15368.frankeh@watson.ibm.com>; from frankeh@watson.ibm.com on Mon, Aug 05, 2002 at 01:21:15PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> The wording was "significant" benefits.  The point is/was that as your
> associativity goes up, the likelihood of full cache occupancy
> increases, with cache thrashing in each class decreasing.
> Would have to dig through the literature to figure out at what point 
> the benefits are insignificant (<1 %) wrt page coloring.

One of the benefits of page colouring may be that a program's run time
may be expected to vary less from run to run?

In the old days (6 years ago), I found that a video game I was working
on would vary in its peak frame rate by about 3-5% (I don't recall
exactly).  Once the program was started, it would remain operating at
the peak frame rate it had selected, and killing and restarting the
program didn't often make a difference either.  In DOS, the same program
always ran at a consistent frame rate (higher than Linux as it happens).
The actual number of objects executing in the program, and the amount of
memory allocated, were deterministic in these tests.

This is pointing at a cache colouring issue to me -- although quite
which cache I am not sure.  I suppose it could have been something to do
with Linux' VM page scanner access patterns into the page array instead.

-- Jamie
