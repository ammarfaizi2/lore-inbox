Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278965AbRJ2C6R>; Sun, 28 Oct 2001 21:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278966AbRJ2C6G>; Sun, 28 Oct 2001 21:58:06 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:40967 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S278965AbRJ2C5v>;
	Sun, 28 Oct 2001 21:57:51 -0500
Message-Id: <200110290143.f9T1he1U001054@sleipnir.valparaiso.cl>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sysenter support 
In-Reply-To: Message from Manfred Spraul <manfred@colorfullife.com> 
   of "Sun, 28 Oct 2001 11:02:35 BST." <3BDBD7BB.F7BE06D0@colorfullife.com> 
Date: Sun, 28 Oct 2001 22:43:40 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> said:
> I've added sysenter/sysexit support for all syscalls with up to 4
> parameters.

[...]

> sysenter is supported by AMD K7 and Intel Pentium II and later.

How will glibc/random executable know? Keep both around forever?

> Result: simple syscall (getpid()) more than 35% faster.
> 
> before: 295 cpu ticks
> now: 186 cpu ticks.

IMVHO, the difference will be swamped by "real" work in the relevant cases.
We'd need a _clean_ upgrade path (there are _still_ i386s around; on an
Installfest yesterday a couple of i486s finally saw the light... and they
are ample machines for their intended uses BTW).  AFAIKS you will need to
be able to run an i686 glibc on an i386 (install!) kernel of a random
distribution for quite some time to come.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
