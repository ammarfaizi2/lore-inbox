Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265207AbRFVBvq>; Thu, 21 Jun 2001 21:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265309AbRFVBv1>; Thu, 21 Jun 2001 21:51:27 -0400
Received: from CM-46-30.chello.cl ([24.152.46.30]:11655 "EHLO
	CM-46-30.chello.cl") by vger.kernel.org with ESMTP
	id <S265207AbRFVBvM>; Thu, 21 Jun 2001 21:51:12 -0400
Date: Thu, 21 Jun 2001 21:47:25 -0400 (CLT)
From: Fabian Arias <dewback@vtr.net>
To: Anatoly Ivanov <avi@levi.spb.ru>
cc: "Kissandrakis S. George" <kissand@phaistosnetworks.gr>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 and gcc v3 final
In-Reply-To: <3B3095FB.2060706@levi.spb.ru>
Message-ID: <Pine.LNX.4.21.0106212143320.9295-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've just applied the "patch", but te warning still appears. Is this
somthing not to be worried about or is it something serious?

/usr/src/linux-2.4.5/include/asm/checksum.h:161:17: warning: multi-line
string literals are deprecated

I had to come back to 2.95 to test the ac17. Not so happy about it. :(

Please give me some directions.

On Wed, 20 Jun 2001, Anatoly Ivanov wrote:

> Hi,
> 
> Solution is simple:
> change line 540 from "extern struct timeval xtime;"
> to "extern volatile struct timeval xtime;"
> and have fun :)
> 
> ---
> avi
> 
> Kissandrakis S. George wrote:
> 
> > Hello
> > I suppose that you allready know it
> > I have installed gcc v3 released Jun 18 and i tried to compile the
> > kernel and i got
> > these errors
> > 
> > in make dep i got several warnings that look like this
> > 
> > /usr/src/linux-2.4.5/include/asm/checksum.h:161:17: warning: multi-line
> > string literals are deprecated
> > 
> > but finally passed..
> > 
> > in make bzImage i got
> > 
> > timer.c:35: conflicting types for `xtime'
> > /usr/src/linux-2.4.5/include/linux/sched.h:540: previous declaration of
> > `xtime'
> > 
> > and compilation stops
> > if i remove the decleration of xtime in sched.h (remove the 540 line)
> > the compile
> > will go on and some compiles after...
> > 
> > time.c: In function `do_normal_gettime':
> > time.c:41: `xtime' undeclared (first use in this function)
> > 
> > and some other errors
> > if in time.c include the line 540 from sched.h (the xtime) the
> > compilation will go on
> > until the same error on another file
> > i include again the line 540 from sched.h the compilation goes on etc
> > etc and after lots
> > of errors finally i got bzImage
> > 
> > I didnt test bzImage if it boots 
> > 
> > with gcc v2.x the same kernel and kernel config it compiles,Is it a
> > kernel bug, a gcc
> > bug or something else (bad installation of gcc, my mistake etc etc)? 
> > 
> > Best Regards
> > 
> > 
> > --- 
> > Kissandrakis S. George                 [kissand@phaistosnetworks.gr]
> > Network and System Administrator       [http://www.phaistosnetworks.gr/]
> > Tel:(+30 81) 391882/Fax:(+30 892) 23206
> > Phaistos Networks S.A. - A DOL Digital Company
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

 ---
 Fabian Arias Mu~oz                    |               Debian GNU/Linux Sid
 Facultad de Cs. Economicas y          |      	Kernel 2.4.5ac16 - ReiserFS
 Administrativas.                      |                   "aka" dewback en
 Universidad de Concepcion   -  Chile  |               #linuxhelp IRC.CHILE

