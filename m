Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753521AbWKFRaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbWKFRaF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbWKFRaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:30:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8722 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753542AbWKFRaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:30:02 -0500
Date: Mon, 6 Nov 2006 18:30:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Christian <christiand59@web.de>,
       Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Message-ID: <20061106173001.GP5778@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <200611051832.13285.christiand59@web.de> <20061106060021.GD5778@stusta.de> <200611061643.14217.christiand59@web.de> <20061106172049.GA19283@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106172049.GA19283@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 12:20:49PM -0500, Dave Jones wrote:
> On Mon, Nov 06, 2006 at 04:43:13PM +0100, Christian wrote:
> 
>  > > Did you have CONFIG_ACPI_PROCESSOR=y in 2.6.18, or did
>  > > CONFIG_ACPI_PROCESSOR=m, CONFIG_X86_POWERNOW_K8=y work for you in 2.6.18?
>  > 
>  > It worked with CONFIG_ACPI_PROCESSOR=m in 2.6.18-rc7. Since 2.6.19-rc1 it 
>  > doesn't work anymore with CONFIG_ACPI_PROCESSOR=m.
>  > 
>  > user@ubuntu:~/Projekte/linux-2.6.18-rc7$ grep -i ACPI_PROCESSOR /boot/config-2.6.18-rc7
>  > CONFIG_ACPI_PROCESSOR=m
>  > 
>  > user@ubuntu:~/Projekte/linux-2.6.18-rc7$ 
>  > grep -Ei "POWERNOW_K8" /boot/config-2.6.18-rc7
>  > CONFIG_X86_POWERNOW_K8=m
>  > CONFIG_X86_POWERNOW_K8_ACPI=y
>  > 
>  > +++ There's a difference in 2.6.19! CONFIG_X86_POWERNOW_K8_ACPI is gone +++
> 
> I don't understand how this was allowed. Because when I try this
> with a 2.6.18 tree..  (nothing changed between -rc7 and final for cpufreq)
> 
> <editted a .config to match your config>
> 
> $ grep ACPI_PROCESSOR .config
> CONFIG_ACPI_PROCESSOR=m
> $ grep POWERNOW_K8 .config
> CONFIG_X86_POWERNOW_K8=y
> CONFIG_X86_POWERNOW_K8_ACPI=y
> 
> and then after a make oldconfig the CONFIG_X86_POWERNOW_K8_ACPI is removed
> as it isn't valid.
> 
> Did you edit your .config by hand ?

Look closer, his linux-2.6.18-rc7 .config contains 
CONFIG_ACPI_PROCESSOR=m, CONFIG_X86_POWERNOW_K8=m.

> 	Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

