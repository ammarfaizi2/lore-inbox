Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVCAT1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVCAT1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 14:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVCAT1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 14:27:02 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:2433 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262028AbVCAT0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 14:26:52 -0500
Message-Id: <200503011926.j21JQ5dP007149@laptop11.inf.utfsm.cl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       ultralinux@vger.kernel.org
Subject: Re: SPARC64: Modular floppy? 
In-Reply-To: Message from "Randy.Dunlap" <rddunlap@osdl.org> 
   of "Tue, 01 Mar 2005 09:25:38 -0800." <4224A592.1050909@osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 01 Mar 2005 16:26:05 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 01 Mar 2005 16:26:06 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> said:
> Horst von Brand wrote:
> > "David S. Miller" <davem@davemloft.net> said:
> >>On Mon, 28 Feb 2005 17:07:43 -0300
> >>Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

> > [...]

> >>>So, either the dependencies have to get fixed so floppy can't be modular
> >>>for this architecture, or the relevant functions have to move from entry.S
> >>>to the module.

> >>I think the former is the best solution.  The assembler code really
> >>needs to get at floppy.c symbols.

> >>From my cursory look the stuff depending on the floppy.c symbols is just
> > in the floppy-related code. Can't that be just included in floppy.c?
> > (Could be quite a mess, but it looks like short stretches).

> The code in entry.S looks self-contained (to me:), so moving it
> somewhere else should just be a SMOP (mostly kbuild stuff)....

Right. But where? I was thinking under arch/sparc64/drivers/floppy.S or
such. And then there would need to be some make magic for it to get picked
up and included only for sparc64. Sounds doable, if somewhat messy.

But thinking a bit farther, if every arch and random driver starts playing
this kind of games, we'll soon be in a world of hurt. Not sure if it is
worth it.

Other solution was to #ifdef that stuff into floppy.c, but again at the
end of that way lies madness.

I'll see what I come up with. Recomended reading on the whole kbuild stuff?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
