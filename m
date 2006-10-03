Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbWJCFHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbWJCFHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 01:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWJCFHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 01:07:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59398 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965246AbWJCFHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 01:07:50 -0400
Date: Tue, 3 Oct 2006 07:07:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Judith Lebzelter <judith@osdl.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20061003050748.GJ3278@stusta.de>
References: <20061002214954.GD665@shell0.pdx.osdl.net> <20061002234428.GE3278@stusta.de> <20061003012241.GF3278@stusta.de> <1159850245.5482.32.camel@localhost.localdomain> <20061002214400.0a83b743.akpm@osdl.org> <1159850979.5482.40.camel@localhost.localdomain> <20061002215527.096a8762.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002215527.096a8762.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 09:55:27PM -0700, Andrew Morton wrote:
> On Tue, 03 Oct 2006 14:49:39 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Mon, 2006-10-02 at 21:44 -0700, Andrew Morton wrote:
> > > On Tue, 03 Oct 2006 14:37:25 +1000
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > 
> > > > > > You might want to convince Andrew accepting my patch to make 
> > > > > > virt_to_bus/bus_to_virt give compile warnings on i386 for making
> > > > > > people more aware of this problem...
> > > > > >...
> > > > 
> > > > Andrew, is there any reason not to take that patch ?
> > > 
> > > It generates lots of warnings from drivers which nobody does any work on.
> > > 
> > > Net result: lots of new warnings, no fixed bugs.
> > 
> > Are you sure the warnings won't cause somebody like Al to go through
> > them all and fix them ?
> 
> The drivers simply don't link on some architectures, due to missing
> virt_to_bus/bus_to_virt.    They aren't hard to find.
>...

As my patch description says, there had even been one bus_to_virt() 
accidentally added in 2.6.17-rc1.

Shouldn't people become aware of it as early and as often as possible?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

