Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267438AbTBDUC1>; Tue, 4 Feb 2003 15:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTBDUC1>; Tue, 4 Feb 2003 15:02:27 -0500
Received: from [81.2.122.30] ([81.2.122.30]:18441 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267443AbTBDUC0>;
	Tue, 4 Feb 2003 15:02:26 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302042011.h14KBuG6002791@darkstar.example.net>
Subject: Re: gcc 2.95 vs 3.21 performance
To: davej@codemonkey.org.uk (Dave Jones)
Date: Tue, 4 Feb 2003 20:11:56 +0000 (GMT)
Cc: john@grabjohn.com, wookie@osdl.org, vda@port.imtp.ilyichevsk.odessa.ua,
       root@chaos.analogic.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <20030204194459.GC6417@codemonkey.org.uk> from "Dave Jones" at Feb 04, 2003 07:44:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Maybe we should create a KGCC fork, optimise it for kernel
>  > complilations, then try to get our changes merged back in to GCC
>  > mainline at a later date.
> 
> What exactly do you mean by "optimise for kernel compilations" ?

I don't, that was a bad way of phrasing it - I didn't mean fork GCC
just to create one which compiles the kernel so it runs faster, as the
expense of other code.

What I was thinking was that if we forked GCC, we could try out all of
these ideas that have been floating around in this thread, and if, as
was hinted at earlier in this thread, $bigcompanies[] have not offered
contributions because of reluctance to accept them by the GCC team, we
would be more in a position to try them out, because we only need to
concern ourselves with breaking the compilation of the kernel, not
every single program that currently compiles with GCC.

The way I see it, the development series would be optimised for KGCC,
and when we start to think about stabilising that development series,
we try to get our KGCC changes merged back in to GCC mainline.  If
they are not accepted, either KGCC becomes the recommended kernel
compiler, which should cause no great difficulties, (having one
compiler for kernels, and one for userland applications), or we start
making sure that we haven't broken compilation with GCC, (and since a
there would probably always be people compiling with GCC anyway, even
if there was a KGCC, we would effectively always know if we broke
compilation with GCC), and then the recommended compiler is just not
the optimal one, and it would be up to the various distributions to
decide which one they are going to use.

John.
