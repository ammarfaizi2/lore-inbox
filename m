Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbVA2Ati@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVA2Ati (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 19:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVA2Ati
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 19:49:38 -0500
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:61343 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S262832AbVA2Atf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 19:49:35 -0500
Mime-Version: 1.0
Message-Id: <a06200728be208da1c70e@[129.98.90.227]>
In-Reply-To: <16879.31182.438866.298939@alkaid.it.uu.se>
References: <a06100502be077de5e936@[129.98.90.227]>
 <16879.31182.438866.298939@alkaid.it.uu.se>
Date: Fri, 28 Jan 2005 19:49:40 -0500
To: Mikael Pettersson <mikpe@csd.uu.se>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: 2.6.11-r1 freezes dual 2.5 GHz PowerMac G5
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below works. Thanks.

>Maurice Volaski writes:
>  > I am running Gentoo with a fresh 2.6.11-r1. I have all the kernel
>  > debugging options turned on. Occasionally, I can get past the boot
>  > process, but half the time it freezes somewhere along the way. If
>  > not, I do get to boot, it doesn't take very long for it to freeze.
>
>Did 2.6.10 work Ok? Try the patch below, it fixes 2.6.11-rc1 boot
>lockups on both my Beige G3 (locks up in ADB driver) and my G4 eMac
>(locks up in radeonfb).
>
>--- linux-2.6.11-rc1/init/main.c.~1~	2005-01-15 03:30:25.000000000 +0100
>+++ linux-2.6.11-rc1/init/main.c	2005-01-15 03:31:44.000000000 +0100
>@@ -377,7 +377,7 @@ static void noinline rest_init(void)
>  	 * Re-enable preemption but disable interrupts to make sure
>  	 * we dont get preempted until we schedule() in cpu_idle().
>  	 */
>-	local_irq_disable();
>+//	local_irq_disable();
>  	preempt_enable_no_resched();
>  	unlock_kernel();
>  	cpu_idle();


-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
