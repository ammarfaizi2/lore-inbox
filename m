Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272917AbTHEQ4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272900AbTHEQzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:55:42 -0400
Received: from poup.poupinou.org ([195.101.94.96]:15878 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S272869AbTHEQzY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:55:24 -0400
Date: Tue, 5 Aug 2003 18:55:18 +0200
To: Patrick Mochel <mochel@osdl.org>
Cc: Tomas Szepe <szepe@pinerecords.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus, take two
Message-ID: <20030805165518.GC1511@poupinou.org>
References: <20030805162604.GF18982@louise.pinerecords.com> <Pine.LNX.4.44.0308050946030.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308050946030.23977-100000@cherise>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 09:48:04AM -0700, Patrick Mochel wrote:
> 
> > > > o  only enable cpufreq options if power management is selected
> > > > o  don't put cpufreq options in a separate submenu
> > > 
> > > Yes, but what I do not understand is why cpufreq need power management.
> > 
> > Because it is a power management option. :)
> > 
> > CONFIG_PM is a dummy option, it does not link any code into the kernel
> > by itself.
> 
> Actually, it does:
> 
> ./arch/arm/kernel/Makefile:obj-$(CONFIG_PM)             += pm.o
> ./arch/arm/mach-pxa/Makefile:obj-$(CONFIG_PM) += pm.o sleep.o
> ./arch/arm/mach-sa1100/Makefile:obj-$(CONFIG_PM)                        += pm.o sleep.o
> ./arch/i386/kernel/Makefile:obj-$(CONFIG_PM)            += suspend.o
> ./drivers/pci/Makefile:obj-$(CONFIG_PM)  += power.o
> ./kernel/Makefile:obj-$(CONFIG_PM) += pm.o power/
> 
> 
> But, I agree with your change anyway. 

Then why?  You may want to scale cpu frequency without having power
managements in mind.  Likewise for acpi btw (think HT only or irq routing
via acpi for instance).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
