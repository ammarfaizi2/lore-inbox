Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129071AbQKFMIS>; Mon, 6 Nov 2000 07:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129346AbQKFMH6>; Mon, 6 Nov 2000 07:07:58 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:41990 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129071AbQKFMHz>; Mon, 6 Nov 2000 07:07:55 -0500
Message-Id: <200011061206.eA6C6Lw05318@pincoya.inf.utfsm.cl>
To: Michael Meissner <meissner@spectacle-pond.org>
cc: Russ Allbery <rra@stanford.edu>, Tim Riker <Tim@Rikers.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?) 
In-Reply-To: Message from Michael Meissner <meissner@spectacle-pond.org> 
   of "Sat, 04 Nov 2000 03:40:02 CDT." <20001104034002.A26612@munchkin.spectacle-pond.org> 
Date: Mon, 06 Nov 2000 09:06:21 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Meissner <meissner@spectacle-pond.org> said:

[...]

> Now people seem to be advocating moving the kernel to use features from C99
> that haven't even been coded yet (which mean when coded using the latest
> codegen as well).  Note, I seriously doubt Linus will want a flag day (ie,
> after a given kernel release, you must use revision n of the compiler, but
> before that release, you must use revision n-1 of the compiler), so you still
> have to maintain support for the old GCC way of doing things, in addition to
> the C99 way of doing things probably for a year or so.

The recommended compiler is changing, it is now up to egcs-1.1.2. There is
a long lag, to be sure.

In any case, C99 _will_ come, so it is worthwhile to rewrite gcc-isms that
C99 does differently and egcs-1.1.2 supports *if* it doesn't impose a
penalty of some other sort. The point is that many gcc extensions are
poorly documented and moreover their semantics have changed over time (The
kernel is one of the main users of gcc extensions, other software has to
cater for being compiled with other compilers, and is thus more restricted
here. I'd guess glibc is second here. Little used extensions tend to be
broken or wobbly.). C99 is well documented, but the implementation of its
features might not be solid yet...

Named structure initializers and varargs macros come to mind. The code
should also be checked for possible use of restrict parameters.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
