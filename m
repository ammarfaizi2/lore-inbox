Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268197AbUHNIDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268197AbUHNIDw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 04:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268200AbUHNIDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 04:03:52 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:50910 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id S268197AbUHNIDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 04:03:46 -0400
Date: Sat, 14 Aug 2004 04:03:41 -0400 (EDT)
From: Hank Leininger <hlein@progressive-comp.com>
X-X-Sender: Hank Leininger <hlein@progressive-comp.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.26 OOPS in __kmem_cache_alloc
In-Reply-To: <200408141039.05915.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <010408140344290.12915@timmy.spinoli.org>
References: <010408121718530.12915@timmy.spinoli.org>
 <200408141039.05915.vda@port.imtp.ilyichevsk.odessa.ua>
X-Marks-The: Spot
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, 14 Aug 2004, Denis Vlasenko wrote:

> On Saturday 14 August 2004 06:43, Hank Leininger wrote:
> > The primary MARC server has been out of production for, oh, about
> >
> > [horror story abridged]
>
> Oh no.
>
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000021 *pde = 00000000
[snip]
> > Code;  c01f20fb <__kmem_cache_alloc+b/130>
> > 00000000 <_EIP>:
> > Code;  c01f20fb <__kmem_cache_alloc+b/130>   <=====
> >    0:   8b 5c 24 20               mov    0x20(%esp,1),%ebx   <=====
> > Code;  c01f20ff <__kmem_cache_alloc+f/130>
> >    4:   f7 c7 01 00 00 00         test   $0x1,%edi
> > Code;  c01f2105 <__kmem_cache_alloc+15/130>
> >    a:   0f 84 f5 00 00 00         je     105 <_EIP+0x105>
> > Code;  c01f210b <__kmem_cache_alloc+1b/130>
> >   10:   f6 43 30 01               testb  $0x1,0x30(%ebx)
>
> Strange. "Unable to handle kernel NULL pointer dereference
> at virtual address 00000021". But %esp == 0xd426ddf8
> and 0x20(%esp,1) == (%esp+0x20) != (0x00000021)....
> Hmmm. But _%ebp_ is equal to 00000001!
>
> I just checked: "8b 5c 24 20" is indeed "mov 0x20(%esp,1),%ebx",
> it's not a ksymoops bug...
>
> What kind of CPU do you use?

When that OOPS was taken, an Athlon XP 2500+ Barton.  The kernel is
still compiled for SMP (for when it was running with dual Athlon MP
2400+'s; that's where the second, old, less reliable OOPS occurred).

> Please send me your mm/slab.c and mm/slab.o (from
> the kernel build directory).

Sure (sent in a separate email off-list, to spare l-k, unless there is
more interest).

Thanks,

Hank Leininger <hlein@progressive-comp.com>
E407 AEF4 761E D39C D401  D4F4 22F8 EF11 861A A6F1
-----BEGIN PGP SIGNATURE-----

iD8DBQFBHcddIvjvEYYapvERAufTAJwInznww51XBpPi0/evrPgzinfBNQCfQqRY
mcAOrBxNWrs6nPPL/38Oei8=
=wevd
-----END PGP SIGNATURE-----
