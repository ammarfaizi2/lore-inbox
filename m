Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272914AbTHEQqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272881AbTHEQn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:43:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:13531 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272869AbTHEQnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:43:13 -0400
Date: Tue, 5 Aug 2003 09:48:04 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Tomas Szepe <szepe@pinerecords.com>
cc: Ducrot Bruno <poup@poupinou.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus, take two
In-Reply-To: <20030805162604.GF18982@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0308050946030.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > o  only enable cpufreq options if power management is selected
> > > o  don't put cpufreq options in a separate submenu
> > 
> > Yes, but what I do not understand is why cpufreq need power management.
> 
> Because it is a power management option. :)
> 
> CONFIG_PM is a dummy option, it does not link any code into the kernel
> by itself.

Actually, it does:

./arch/arm/kernel/Makefile:obj-$(CONFIG_PM)             += pm.o
./arch/arm/mach-pxa/Makefile:obj-$(CONFIG_PM) += pm.o sleep.o
./arch/arm/mach-sa1100/Makefile:obj-$(CONFIG_PM)                        += pm.o sleep.o
./arch/i386/kernel/Makefile:obj-$(CONFIG_PM)            += suspend.o
./drivers/pci/Makefile:obj-$(CONFIG_PM)  += power.o
./kernel/Makefile:obj-$(CONFIG_PM) += pm.o power/


But, I agree with your change anyway. 


	-pat

