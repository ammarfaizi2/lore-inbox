Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbRFCCOR>; Sat, 2 Jun 2001 22:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262733AbRFCCOH>; Sat, 2 Jun 2001 22:14:07 -0400
Received: from dsl-dt-208-38-4-i185-cgy.nucleus.com ([208.38.4.185]:17417 "EHLO
	skaro.l-w.net") by vger.kernel.org with ESMTP id <S262731AbRFCCNy>;
	Sat, 2 Jun 2001 22:13:54 -0400
Date: Sat, 2 Jun 2001 20:13:43 -0600 (MDT)
From: <lost@l-w.net>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Andries.Brouwer@cwi.nl, dean-list-linux-kernel@arctic.org,
        jcwren@jcwren.com, linux-kernel@vger.kernel.org
Subject: Re: select() - Linux vs. BSD
In-Reply-To: <20010602234640.A1290@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.21.0106021956420.12813-100000@skaro.l-w.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jun 2001, Jamie Lokier wrote:

> lost@l-w.net wrote:
> > Of course, not looking at the sets upon a zero return is a fairly obvious
> > optimization as there is little point in doing so.
> 
> No; a fairly obvious optimisation is to avoid calling FD_ZERO if you
> can clear the bits individually when you test them.

That would make sense. HOWEVER, you took my comment out of context. I had
pointed out that since the zero return from select() is not an error
condition, you can rely on the sets being zeroed out. The zero simply
indicates that no descriptors had anything interesting occur and if the
sets are not zeroed, the implementation is broken. Upon error, the values
are undefined and the value of timeout is undefined. (In this case, doing
nothing upon a zero return from select() is perfectly reasonable.)

If I recall, the original posting was about whether the sets were zeroed
upon an error condition which a timeout is not defined as in this case.


William Astle
finger lost@l-w.net for further information

Geek Code V3.12: GCS/M/S d- s+:+ !a C++ UL++++$ P++ L+++ !E W++ !N w--- !O
!M PS PE V-- Y+ PGP t+@ 5++ X !R tv+@ b+++@ !DI D? G e++ h+ y?

