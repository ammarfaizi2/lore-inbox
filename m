Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVBCWSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVBCWSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVBCWPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:15:43 -0500
Received: from [211.58.254.17] ([211.58.254.17]:56045 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261195AbVBCWF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:05:59 -0500
Message-ID: <4202A041.3030808@home-tj.org>
Date: Fri, 04 Feb 2005 07:05:53 +0900
From: Tejun Heo <tj@home-tj.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ide and ROMs
References: <9e4733910502011957145191f5@mail.gmail.com>
In-Reply-To: <9e4733910502011957145191f5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> Since it looks like ide is being worked on, can you convert ide to use
> the PCI ROM access calls in drivers/pci/rom.c instead of directly
> manipulating PCI config space? The new ROM calls work on all
> architectures.
> 
> These are the places that need to be fix:
> [jonsmirl@jonsmirl ide]$ grep -r PCI_ROM_ADDRESS_ENABLE *
> pci/aec62xx.c:          pci_write_config_dword(dev, PCI_ROM_ADDRESS,
> dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> pci/cmd64x.c:           pci_write_config_byte(dev, PCI_ROM_ADDRESS,
> dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> pci/hpt34x.c:                          
> dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> pci/hpt366.c:                   dev->resource[PCI_ROM_RESOURCE].start
> | PCI_ROM_ADDRESS_ENABLE);
> pci/pdc202xx_new.c:                    
> dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> pci/pdc202xx_old.c:                    
> dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
> [jonsmirl@jonsmirl ide]$

Sure, I'll look at it.

-- 
tejun

