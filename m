Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbUATWMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUATWMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:12:08 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26855 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265816AbUATWKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:10:38 -0500
Date: Tue, 20 Jan 2004 23:10:25 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Robert Schwebel <robert@schwebel.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Juergen Beisert <jbeisert@eurodsn.de>, cliff white <cliffw@osdl.org>,
       piggin@cyberone.com.au, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [1/4] better i386 CPU selection
Message-ID: <20040120221025.GI12027@fs.tum.de>
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au> <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au> <20040110004625.GB25089@fs.tum.de> <20040110005232.GD25089@fs.tum.de> <20040116111501.70200cf3.cliffw@osdl.org> <Pine.LNX.4.53.0401161425110.31018@chaos> <20040117021532.GH12027@fs.tum.de> <20040117091337.GZ5139@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117091337.GZ5139@pengutronix.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 10:13:37AM +0100, Robert Schwebel wrote:

> Hi, 

Hi Robert,

> On Sat, Jan 17, 2004 at 03:15:32AM +0100, Adrian Bunk wrote:
> > Besides the AMD Elan cpufreq driver I see nothing where CONFIG_MELAN
> > gave you any real difference (except your highest goal is to avoid a
> > recompilation when switching from the Pentium 4 to the AMD Elan - but I
> > doubt the really "prevents development").
> > 
> > But I'm not religious about this issue. Let Robert decide, the Elan 
> > support is his child.
> > 
> > > > > - added optimizing CFLAGS for the AMD Elan
> > > 
> > > There are no such different "optimizations" for ELAN.
> > 
> > What's wrong wih the -march=i486 Robert suggested?
> 
> I've not followed the 2.6 development regarding the arch selection that
> closely; let's collect arguments: 
> 
> - Is it still possible to run a -march=i486 built kernel on a pentium? 
>   IMHO It would be good to optimize the code for i486, but I'm not that 
>   familiar with how good gcc optimizes for 486 that I can comment this.

yes, since a Pentium supports a superset of the 486 gcc can't optimize 
for a 486 in a way that the code won't run on a Pentium.

> - I personally work with lots of cross architectures like ARM, so cross
>   compiling for an embedded system is no problem for me. But if people
>   want to test stuff on their pentiums I also have no problem with that.
> 
> Other arguments? 

The only reason why I sent the patch to make the AMD Elan a separate 
subarch was the CLOCK_TICK_RATE #ifdef in include/asm-i386/timex.h .

It should be possible to change it to a variable (as with 
CONFIG_X86_PC9800) if both the Elan and a different cpu are supported if 
this is really a required use.

If this is the solution you prefer, how would you do runtime detection 
for the AMD Elan?

> Robert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

