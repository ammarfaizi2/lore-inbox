Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVJCN2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVJCN2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 09:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVJCN2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 09:28:52 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:64965 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932183AbVJCN2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 09:28:51 -0400
Message-Id: <200510030212.j932CcKT025910@laptop11.inf.utfsm.cl>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: Vadim Lobanov <vlobanov@speakeasy.net>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Message from Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
   of "Mon, 03 Oct 2005 01:54:00 +0100." <20051003005400.GM6290@lkcl.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 02 Oct 2005 22:12:38 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 03 Oct 2005 09:28:16 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Sun, Oct 02, 2005 at 04:37:52PM -0700, Vadim Lobanov wrote:
> > >  what if, therefore, someone comes up with an architecture that is
> > >  better than or improves greatly upon SMP?

> > Like NUMA?

>  yes, like numa, and there is more.
> 
>  i had the honour to work with someone who came up with a radical
>  enhancement even to _that_.

Any papers to look at?

>  basically the company has implemented, in hardware (a nanokernel),

A nanokernel is a piece of software in my book?

>                                                                     some
>  operating system primitives, such as message passing (based on a
>  derivative by thompson of the "alice" project from plessey, imperial and
>  manchester university in the mid-80s), hardware cache line lookups
>  (which means instead of linked list searching, the hardware does it for
>  you in a single cycle), stuff like that.

Single CPU cycle for searching data in memory? Impossible.

>  the message passing system is designed as a parallel message bus -
>  completely separate from the SMP and NUMA memory architecture, and as
>  such it is perfect for use in microkernel OSes.

Something must shuffle the data from "regular memory" into "message
memory", so I bet that soon becomes the bottleneck. And the duplicate data
paths add to the cost, money that could be spent on making memory access
faster, so...

>  (these sorts of things are unlikely to make it into the linux kernel, no
>  matter how much persuasion and how many patches they would write).

Your head would apin when looking at how fast this gets into Linux if there
were such machines around, and it is worth it.

>  _however_, a much _better_ target would be to create an L4 microkernel
>  on top of their hardware kernel.

Not yet another baroque CISC design, this time around with 1/3 of an OS in
it!

>  this company's hardware is kinda a bit difficult for most people to get
>  their heads round: it's basically parallelised hardware-acceleration for
>  operating systems, and very few people see the point in that.

Perhaps most people that don't see the point do have a point?

>  however, as i pointed out, 90nm and approx-2Ghz is pretty much _it_,
>  and to get any faster you _have_ to go parallel.

Sorry, all this has been doomsayed (with different numbers) from 1965 or
so.

>  and the drive for "faster", "better", "more sales" means more and more
>  parallelism.

Right.

>  it's _happening_ - and SMP ain't gonna cut it (which is why
>  these multi-core chips are coming out and why hyperthreading
>  is coming out).

Hyperthreading and multi-core /are/ SMP, just done a bit differently.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
