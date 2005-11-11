Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVKKUUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVKKUUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVKKUUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:20:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16389 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751140AbVKKUUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:20:08 -0500
Date: Fri, 11 Nov 2005 21:20:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20051111202005.GQ5376@stusta.de>
References: <20051107200336.GH3847@stusta.de> <20051110042857.38b4635b.akpm@osdl.org> <20051111021258.GK5376@stusta.de> <20051110182443.514622ed.akpm@osdl.org> <20051111201849.GP5376@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111201849.GP5376@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 09:18:49PM +0100, Adrian Bunk wrote:
>...
> But in this case -Werror-implicit-function-declaration doesn't create 
> new compile errors, it only moves compile errors from compile time to 
> link or depmod time - which is IMHO not a bad change.
> 
> If you really want to keep the status quo, you can still steal the 
> following from sparc64:
>   extern unsigned long virt_to_bus_not_defined_use_pci_map(volatile void *addr);
>   #define virt_to_bus virt_to_bus_not_defined_use_pci_map
>   extern unsigned long bus_to_virt_not_defined_use_pci_map(volatile void *addr);
>   #define bus_to_virt bus_to_virt_not_defined_use_pci_map
> 
> Would a patch to mark the ISA legacy functions as __deprecated be OK?
>...

Sorry, this were two separate thoughts:

Would a patch to mark both virt_to_bus/bus_to_virt and the ISA legacy 
functions (that cause similar problems) as __deprecated be OK?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

