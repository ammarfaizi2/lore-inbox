Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbVFXJ2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbVFXJ2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 05:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbVFXJ2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 05:28:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65286 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263257AbVFXJY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 05:24:56 -0400
Date: Fri, 24 Jun 2005 11:24:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Quadriplegic Leprechaun <quadriplegic_leprechaun@ukonline.co.uk>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: 2.6.12-mm1: PCI compile error with CONFIG_HOTPLUG=n
Message-ID: <20050624092454.GE26545@stusta.de>
References: <42BBBBC0.2050702@ukonline.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BBBBC0.2050702@ukonline.co.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 08:52:32AM +0100, Quadriplegic Leprechaun wrote:

> Hi,

Hi,

> With the attached config, I get an undefined symbol error when building 
> the following kernel:
> 
> $ head Makefile
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 12
> EXTRAVERSION = -mm1
> NAME=Woozy Numbat
> 
> And this is the error I get:
> [ ... lots of output snipped ... ]
>  LD      vmlinux
> arch/i386/pci/built-in.o(.init.text+0x101e): In function `pcibios_init':
> common.c: undefined reference to `pci_assign_unassigned_resources'
> make: *** [vmlinux] Error 1

thanks for this report.

@Ivan, Greg:
gregkh-pci-pci-assign-unassigned-resources.patch breaks compilation with 
CONFIG_HOTPLUG=n.

> Quad

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

