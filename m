Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290639AbSAYKyG>; Fri, 25 Jan 2002 05:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290635AbSAYKx4>; Fri, 25 Jan 2002 05:53:56 -0500
Received: from AMontpellier-201-1-1-52.abo.wanadoo.fr ([193.252.31.52]:29198
	"EHLO awak") by vger.kernel.org with ESMTP id <S290312AbSAYKxo> convert rfc822-to-8bit;
	Fri, 25 Jan 2002 05:53:44 -0500
Subject: Re: RFC: booleans and the kernel
From: Xavier Bestel <xavier.bestel@free.fr>
To: Momchil Velikov <velco@fadata.bg>
Cc: Alexander Viro <viro@math.psu.edu>, timothy.covell@ashavan.org,
        Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <877kq6amhe.fsf@fadata.bg>
In-Reply-To: <Pine.GSO.4.21.0201250109150.23657-100000@weyl.math.psu.edu> 
	<877kq6amhe.fsf@fadata.bg>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 25 Jan 2002 11:51:39 +0100
Message-Id: <1011955901.2270.20.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le ven 25-01-2002 à 09:00, Momchil Velikov a écrit :
> >>>>> "Alexander" == Alexander Viro <viro@math.psu.edu> writes:
> >> > int main()
> >> > {
> >> >         char x;
> >> > 
> >> >         if ( x )
> >> >         {
> >> >                 printf ("\n We got here\n");
> >> >         }
> >> >         else
> >> >         {
> >> >                 // We never get here
> >> >                 printf ("\n We never got here\n");
> >> >         }
> >> >         exit (0);
> >> > }
> >> > covell@xxxxxx ~>gcc -Wall foo.c
> >> > foo.c: In function `main':
> >> > foo.c:17: warning: implicit declaration of function `exit'
> >> 
> >> I'm lost. What do you want to prove ? (Al Viro would say you just want
> >> to show you don't know C ;)
> >> And why do you think you never get there ?
> 
> Alexander> I suspect that our, ah, Java-loving friend doesn't realize that '\0' is
> Alexander> a legitimate value of type char...
> 
> Alexander> BTW, he's got a funny compiler - I would expect at least a warning about
> Alexander> use of uninitialized variable.
> 
> That warning would require data-flow analysis (reachable definitions
> in this case), which is not enabled with certain levels of
> optimization.

Yes, the warning is enabled as soon as you start to optimize (-O1 and
more), which is often the case. And if you ask for warnings, of course.

	Xav

