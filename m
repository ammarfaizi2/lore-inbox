Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTIGNAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 09:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTIGNAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 09:00:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35527 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263172AbTIGNAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 09:00:40 -0400
Date: Sun, 7 Sep 2003 15:00:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Robert Schwebel <robert@schwebel.de>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907130034.GT14436@fs.tum.de>
References: <20030907112813.GQ14436@fs.tum.de> <20030907124251.GC5460@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030907124251.GC5460@pengutronix.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 02:42:51PM +0200, Robert Schwebel wrote:
> On Sun, Sep 07, 2003 at 01:28:13PM +0200, Adrian Bunk wrote:
> > The patch below tries to implement a better i386 CPU selection.
> 
> Did you look at how rmk does CPU selection in the ARM tree? He has
> developed a very sophisticated scheme as there are lots of completely
> different cpu implementations, using a few cores. It might be an idea to
> make the schemes more uniform than they are now. 

I didn't look at the ARM Makefile. Thanks for the note, I'll have a look 
at it before I'll do the revision of this patch.

>...
> > Changes:
> [...]
> > - AMD Elan is a different subarch, you can't configure a kernel that 
> >   runs on both the AMD Elan and other i386 CPUs
> 
> Ack. Same with for example Geode. And the subarchs might have different

It seems the Geode support isn't fully merged in 2.6?

> implementations, like Elan SC400, Elan SC410, Elan SC520. 

It should be no problem to add a "Processor support" menu for the Elan
that allows you to specify which Elan CPUs you plan to support.

> > - @Robert:
> >   there were no Elan CFLAGS in arch/i386/Makefile???
> 
> That seems to have evolved since I last touched the Elan stuff. The
> Elans are more or less 486 cores with some edges, so adding -march=i486
> should be ok. 
>...

Thanks, I'll do this.

> Robert

Thanks for your comments
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

