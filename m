Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288996AbSA3JIP>; Wed, 30 Jan 2002 04:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288999AbSA3JIH>; Wed, 30 Jan 2002 04:08:07 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:25779 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288996AbSA3JH4>; Wed, 30 Jan 2002 04:07:56 -0500
Message-Id: <200201300907.g0U97icL001965@tigger.cs.uni-dortmund.de>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Note describing poor dcache utilization under high memory pressure 
In-Reply-To: Message from Daniel Phillips <phillips@bonn-fries.net> 
   of "Tue, 29 Jan 2002 13:33:57 +0100." <E16VXSX-0000AD-00@starship.berlin> 
Date: Wed, 30 Jan 2002 10:07:44 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> said:
> On January 29, 2002 12:54 pm, Helge Hafting wrote:
> > Momchil Velikov wrote:

[...]

> > > Umm, all the ptes af the parent ought to be made COW, no ?

> > Sure. But quite a few of them may be COW already, if the parent 
> > itself is a result of some earlier fork.

> Right, or if the parent has already forked at least one child.

But most of this will be lost on exec(2). Also, it is my impression that
the tree of _running_ processes isn't usually very deep (Say init --> X -->
[Random processes] --> [compilations &c], this would make 5 or 6 deep, no
more. Should take a pstree(1) listing on a busy machine and work out some
statistics... here (a personal worstation) the tree is very fat at the
first level below init(8), and just 5 deep when running pstree(1)). Sure,
all processes will all end up sharing glibc, and the graphical stuff will
share the X &c libraries, so this would end up being a win this way.
-- 
Horst von Brand			     http://counter.li.org # 22616
