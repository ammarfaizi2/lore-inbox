Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272182AbRIEO0l>; Wed, 5 Sep 2001 10:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272187AbRIEO0b>; Wed, 5 Sep 2001 10:26:31 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:43538 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S272182AbRIEO0T>; Wed, 5 Sep 2001 10:26:19 -0400
Message-Id: <200109051426.f85EQTpp012483@pincoya.inf.utfsm.cl>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress 
In-Reply-To: Message from "Grover, Andrew" <andrew.grover@intel.com> 
   of "Tue, 04 Sep 2001 14:52:17 MST." <4148FEAAD879D311AC5700A0C969E89006CDE0E2@orsmsx35.jf.intel.com> 
Date: Wed, 05 Sep 2001 10:26:28 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" <andrew.grover@intel.com> said:

[...]

> Here's Linux:
> 
> Drivers (SMP agnostic)

The SMP/UP difference is pervasive in Linux, I don't think there is a
single SMP-agnostic driver (as far as _binaries_ go). Source is mostly
SMP-agnostic.

> Kernel (SMP/UP specific)
> 
> Here's Windows:
> 
> Drivers (SMP agnostic)
> Kernel (SMP agnostic)
> HAL (SMP/UP specific, contains locking primitive funcs etc.)
> 
> So they use the same kernel and just switch out the HAL.

And each SMP/UP aware operation _has_ to be a separate function (no inlines
allowed this way). Doable with not too much overhead, AFAICS (at least in
principle); but maintaining (and synchronizing) a clean split will soon be
a nightmare. Or end up in two separate kernels anyway ;-)

[...]

> For one thing, it would get rid of the hundreds of "#ifdef CONFIG_SMP"s in
> the kernel. ;-)

At least the #ifdef's isolate just the places that must be different in
both cases. It might be worthwhile to abstract them out from the source
(not necesarily from the binary kernel).
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
