Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSDDFeH>; Thu, 4 Apr 2002 00:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310214AbSDDFd6>; Thu, 4 Apr 2002 00:33:58 -0500
Received: from [24.84.50.235] ([24.84.50.235]:33797 "HELO
	mail.orbis-terrarum.net") by vger.kernel.org with SMTP
	id <S310190AbSDDFdo>; Thu, 4 Apr 2002 00:33:44 -0500
Date: Wed, 3 Apr 2002 21:34:59 -0800 (PST)
From: Robin Johnson <robbat2@fermi.orbis-terrarum.net>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in compiling 
In-Reply-To: <12691.1017832606@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.43.0204032116410.25829-100000@fermi.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Keith Owens wrote:
> On Wed, 3 Apr 2002 00:57:06 -0800 (PST),
> Robin Johnson <robbat2@fermi.orbis-terrarum.net> wrote:
> >While mass compiling a new kernel for my slew of systems, I had an unusual
> >problem
> >
> >gcc barfs and gives this huge error:
> >gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre4-ac3/include -Wall
> >-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> >-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> >-march=i686   -DKBUILD_BASENAME=exec_domain  -DEXPORT_SYMTAB -c
> >exec_domain.c
> >exec_domain.c:234: parse error before `register_exec_domain'
> >exec_domain.c:235: parse error before `unregister_exec_domain'
> >exec_domain.c:236: parse error before `__set_personality'
> >exec_domain.c:287: parse error before `abi_defhandler_coff'
> >...
>
> All EXPORT_SYMBOL.  You would get that behaviour if gcc did not
> recognise EXPORT_SYMBOL as a macro.  Probably random data corruption.
Of the pair of machines, I upgraded one of them to GCC 3.0.4, while
leaving the other at 2.95.3.

The identical source and config file compiles fine on the one, but not on
the other. It gives that exec_domain slew.c of errors.

So is this a GCC bug that I have located, or something more with the
kernel?, as Documentation/Changes lists GCC 2.95.3 at the minimal version
required.

I would like to avoid the GCC3 tree as it stands presently, as I have some
C++ code that can not be ported at this time to work with GCC3, and only
works with GCC2.95.3.

Any ideas?

Thanks in advance.

(Again, please CC replies to me as I am not subscribed to the list.)

-- 
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=people.robbat2
ICQ#       : 30269588 or 41961639

