Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312375AbSDSLqp>; Fri, 19 Apr 2002 07:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312395AbSDSLqo>; Fri, 19 Apr 2002 07:46:44 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:13516 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S312375AbSDSLqn>;
	Fri, 19 Apr 2002 07:46:43 -0400
Date: Fri, 19 Apr 2002 13:46:35 +0200
From: David Weinehall <tao@acc.umu.se>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables
Message-ID: <20020419134635.D22790@khan.acc.umu.se>
In-Reply-To: <1589.1019123186@ocs3.intra.ocs.com.au> <1589.1019123186@ocs3.intra.ocs.com.au> <20020418135931.GU21206@holomorphy.com> <8N7App8mw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 08:16:00PM +0200, Kai Henningsen wrote:
> wli@holomorphy.com (William Lee Irwin III)  wrote on 18.04.02 in <20020418135931.GU21206@holomorphy.com>:
> 
> > On Thu, Apr 18, 2002 at 07:46:26PM +1000, Keith Owens wrote:
> > > The use of __init and __exit sections breaks the assumption that tables
> > > such as __ex_table are sorted, it has already broken the dbe table in
> > > mips on 2.5.  This patch against 2.5.8 adds a generic sort routine and
> > > sorts the i386 exception table.
> > > This sorting needs to be extended to several other tables, to all
> > > architectures, to modutils (insmod loads some of these tables for
> > > modules) and back ported to 2.4.  Before I spend the rest of the time,
> > > any objections?
> >
> > It doesn't have to be an O(n lg(n)) method but could you use something
> > besides bubblesort? Insertion sort, selection sort, etc. are just as
> > easy and they don't have the horrific stigma of being "the worst sorting
> > algorithm ever" etc.
> 
> Surely the worst (working) sort is randomsort? (Check if sorted. If not,  
> pick two entries at random, exchange, retry.)

I've always been a fan of bit-decay sort.

while (!sorted(data))
	;


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
