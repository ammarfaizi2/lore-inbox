Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUIHM3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUIHM3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUIHM3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:29:44 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:26075 "EHLO
	kartuli.timesys") by vger.kernel.org with ESMTP id S262062AbUIHM33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:29:29 -0400
Message-ID: <413EFB11.2000507@timesys.com>
Date: Wed, 08 Sep 2004 08:29:05 -0400
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Scott Wood <scott@timesys.com>, Andrey Panin <pazke@donpac.ru>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
References: <20040908120613.GA16916@elte.hu>
In-Reply-To: <20040908120613.GA16916@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>the attached patch moves generic hardirq handling bits to
>kernel/hardirq.c. It is not a replacement for any of the existing IRQ
>functions, so architectures can use their existing hardirq code in an
>unmodified form. It is a library of generic functions that an
>architecture can make use of optionally.
>
>I've fully converted x86's irq.c to use the new functions, and Scott
>Wood has done the same for ppc/ppc64 as well. (the arch-ppc* changes are
>not included in this patch because i couldnt test them myself in the
>current port of this patch - but the generic bits were tested on ppc.)
>  
>

In the interests of full provinence, the TimeSys patches are based on
work by Andrey Panin.

>i have test-compiled and test-booted the patch on x86 and x64, on SMP &&
>PREEMPT and !SMP && !PREEMPT kernels. x64 needed only a single change (a
>setup_irq() prototype) to work fine, which makes me believe that the
>patch will not break other architectures either.
>
>(a more complex version of this patch has been tested for weeks as part
>of the voluntary-preempt patches as well.)
>
>	Ingo
>  
>
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell's sig

