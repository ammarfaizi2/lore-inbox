Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbRGEOlH>; Thu, 5 Jul 2001 10:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265239AbRGEOk5>; Thu, 5 Jul 2001 10:40:57 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24336 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265247AbRGEOku>; Thu, 5 Jul 2001 10:40:50 -0400
Date: Thu, 5 Jul 2001 16:40:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010705164046.S17051@athlon.random>
In-Reply-To: <20010704232816.B590@marvin.mahowi.de> <20010705162035.Q17051@athlon.random> <3B447B6D.C83E5FB9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B447B6D.C83E5FB9@redhat.com>; from arjanv@redhat.com on Thu, Jul 05, 2001 at 03:36:29PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 03:36:29PM +0100, Arjan van de Ven wrote:
> Andrea Arcangeli wrote:
> > 
> > On Wed, Jul 04, 2001 at 11:28:17PM +0200, Manfred H. Winter wrote:
> > > Hi!
> > >
> > > I tried to install kernel 2.4.6 with same configuration as 2.4.5, but
> > > booting failed with:
> > >
> > > kernel BUG at softirq.c:206!
> > 
> > do you have any problem with those patches applied?
> > 
> >         ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1/00_ksoftirqd-7
> >         ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1/00_softirq-fixes-4
> > 
> 
> Is there anything in here that fixes a Via/Cyrix specific bug ?

definitely not. The softirq.c:206 bug cannot be caused by any hardware
bug, unless the bug triggers memory corruption exactly in the
tasklet->state word (which sounds unlikely since different people
triggered the bug using different binary kernels that are unlikely to
allocate t->state exactly in the same place).

Andrea
