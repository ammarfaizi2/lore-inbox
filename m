Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTIGMvl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 08:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTIGMvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 08:51:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47815 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262930AbTIGMvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 08:51:39 -0400
Date: Sun, 7 Sep 2003 14:51:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       robert@schwebel.de
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907125133.GS14436@fs.tum.de>
References: <20030907112813.GQ14436@fs.tum.de> <20030907124237.GA922@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030907124237.GA922@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 02:42:37PM +0200, Sam Ravnborg wrote:
> On Sun, Sep 07, 2003 at 01:28:13PM +0200, Adrian Bunk wrote:
> Could you change this:
> > +ifdef CONFIG_CPU_386
> > +  CFLAGS_CPU	:= -march=i386
> > +endif
> > +
> >  
> > -CFLAGS += $(cflags-y)
> > +CFLAGS += $(CFLAGS_CPU)
> 
> to:
> cpuflags-$(CONFIG_CPU_386) := -march=i386
> CFLAGS += $(cflags-y) $(cpuflags-y)

If I understand you correctly this doesn't change the functionality,
it's a s/CFLAGS_CPU/cpuflags-y/g ?

> I kept cflags-y, but you may have totally eliminated that?

AFAIK the cflags-y did what your proposed cpuflags-y does.

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

