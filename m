Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTJUSH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 14:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263255AbTJUSH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 14:07:28 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:48914 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263241AbTJUSH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 14:07:27 -0400
Date: Tue, 21 Oct 2003 19:07:06 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Valdis.Kletnieks@vt.edu
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: 2.6.0-test8 - CONFIG_PCI_CONSOLE
In-Reply-To: <200310210120.h9L1K3Fg002814@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0310211906240.32738-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have had the question. It appears to be dead code. unless someone speaks 
up I will remove that code.


On Mon, 20 Oct 2003 Valdis.Kletnieks@vt.edu wrote:

> in drivers/video/console/Kconfig, we have:
> 
> config PCI_CONSOLE
>         bool
>         depends on FRAMEBUFFER_CONSOLE
>         default y
> 
> However, it's unclear what this variable actually *DOES*:
> 
> [/usr/src/linux-2.6.0-test8-mm1-a]2 find . ! -name '*.o' | xargs grep PCI_CONS
> ./drivers/video/console/Kconfig:config PCI_CONSOLE
> ./arch/ppc/configs/power3_defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ppc/configs/common_defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ppc/configs/sandpoint_defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ppc/configs/ibmchrp_defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ppc/configs/pmac_defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ppc/defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/sparc64/defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ia64/defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ppc64/defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/parisc/defconfig:CONFIG_PCI_CONSOLE=y
> ./.config.old:CONFIG_PCI_CONSOLE=y
> ./config.old:CONFIG_PCI_CONSOLE=y
> 
> References in defconfig files, and in my .config, and that's about it...
> 
> It's been apparently dead code at least as far back as -test5-mm3.
> 

