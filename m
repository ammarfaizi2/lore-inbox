Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSGUMnp>; Sun, 21 Jul 2002 08:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSGUMnp>; Sun, 21 Jul 2002 08:43:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:56815 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314381AbSGUMno>; Sun, 21 Jul 2002 08:43:44 -0400
Date: Sun, 21 Jul 2002 14:46:23 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Szakacsits Szabolcs <szaka@sienet.hu>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit
In-Reply-To: <1027258349.17234.85.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.NEB.4.44.0207211438440.11656-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jul 2002, Alan Cox wrote:

> On Sun, 2002-07-21 at 10:10, Szakacsits Szabolcs wrote:
> > On Fri, 19 Jul 2002, Alan Cox wrote:
> > > Make swapoff -a return -ENOMEM
> > >
> > > I've not done this on the basis that this is root specific stupidity and
> > > generally shouldnt be protected against
> >
> > Recommended reading: MIT's Magazin of Innovation Technology Review,
> > August 2002 issue, cover story: Why Software Is So Bad?
> >
> > Next you might read: "... prominent, leading Linux kernel developer
> > publically labels users stupid instead of handling a special case
>
> I would suggest you do something quite different. Go and read what K&R
> had to say about the design of Unix. One of the design goals of Unix is
> that the system does not think it knows better than the administrator.
> That is one of the reasons unix works well and is so flexible.

The problem is that at the time K&R said this only real men (tm) were
administrators of UNIX systems. Nowadays clueless people like me are
administrators of their Linux system at home.  ;-)

With enough stupidity root can always trash his system but if as Robert
says the state of the system will be that "no allocations will succeed"
which seems to be a synonymous for "the system is practically dead" it is
IMHO a good idea to let "swapoff -a return -ENOMEM".

> Alan

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox




