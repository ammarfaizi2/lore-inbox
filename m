Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVATGxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVATGxY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 01:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVATGxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 01:53:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52228 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262064AbVATGxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 01:53:20 -0500
Date: Thu, 20 Jan 2005 07:53:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc1-mm2: CONFIG_SMP=n compile error
Message-ID: <20050120065318.GA3170@stusta.de>
References: <20050119213818.55b14bb0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119213818.55b14bb0.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 09:38:18PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-rc1-mm1:
>...
> +i386-x86-64-fix-smp-nmi-watchdog-race.patch
>...
>  x86_64 updates
>...

This obviously breaks compilation for CONFIG_SMP=n:

<--  snip  -->

...
  CC      arch/i386/kernel/nmi.o
arch/i386/kernel/nmi.c: In function `check_nmi_watchdog':
arch/i386/kernel/nmi.c:130: error: `cpu_callin_map' undeclared (first use in this function)
arch/i386/kernel/nmi.c:130: error: (Each undeclared identifier is reported only once
arch/i386/kernel/nmi.c:130: error: for each function it appears in.)
make[1]: *** [arch/i386/kernel/nmi.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

