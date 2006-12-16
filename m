Return-Path: <linux-kernel-owner+w=401wt.eu-S1030887AbWLPMKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030887AbWLPMKp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 07:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030889AbWLPMKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 07:10:45 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2389 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030887AbWLPMKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 07:10:44 -0500
Date: Sat, 16 Dec 2006 12:10:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, Dirk@Opfer-Online.de,
       arminlitzel@web.de, pavel.urban@ct.cz, metan@seznam.cz
Subject: Re: Nasty warnings on arm (+ one compile problem -- INIT_WORK related)
Message-ID: <20061216121029.GA9186@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
	Dirk@Opfer-Online.de, arminlitzel@web.de, pavel.urban@ct.cz,
	metan@seznam.cz
References: <20061215235818.GD2853@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215235818.GD2853@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 12:58:18AM +0100, Pavel Machek wrote:
> I get nasty warning for each file compiled:
> 
>   CC      drivers/video/sa1100fb.o
> In file included from include/asm/bitops.h:23,
>                  from include/linux/bitops.h:9,
>                  from include/linux/thread_info.h:20,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/module.h:9,
>                  from drivers/video/sa1100fb.c:163:
> include/asm/system.h: In function `adjust_cr':
> include/asm/system.h:185: warning: implicit declaration of function
> `local_irq_save'
> include/asm/system.h:192: warning: implicit declaration of function
> `local_irq_restore'
> include/asm/system.h:179: warning: unused variable `cr'

I know of these.  When I come around to merging next week I'll fix it
(probably by reverting the two commits.)  Until then, you'll have to
put up with it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
