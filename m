Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314496AbSEQFD5>; Fri, 17 May 2002 01:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314557AbSEQFD4>; Fri, 17 May 2002 01:03:56 -0400
Received: from [213.196.40.44] ([213.196.40.44]:19110 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S314496AbSEQFDz>;
	Fri, 17 May 2002 01:03:55 -0400
Date: Thu, 16 May 2002 23:45:39 +0200 (CEST)
From: <bvermeul@devel.blackstar.nl>
To: Norman Walsh <ndw@nwalsh.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel PCMCIA/CardBus on a Tecra 8200
In-Reply-To: <874rh8jl2o.fsf@nwalsh.com>
Message-ID: <Pine.LNX.4.33.0205162339200.26976-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyway, with 2.4.18 (of my own construction) on a Debian (woody) box
> with Kernel PCMCIA/CardBus support, booting reports
> 
> Linux Kernel Card Services 3.1.22
>   options:  [pci] [cardbus] [pm]
> PCI: Enabling device 02:0c.0 (0000 -> 0002)
> PCI: Found IRQ 11 for device 02:0c.0
> PCI: Sharing IRQ 11 with 01:00.0
> PCI: Sharing IRQ 11 with 02:0d.0
> PCI: Enabling device 02:0d.0 (0000 -> 0002)
> PCI: Found IRQ 11 for device 02:0d.0
> PCI: Sharing IRQ 11 with 01:00.0
> PCI: Sharing IRQ 11 with 02:0c.0
> PCI: Enabling device 02:0d.1 (0000 -> 0002)
> PCI: Found IRQ 11 for device 02:0d.1
> PCI: Sharing IRQ 11 with 00:1f.2
> PCI: Sharing IRQ 11 with 02:07.0
> Yenta IRQ list 0000, PCI irq11
> Socket status: 30000011
> Yenta IRQ list 04b8, PCI irq11
> Socket status: 30000007
> Yenta IRQ list 04b8, PCI irq11
> Socket status: 30000007
> 
> which looks ok (to my naive eyes). But when booting finishes and I run
> 'cardctl ident' (from pcmcia-cs 3.1.33, I suppose), I get:
> 
> Socket 0:
> cs: warning: no high memory space available!
> cs: unable to map card memory!
> Socket 1:
> cs: unable to map card memory!
> Socket 2:
> cs: unable to map card memory!

I've seen these messages before. Check config.opts, and make sure it's 
valid. When in doubt, reinstall pcmcia-cs from woody.
That seemed to fix the problem I had.

Regards,

Bas Vermeulen

-- 
"God, root, what is difference?" 
	-- Pitr, User Friendly

"God is more forgiving." 
	-- Dave Aronson

