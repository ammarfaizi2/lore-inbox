Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130646AbRCIWaC>; Fri, 9 Mar 2001 17:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130721AbRCIW3v>; Fri, 9 Mar 2001 17:29:51 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:46094 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S130649AbRCIW3q>; Fri, 9 Mar 2001 17:29:46 -0500
Date: Fri, 9 Mar 2001 15:29:02 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: quicksort for linked list
Message-ID: <20010309152902.A1219@mail.harddata.com>
In-Reply-To: <3AA89624.46DBADD7@idb.hist.no> <200103091152.MAA31645@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
In-Reply-To: <200103091152.MAA31645@cave.bitwizard.nl>; from Rogier Wolff on Fri, Mar 09, 2001 at 12:52:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2001 at 12:52:22PM +0100, Rogier Wolff wrote:
> 
> Quicksort however is an algorithm that is recursive. This means that
> it can use unbounded amounts of stack -> This is not for the kernel.

Well, not really in this situation, after a simple modification.  It is
trivial to show that using "shorter interval sorted first" approach one
can bound an amount of an extra memory, on stack or otherwise, and by a
rather small number.  This assumes that one knows what one is sorting -
which is obviously the case here.

Also my copy of Reingold, Nivergelt, Deo from 1977 presents a
"non-recursive" variant of quicksort as a kind of an "old hat" solution.
One would think that this piece of information would spread during those
years. :-)  It is a simple exercise anyway.

> Quicksort has a very bad "worst case": quadratic sort-time. Are you
> sure this won't happen?

This is much more serious objection.  You can nearly guarantee in an
itended application that somebody will find a way to feed you packets
which will ensure the worst case behaviour.  The same gotcha will
probably kill quite a few other ways to sort here.

  Michal
