Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbTBKJ3r>; Tue, 11 Feb 2003 04:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267337AbTBKJ3r>; Tue, 11 Feb 2003 04:29:47 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:54962 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267334AbTBKJ3q>; Tue, 11 Feb 2003 04:29:46 -0500
Message-Id: <200302110939.h1B9dX6T013616@eeyore.valparaiso.cl>
To: Andreas Schwab <schwab@suse.de>
cc: Art Haas <ahaas@airmail.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       brand@eeyore.valparaiso.cl
Subject: Re: Is -fno-strict-aliasing still needed? 
In-Reply-To: Your message of "Tue, 11 Feb 2003 10:12:31 +0100."
             <jebs1jcha8.fsf@sykes.suse.de> 
Date: Tue, 11 Feb 2003 10:39:33 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> said:
> Horst von Brand <brand@jupiter.cs.uni-dortmund.de> writes:
> 
> |> Art Haas <ahaas@airmail.net> said:
> |> > I ask because I've just built a kernel without using that flag -
> |> > linus-2.5 BK from this morning, probably missing the 2.5.60 release by
> |> > a few hours.
> |> 
> |> The problem with strict aliasing is that it allows the compiler to assume
> |> that in:
> |> 
> |>      void somefunc(int *foo, int *bar)
> |> 
> |> foo and bar will _*never*_ point to the same memory area
> 
> This is wrong.  Only if they are declared restrict.

... can they point to the same area. That is exactly the problem: If you do
nothing, the language definition assumes the programmer made sure (LOL!)
that they don't point the same way. That's why the flag is needed in the
first place, as nobody writes "restrict" all over the place. I got biten by
that when the optimizations (and the flag) were introduced into gcc (egcs
branch perhaps?).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
