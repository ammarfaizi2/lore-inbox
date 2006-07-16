Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWGPJNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWGPJNr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 05:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWGPJNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 05:13:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62225 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750805AbWGPJNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 05:13:46 -0400
Date: Sun, 16 Jul 2006 11:13:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Dave Jones <davej@redhat.com>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: tighten ATA kconfig dependancies
Message-ID: <20060716091332.GW3633@stusta.de>
References: <20060715053418.GA5557@redhat.com> <1152942548.3114.4.camel@laptopd505.fenrus.org> <20060715063827.GA24579@mars.ravnborg.org> <1152945956.3114.6.camel@laptopd505.fenrus.org> <20060715102825.GR3633@stusta.de> <1152961003.3114.15.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152961003.3114.15.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 12:56:43PM +0200, Arjan van de Ven wrote:
> 
> > > the point is that it doesn't fall out naturally, and thus things get
> > > needlessly missed.
> > 
> > It seems the main question is:
> > Is the kernel configuration mainly designed for users or for developers?
> > 
> > For users, showing drivers for hardware that is not present on their 
> > platform only causes confusion.
> 
> well Aunt Tilly gets confused by all hardware that is not present on her
> machine; she has no idea what a platform is. By that reasoning, we
> should make kconfig hide all non-present hardware.
> 
> Also I think there is no difference in confusion between showing 10 or
> 15 IDE chipsets. Either the user knows what he has (and then it doesn't
> matter) or those 10 are too much already.

It's not about Aunt Tilly, it's about an average systems administrator 
compiling his own kernel.

And there are already too many options visible, and the result are real 
world problems - I've seen it too often that someone didn't compile the 
support for his IDE chipset into the kernel. And this specific patch is 
only a small part of the general issue.

The situation was different if only developers and distributions would 
compile kernels, but that's not what's happening in the real world. 
Kernel developers are only a tiny minority amongst the people 
configuring and compiling their own kernel.

And if the "compile coverage" point was meant seriously, we'd also need 
some dummy #define's for getting all currently BROKEN_ON_SMP options 
compiling with CONFIG_SMP=y since in my experience they are getting
nearly zero compile coverage since it seems the "compile coverage" crowd 
only blindly runs allmdconfig/allyesconfig.

I'm often reporting and sometimes fixing compile errors, but that's OK.
Compile errors are really obvious errors (compared to e.g. runtime 
corruptions), and therefore not a real problem.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

