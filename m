Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUIORiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUIORiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUIORhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:37:17 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:27610 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267232AbUIORgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:36:19 -0400
Message-Id: <200409151736.i8FHa7lx026449@localhost.localdomain>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses.. 
In-Reply-To: Message from =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> 
   of "Wed, 15 Sep 2004 18:54:50 +0200." <20040915165450.GD6158@wohnheim.fh-wedel.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Wed, 15 Sep 2004 13:36:07 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> said:
> On Wed, 15 September 2004 09:30:42 -0700, Linus Torvalds wrote:

[...]

> > For example, if you don't know (or, more importantly - don't care) what 
> > kind of IO interface you use, you can now do something like
> > 
> > 	void __iomem * map = pci_iomap(dev, bar, maxbytes);
> > 	...
> > 	status = ioread32(map + DRIVER_STATUS_OFFSET);

> C now supports pointer arithmetic with void*?

It doesn't. It's a gcc-ism.

>                                               I hope the width of a
> void is not architecture dependent, that would introduce more subtle
> bugs.

gcc takes it as a char pointer for such uses.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
