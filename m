Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267283AbSLELPd>; Thu, 5 Dec 2002 06:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbSLELPd>; Thu, 5 Dec 2002 06:15:33 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6533 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S267283AbSLELPc>;
	Thu, 5 Dec 2002 06:15:32 -0500
Message-Id: <200212050010.gB50A0Ud001301@eeyore.valparaiso.cl>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: #! incompatible -- binfmt_script.c broken? 
In-Reply-To: Message from Matthias Andree <matthias.andree@gmx.de> 
   of "Wed, 04 Dec 2002 12:34:19 BST." <20021204113419.GA20282@merlin.emma.line.org> 
Date: Wed, 04 Dec 2002 21:10:00 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> said:
> I tried some of the Perl magic tricks shown in the perlrun man page with
> Linux 2.4.19; consider this Perl one-liner. It works on FreeBSD and
> Solaris, but fails on Linux. Looking at binfmt_script.c, I believe the
> "pass the rest of the line as the first argument to the interpreter" is
> the problem with Linux. Haven't yet figured if the other boxes just use
> the interpreter, ignoring the arguments or if they are doing argument
> splitting.
> 
> ------------------------------------------------------------------------
> #!/bin/sh -- # -*- perl -*- -T
> eval 'exec perl -wTS $0 ${1+"$@"}'
>   if 0; 
> print "Hello there.\n";
> ------------------------------------------------------------------------
> 

[...]

> SuSE Linux 7.0, 7.3, 8.1 (2.4.19 kernel, binfmt_script.c identical to
> 2.4.20 BK):
> $ /tmp/try.pl
> /bin/sh: -- # -*- perl -*- -T: invalid option
> Usage:  /bin/sh [GNU long option] [option] ...
>         /bin/sh [GNU long option] [option] script-file ...
> [...]

RH 8.0 with linux-2.5.50 (some early bk version, last CSET is 1.849) gives
the same.
--
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
