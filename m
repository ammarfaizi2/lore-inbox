Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314442AbSDRUUa>; Thu, 18 Apr 2002 16:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314444AbSDRUU3>; Thu, 18 Apr 2002 16:20:29 -0400
Received: from waste.org ([209.173.204.2]:52368 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S314442AbSDRUU2>;
	Thu, 18 Apr 2002 16:20:28 -0400
Date: Thu, 18 Apr 2002 15:20:17 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 2.5.8 sort kernel tables
In-Reply-To: <20020418135931.GU21206@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0204181507150.8537-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002, William Lee Irwin III wrote:

> On Thu, Apr 18, 2002 at 07:46:26PM +1000, Keith Owens wrote:
> > The use of __init and __exit sections breaks the assumption that tables
> > such as __ex_table are sorted, it has already broken the dbe table in
> > mips on 2.5.  This patch against 2.5.8 adds a generic sort routine and
> > sorts the i386 exception table.
> > This sorting needs to be extended to several other tables, to all
> > architectures, to modutils (insmod loads some of these tables for
> > modules) and back ported to 2.4.  Before I spend the rest of the time,
> > any objections?
>
> It doesn't have to be an O(n lg(n)) method but could you use something
> besides bubblesort? Insertion sort, selection sort, etc. are just as
> easy and they don't have the horrific stigma of being "the worst sorting
> algorithm ever" etc.

Combsort is a trivial modification of bubblesort that's O(n log(n)).

 http://cs.clackamas.cc.or.us/molatore/cs260Spr01/combsort.htm

Though we should probably just stick a simple qsort in the library
somewhere.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

