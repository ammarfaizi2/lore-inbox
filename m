Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314555AbSDSE7l>; Fri, 19 Apr 2002 00:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314557AbSDSE7l>; Fri, 19 Apr 2002 00:59:41 -0400
Received: from ftoomsh.progsoc.uts.edu.au ([138.25.6.1]:28691 "EHLO ftoomsh")
	by vger.kernel.org with ESMTP id <S314555AbSDSE7k>;
	Fri, 19 Apr 2002 00:59:40 -0400
Date: Fri, 19 Apr 2002 14:59:37 +1000
From: Matt <matt@progsoc.uts.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables
Message-ID: <20020419145937.U12501@progsoc.uts.edu.au>
In-Reply-To: <20020418135931.GU21206@holomorphy.com> <Pine.LNX.4.44.0204181507150.8537-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-OperatingSystem: Linux ftoomsh 2.2.15-pre13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 03:20:17PM -0500, Oliver Xymoron wrote:
> On Thu, 18 Apr 2002, William Lee Irwin III wrote:

>> On Thu, Apr 18, 2002 at 07:46:26PM +1000, Keith Owens wrote:

>>> The use of __init and __exit sections breaks the assumption that
>>> tables such as __ex_table are sorted, it has already broken the
>>> dbe table in mips on 2.5.  This patch against 2.5.8 adds a generic
>>> sort routine and sorts the i386 exception table.  This sorting
>>> needs to be extended to several other tables, to all
>>> architectures, to modutils (insmod loads some of these tables for
>>> modules) and back ported to 2.4.  Before I spend the rest of the
>>> time, any objections?

>> It doesn't have to be an O(n lg(n)) method but could you use
>> something besides bubblesort? Insertion sort, selection sort,
>> etc. are just as easy and they don't have the horrific stigma of
>> being "the worst sorting algorithm ever" etc.

> Combsort is a trivial modification of bubblesort that's O(n log(n)).

>  http://cs.clackamas.cc.or.us/molatore/cs260Spr01/combsort.htm

> Though we should probably just stick a simple qsort in the library
> somewhere.

but isn't qsort's worst case behaviour for an already sorted list? i
cant remember how bad it is but i thought it was like O(n^2) for worst
case, ie just as bad as bubble sort..

	matt
