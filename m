Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264004AbUDFUxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264007AbUDFUxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:53:30 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:15322 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264004AbUDFUxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:53:24 -0400
Message-Id: <200404062053.i36KrC3Y005111@eeyore.valparaiso.cl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: {put,get}_user() side effects 
In-Reply-To: Your message of "Tue, 06 Apr 2004 13:46:41 +0200."
             <Pine.GSO.4.58.0404061344390.4158@waterleaf.sonytel.be> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 06 Apr 2004 16:53:11 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> said:
> On Tue, 6 Apr 2004, Andi Kleen wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > > On most (all?) architectures {get,put}_user() has side effects:
> > >
> > > #define put_user(x,ptr)                                                 \
> > >   __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
> >
> > Neither typeof not sizeof are supposed to have side effects. If your
> > compiler generates them that's a compiler bug.

> From a simple compile test, you seem to be right... Weird, since it does
> expand to 3 times 'pIndex++', but pIndex is incremented only once.

Better check with a C language lawyer. Maybe gcc gets it wrong, or it is
undefined (in which case next gcc could screw you over, and give you a hard
time finding out how...). An inline should be safe, and unless gcc still
gets them wrong, equally fast/small.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
