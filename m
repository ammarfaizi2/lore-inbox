Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVBZP3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVBZP3B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 10:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVBZP3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 10:29:01 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32524 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261218AbVBZP26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 10:28:58 -0500
Date: Sat, 26 Feb 2005 16:28:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport do_settimeofday
Message-ID: <20050226152855.GM3311@stusta.de>
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org> <20050225214326.GE3311@stusta.de> <20050225135504.7749942e.akpm@osdl.org> <20050225230246.GI3311@stusta.de> <20050225152009.14cdf450.akpm@osdl.org> <1109412084.6414.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109412084.6414.18.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 11:01:24AM +0100, Arjan van de Ven wrote:
> On Fri, 2005-02-25 at 15:20 -0800, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > > 
> > > You get a false positive if the file containing the symbol is itself a 
> > > module.
> > 
> > I don't understand what you mean.
> > 
> > You mean that a module is doing an EXPORT_SYMBOL of a symbol which is on
> > death row?
> > 
> > If so: err, not sure.  I guess we could just live with the warning.
> 
> also those should be rare; it's certainly not a "core" export that 3rd
> party stuff depends on but most of the time just accidentally exported
> (by people who thought that they needed EXPORT_SYMBOL to glue two .c
> files into the same one .o module)

Some subsystems (e.g. PCMCIA, USB, ALSA, IDE, Firewire, ISDN, I2C, IPv6, 
SCSI) can be built completely modular and will therefore experience this 
issue if any symbol in them is __deprecated_in_modules.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

