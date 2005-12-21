Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVLUWLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVLUWLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVLUWLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:11:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17420 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964811AbVLUWLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:11:16 -0500
Date: Wed, 21 Dec 2005 23:11:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, uclinux-v850@lsi.nec.co.jp
Subject: Re: [RFC: 2.6 patch] include/linux/irq.h: #include <linux/smp.h>
Message-ID: <20051221221114.GA3917@stusta.de>
References: <20051221012750.GD5359@stusta.de> <20051221024133.93b75576.akpm@osdl.org> <20051221110421.GA26630@flint.arm.linux.org.uk> <20051221213321.GC3888@stusta.de> <20051221214806.GJ1736@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221214806.GJ1736@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 09:48:06PM +0000, Russell King wrote:
> On Wed, Dec 21, 2005 at 10:33:21PM +0100, Adrian Bunk wrote:
> > On Wed, Dec 21, 2005 at 11:04:22AM +0000, Russell King wrote:
> > > On Wed, Dec 21, 2005 at 02:41:33AM -0800, Andrew Morton wrote:
> > > > Yes, it's basically always wrong to include asm/foo.h when linux/foo.h
> > > > exists. 
> > > 
> > > There's always an exception to every rule.  linux/irq.h is that
> > > exception for the above rule.
> > 
> > Why?
> 
> /*
>  * Please do not include this file in generic code.  There is currently
>  * no requirement for any architecture to implement anything held
>  * within this file.
>  *
>  * Thanks. --rmk
>  */
> 
> Using linux/irq.h instead of asm/irq.h _breaks_ architectures
> which do not use the generic irq code.
> 
> Basically, linux/irq.h should have been called asm-generic/irq.h.

I'm not getting your point.

The patch we are discussing is:

--- linux-2.6.15-rc6/include/linux/irq.h.old	2005-12-20 21:45:57.000000000 +0100
+++ linux-2.6.15-rc6/include/linux/irq.h	2005-12-20 21:46:08.000000000 +0100
@@ -10,7 +10,7 @@
  */
 
 #include <linux/config.h>
-#include <asm/smp.h>		/* cpu_online_map */
+#include <linux/smp.h>
 


> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

