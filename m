Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVGGUGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVGGUGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVGGUD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:03:59 -0400
Received: from unused.mind.net ([69.9.134.98]:35975 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262309AbVGGUC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 16:02:58 -0400
Date: Thu, 7 Jul 2005 13:02:05 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-12
In-Reply-To: <20050707104859.GD22422@elte.hu>
Message-ID: <Pine.LNX.4.58.0507071257320.25321@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
 <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org>
 <20050707104859.GD22422@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Ingo Molnar wrote:

> is this inheritance perpetual? It is normal for some tasks to be boosted 
> momentarily, but if the condition remains even after jackd has exited, 
> it's clearly an anomaly. (lets call it "RT priority leakage".) Priority 
> leakage on SMP was fixed recently, but there could be other bugs 
> remaining.
> 
> There's priority-leakage debugging code in the -RT kernel, which is 
> activated if you enable CONFIG_DEBUG_PREEMPT. This debugging code, if 
> triggered, should produce 'BUG: comm/123 leaked RT prio 123 (123)?" type 
> of messages. But ... due to a bug it would not print out anything but 
> would lock up hard if it detects the condition (and if 
> RT_DEADLOCK_DETECT is enabled). I have fixed this reporting bug in the 
> -51-08 kernel.

-51-12 is still exhibhiting the RT priority leakage, but isn't producing 
any BUG messages.

--ww
