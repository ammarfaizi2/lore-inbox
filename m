Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261484AbTCOSIZ>; Sat, 15 Mar 2003 13:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbTCOSIY>; Sat, 15 Mar 2003 13:08:24 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:10417 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261484AbTCOSIX>;
	Sat, 15 Mar 2003 13:08:23 -0500
Message-Id: <200303151502.h2FF2ai1002919@eeyore.valparaiso.cl>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Your message of "Thu, 13 Mar 2003 17:53:01 +0100."
             <20030313164905.9E1A6107776@mx12.arcor-online.net> 
Date: Sat, 15 Mar 2003 11:02:36 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> said:

[...]

> You confused semantic dependencies with structural dependencies that
> govern whether or not deltas conflict in the reject sense.  Detailed
> reply is off-list.

In both cases hand fixup is needed. The "overlapping patch" partial order
is a (small, or even very small) subset of the "depends on" partial order
which you really want. It would be nice to be able to get a much better
approximation than "conflicting patch" automatically, but I fail to see
how. Giving dependencies by hand is a possibility, but it will most of the
time give as bad an approximation as the above (Do you really know _all_
patches on which your latest and greatest depends? Some (or even most) of
them will be old patches, that by now will be just part of the general
landscape. And this can happen even with direct dependencies: Think of
"disabling IRQs doesn't ensure mutual exclusion" or some such pervasive
change that will affect a small part of any patch, and now move an old 
patch forward...).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
