Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVALQyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVALQyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 11:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVALQyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 11:54:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60434 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261251AbVALQyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 11:54:41 -0500
Date: Wed, 12 Jan 2005 17:54:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Pollei <stephen_pollei@comcast.net>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Andries Brouwer <aebr@win.tue.nl>,
       Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
Message-ID: <20050112165431.GK29578@stusta.de>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain> <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet> <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org> <20050111225127.GD4378@ip68-4-98-123.oc.oc.cox.net> <20050111235907.GG2760@pclin040.win.tue.nl> <20050112021246.GE4325@ip68-4-98-123.oc.oc.cox.net> <1105506703.977.19.camel@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105506703.977.19.camel@fury>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 09:11:40PM -0800, Stephen Pollei wrote:
> On Tue, 2005-01-11 at 18:12, Barry K. Nathan wrote:
> > > There are more ancient system calls, like old_stat and oldolduname.
> > > Do we want separate options for each system call that is obsoleted?
> 
> > A config option for each one would be a bit much, I'll agree. However,
> > I think having a single config option for the whole bunch would be a
> > good idea. 
>  
> > less controversial than trying to do all of the old syscalls now.
> Well the most controversial one-stop option could be a by date option.
> CONFIG_OBSOLETE_TIME could default to 199201 or whatever
> 
> then you could then make things obsolete by wrapping them with
> #if CONFIG_OBSOLETE_TIME <= 199805
>  /* old stat stuff */
> #endif
> #if CONFIG_OBSOLETE_TIME <= 200211
> /* old uname stuff */
> #endif
> #if CONFIG_OBSOLETE_TIME <= 200501
>   /* uselib */
> #endif
> 
> Then people could select with one option just to what extent they want
> to support old crufty stuff. So one person could go super lean and mean
> by choosing 200502 , while another could choose 200000 just to have
> things from this century. Most people could just leave it alone.

I don't see much value in this proposal - it would only cause confusion 
for users.

Except for some obscure cases, every application compiled with any libc6 
version is expected to work with even the most recent libc6.

OTOH, libc4/libc5 <-> libc6 is a natural border since support for older 
libc's anyways requires extra support by the distribution.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

