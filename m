Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUGHRQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUGHRQl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 13:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbUGHRQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 13:16:41 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57299 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264726AbUGHRQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 13:16:31 -0400
Message-Id: <200407081716.i68HGPNr012538@eeyore.valparaiso.cl>
To: tom st denis <tomstdenis@yahoo.com>
cc: Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org
Subject: Re: 0xdeadbeef vs 0xdeadbeefL 
In-Reply-To: Message from tom st denis <tomstdenis@yahoo.com> 
   of "Wed, 07 Jul 2004 11:41:50 MST." <20040707184150.76132.qmail@web41109.mail.yahoo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Thu, 08 Jul 2004 13:16:25 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tom st denis <tomstdenis@yahoo.com> said:
> --- Gabriel Paubert <paubert@iram.es> wrote:

[...]

> > On many platforms a "plain" char is unsigned. You can't write
> > portable
> > code without knowing this.
> 
> Um, actually "char" like "int" and "long" in C99 is signed.

Nope. char is either an unsigned char or a signed char, which one is up to
the implementation, and the three types are distinct. The signed keyword
was introduced exactly for the corner case of an explicitly signed (not
unsigned, and not maybe signed) char.

>                                                             So while
> you can write 
> 
> signed int x = -3;
> 
> You don't have to.  in fact if you "have" to then your compiler is
> broken.  Now I know that GCC offers "unsigned chars" but that's an
> EXTENSION not part of the actual standard.  

Not an extension, in C for ever and ever.

> You ought to distinguish "what my compiler does" with "what the
> standard actually says".  If you want unsigned chars don't be lazy,
> just write "unsigned char".  

Right. Look at the standard, and then go back and rewrite to agree with C99
all the "standard conforming" C you have written. Should keep you away from
LKML for a while...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
