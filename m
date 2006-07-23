Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWGWCTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWGWCTe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 22:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWGWCTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 22:19:33 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:22972 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750809AbWGWCTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 22:19:33 -0400
Message-Id: <200607230219.k6N2JMHI021999@laptop13.inf.utfsm.cl>
To: 7eggert@gmx.de
cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Joshua Hudson <joshudson@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: what is necessary for directory hard links 
In-Reply-To: Message from Bodo Eggert <7eggert@elstempel.de> 
   of "Sat, 22 Jul 2006 18:59:45 +0200." <E1G4Kpi-0001Os-AK@be1.lrz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Sat, 22 Jul 2006 22:19:22 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 22 Jul 2006 22:19:26 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@elstempel.de> wrote:
> Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> > Joshua Hudson <joshudson@gmail.com> wrote:
> >> This patch is the sum total of all that I had to change in the kernel
> >> VFS layer to support hard links to directories

> > Can't be done, as it creates the possibility of loops.

> Don't do that then?

Stop /everything/ to make sure no concurrent activity creates a loop, while
checking the current mkdir(2) doesn't create one?

> > The "only files can
> > be hardlinked" idea makes garbage collection (== deleting of unreachable
> > objects) simple: Just check the number of references.
> > 
> > Detecting unconnected subgraphs uses a /lot/ of memory; and much worse, you
> > have to stop (almost) all filesystem activity while doing it.

> In order to disconnect a directory, you'd have to empty it first, and after
> emptying a directory, it won't be part of a loop. Maybe emtying is the
> problem ...

What does "emptying a directory" mean if there might be loops?

> This feature was implemented,

Never in my memory of any Unix (and lookalike) system in real use (I've
seen a few).

>                               and I asume it was removed for a reason.
> Can somebody remember?

See my objections.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
