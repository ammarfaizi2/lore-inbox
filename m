Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbSJAPYU>; Tue, 1 Oct 2002 11:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbSJAPYU>; Tue, 1 Oct 2002 11:24:20 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:26779 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261745AbSJAPYT>;
	Tue, 1 Oct 2002 11:24:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Richard.Zidlicky@stud.informatik.uni-erlangen.de, zippel@linux-m68k.org
Subject: Re: 2.4 mm trouble [possible lru race]
Date: Tue, 1 Oct 2002 17:29:00 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <200210011420.QAA13868@faui02b.informatik.uni-erlangen.de>
In-Reply-To: <200210011420.QAA13868@faui02b.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wOxJ-0005uR-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 16:20, Richard.Zidlicky@stud.informatik.uni-erlangen.de wrote:
> > 
> > The theoretical lru race possibly spotted in the wild...
> > 
> > >
> > > Now I am wondering if that is just coincidence or why m68k hit that 
> > > error so reliably.. is it supposed to have any effect at all on
> > > UP?
> > 
> > Are you running UP+preempt?
> 
> no preempt or anything fancy, m68k vanila 2.4.19 (well almost).

Vanilla would be CONFIG_SMP=y, is that what you have?  Otherwise please
disregard the post just above (which hasn't appeared on the list yet)
because spin_lock/unlock would be null, and the tests I suggested would
have no effect.

We would then be left with a *very* small number of candidates, which
we will test in accordance with the "what remains must be the truth"
principle.

-- 
Daniel
