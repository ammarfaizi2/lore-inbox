Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVGKRSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVGKRSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVGKRRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:17:30 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41679 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261255AbVGKRQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:16:38 -0400
Message-Id: <200507111713.j6BHDUGd001817@laptop11.inf.utfsm.cl>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, Bryan Henderson <hbryan@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, bfields@fieldses.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: share/private/slave a subtree - define vs enum 
In-Reply-To: Message from Roman Zippel <zippel@linux-m68k.org> 
   of "Sun, 10 Jul 2005 21:14:08 +0200." <Pine.LNX.4.61.0507102047380.3728@scrub.home> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 11 Jul 2005 13:13:30 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 11 Jul 2005 13:13:37 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
> On Sun, 10 Jul 2005, Pekka Enberg wrote:

[...]

> > Would you please be so kind to define your criteria for things that
> > "need fixing" so we could see if can reach some sort of an agreement on
> > this. My list is roughly as follows:
> > 
> >   - Erroneous use of kernel API
> >   - Bad coding style
> >   - Layering violations
> >   - Duplicate code
> >   - Hard to read code

> I don't generally disagree with that, I just think that defines are not 
> part of that list.

Covered in "bad coding style" and "hard to read code", at least.

> Look, it's great that you do reviews, but please keep in mind it's the 
> author who has to work with code and he has to be primarily happy with, 
> so you don't have to point out every minor issue.

Wrong. The author has to work with the code, but there are much more people
that have to read it now and fix it in the future. It doesn't make sense
having everybody using their own indentation style, variable naming scheme,
and ways of defining constants. For better or worse, #define /is/ the
standard idiom (in kernel and elsewhere) to define constants in C. See also
<http://www.lysator.liu.se/c/ten-commandments.html>, particularly
comandment 8. And consider also the /spirit/ of Documentation/CodingStyle.

> Although it also differs between core and driver code, we don't have to be 
> that strict with driver code as longs as it "looks" ok and is otherwise 
> correct. The requirements for core kernel code are higher, but even here 
> defines are a well accepted language construct.

I'd rather ask for the higher requirements of authors of new code... not
demand, just ask.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
