Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277247AbRJLG0m>; Fri, 12 Oct 2001 02:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277253AbRJLG0c>; Fri, 12 Oct 2001 02:26:32 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:63498 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S277252AbRJLG0U>;
	Fri, 12 Oct 2001 02:26:20 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15302.36122.167106.102639@cargo.ozlabs.ibm.com>
Date: Fri, 12 Oct 2001 16:26:34 +1000 (EST)
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Paul.McKenney@us.ibm.com (Paul McKenney),
        andrea@suse.de (Andrea Arcangeli), frival@zk3.dec.com (Peter Rival),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky), Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        rth@twiddle.net (Richard Henderson), cardoza@zk3.dec.com,
        woodward@zk3.dec.com
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with
In-Reply-To: <200110120543.f9C5hvZ224264@saturn.cs.uml.edu>
In-Reply-To: <OF206EE8AA.7A83A16B-ON88256AE1.005467E3@boulder.ibm.com>
	<200110120543.f9C5hvZ224264@saturn.cs.uml.edu>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:

> This looks an awful lot like the PowerPC architecture.
> 
> In an SMP system, one would most likely mark pages as
> requiring coherency. This means that stores to a memory
> location from multiple processors will give sane results.
> Ordering is undefined when multiple memory locations are
> involved.

The current PowerPC Architecture spec actually has a paragraph that
says that where a processor does two loads and the second load depends
on the first (i.e. the result from the first load is used in computing
the address for the second load), that they have to be performed in
program order with respect to other processors.  In other cases you do
need a barrier as you say.

This constraint has evidently been added since the original PPC
architecture book was published.  I strongly doubt that any of the
older PPC implementations would violate that constraint though.

Paul.
