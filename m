Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261964AbTCQVtR>; Mon, 17 Mar 2003 16:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261968AbTCQVtR>; Mon, 17 Mar 2003 16:49:17 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:17163 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261964AbTCQVtQ>; Mon, 17 Mar 2003 16:49:16 -0500
Message-Id: <200303172159.h2HLxsQY025585@pincoya.inf.utfsm.cl>
To: Tommy Reynolds <reynolds@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Demand paging - Kernel 
In-reply-to: Your message of "Mon, 17 Mar 2003 08:35:47 CST."
             <20030317083547.51a4004f.reynolds@redhat.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Mon, 17 Mar 2003 17:59:54 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommy Reynolds <reynolds@redhat.com> said:
> Uttered "Breno" <brenosp@brasilsec.com.br>, spoke thus:
> > There is a possibility  to do demand paging in kernel space address ?

> No.  The entire kernel, and all  of its data structures, are resident in
> memory  all of  the time.

In the current Linux kernel, that is.
 
>                            Kernel demand  paging is  not possible,

It is certainly possible (you could mark areas that don't contain currently
used stuff for pageout). It is extremely hairy to do right (just see the
mess with module loading/unloading, which is some of the same stuff, very
tamed).

>                                                                     not
> necessary and not implemented.

The cost of doing it right in a monolitic kernel would probably outweigh
the gains manyfold, and require massive redesign for Linux. In microkernels
it is a lot easier to do (but their performance sucks baby elephants
through straws, so they are moot :-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
