Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbTCMV4r>; Thu, 13 Mar 2003 16:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262603AbTCMV4r>; Thu, 13 Mar 2003 16:56:47 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:38062 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262596AbTCMVzj>;
	Thu, 13 Mar 2003 16:55:39 -0500
Message-Id: <200303132104.h2DL4TKf005825@eeyore.valparaiso.cl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63)) 
In-Reply-To: Your message of "Wed, 12 Mar 2003 23:03:20 +0100."
             <Pine.LNX.4.30.0303122255270.18833-100000@divine.city.tvnet.hu> 
Date: Thu, 13 Mar 2003 17:04:29 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szakacsits Szabolcs <szaka@sienet.hu> said:
> On Wed, 12 Mar 2003, Horst von Brand wrote:
> > It is _hard_ to do with variable length instructions (CISC, remember?), the
> > code is designed to be easily decoded forward, noone executes code going
> > backwards.

> Of course, it's a bad approach. You start earlier and stop at EIP.
> Repeat this for max(instruction length) different offsets and you will
> have the winner. Figure it out from the context after EIP.

By hand, OK. Automatically, no.

> > When I needed to look at the code in an Oops I'd either objdump(1)ed it or
> > compiled the offending stuff to assembler (possibly with custom CFLAGS to
> > get info on line numbers and such in the output).

> I was talking about cases when you can't do these.

I did this to find out where in the source it went south, and then look
around to find out why. A copy of that kernel's source is required anyway.

If you can divine the breakage just from the asm, more power to you. For us
mere mortals it isn't enough.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
