Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUHBXIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUHBXIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUHBXIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:08:25 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36089 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263664AbUHBXIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:08:23 -0400
Date: Tue, 3 Aug 2004 01:08:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
Message-ID: <20040802230815.GS2746@fs.tum.de>
References: <200408021134.i72BYQdN026747@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408021134.i72BYQdN026747@harpo.it.uu.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 01:34:26PM +0200, Mikael Pettersson wrote:
> On Sun, 1 Aug 2004 12:40:26 +0200, Adrian Bunk wrote:
> >
> >BTW:
> >
> >Please don't include the compiler.h part of your patch.
> >It's already reverted in -mm, and we're currently fixing the inlines
> >in 2.6 .
> >
> >This was started after with this patch in 2.6 somewhere a required 
> >inlining did no longer occur (and a compile error is definitely better 
> >than a potential runtime problem).
> 
> Which one was that? DaveM wrote recently that they had eliminated
> SPARC's save_flags/restore_flags-in-same-stack-frame requirement.

The breakage that started the discussion regarding 2.6 was a breakage in 
suspend2 (AFAIR on i386).

It's unknown whether there are other breakages in in-kernel code, and I 
strongly prefer three dozen easy compile fixes over possible runtime 
errors.

> >Although fixing it correctly touches at about three dozen files, these 
> >are pretty straightforward patches (removing inlines or moving code 
> >inside files). After all these issues are sorted out in 2.6, the inline 
> >fixes could be backported to 2.4 .
> 
> I'll consider attacking the inlining issues, after I've reviewed my
> cast-as-lvalue and fastcall fixes -- I noticed that at least one fix
> had changed in 2.6 since I first adapted it to 2.4.

I can also attack the inlining issues (I sent most of the 2.6 fixes), 
but I'd prefer to wait until we've fixed all of them in 2.6 before 
backporting the fixes.

> /Mikael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

