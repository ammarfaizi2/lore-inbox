Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278284AbRJMMp6>; Sat, 13 Oct 2001 08:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278283AbRJMMpt>; Sat, 13 Oct 2001 08:45:49 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:21001 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S278288AbRJMMpk>;
	Sat, 13 Oct 2001 08:45:40 -0400
Message-Id: <200110131245.f9DCjiu6025245@sleipnir.valparaiso.cl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: Message from Jeff Garzik <jgarzik@mandrakesoft.com> 
   of "Fri, 12 Oct 2001 20:09:38 EST." <Pine.LNX.3.96.1011012200821.1405A-100000@mandrakesoft.mandrakesoft.com> 
Date: Sat, 13 Oct 2001 08:45:43 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> said:
> On Fri, 12 Oct 2001, Horst von Brand wrote:
> > Jeff Garzik <jgarzik@mandrakesoft.com> said:
> > > We must consider the case where the kernel is built, and then a random
> > > 3rd party module comes along that needs crc32 features.  An ar library
> > > won't cut it, and neither will [the existing crc32 method of] patching
> > > linux/lib/crc32.c.  That leaves (a) unconditionally building it into the
> > > kernel, or (b) Makefile and Config.in rules.

> > (b) won't work if my kernel has no CRC32 modules, and a random 3rd party
> > module needs it. So it looks like firm builtin is the only real option (a).

> Sure it will.  (b) not only will work, but it is the preferred option.

3rd party module, added _after_ the fact?

In any case, either this stuff is small (so adding it into the base kernel
is no big deal if needed somewhere) or it is large (in which case the
overhead of a module is no big deal). I'd vote for using the existing
infrastructure for handling transient code/data if needed, not adding yet
another scheme with refcounting &c just for this particular use.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
