Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290575AbSAYGNr>; Fri, 25 Jan 2002 01:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290576AbSAYGNh>; Fri, 25 Jan 2002 01:13:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20195 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290573AbSAYGNW> convert rfc822-to-8bit;
	Fri, 25 Jan 2002 01:13:22 -0500
Date: Fri, 25 Jan 2002 01:13:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: timothy.covell@ashavan.org, Robert Love <rml@tech9.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <1011914865.2636.16.camel@bip>
Message-ID: <Pine.GSO.4.21.0201250109150.23657-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 Jan 2002, Xavier Bestel wrote:

> le sam 26-01-2002 à 00:09, Timothy Covell a écrit :
> > #include <stdio.h>
> > 
> > int main()
> > {
> >         char x;
> > 
> >         if ( x )
> >         {
> >                 printf ("\n We got here\n");
> >         }
> >         else
> >         {
> >                 // We never get here
> >                 printf ("\n We never got here\n");
> >         }
> >         exit (0);
> > }
> > covell@xxxxxx ~>gcc -Wall foo.c
> > foo.c: In function `main':
> > foo.c:17: warning: implicit declaration of function `exit'
> 
> I'm lost. What do you want to prove ? (Al Viro would say you just want
> to show you don't know C ;)
> And why do you think you never get there ?

I suspect that our, ah, Java-loving friend doesn't realize that '\0' is
a legitimate value of type char...

BTW, he's got a funny compiler - I would expect at least a warning about
use of uninitialized variable.

