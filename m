Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752113AbWCCBQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbWCCBQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWCCBQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:16:45 -0500
Received: from simmts7.bellnexxia.net ([206.47.199.165]:38536 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1752113AbWCCBQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:16:44 -0500
Message-ID: <440798FA.4080306@ns.sympatico.ca>
Date: Thu, 02 Mar 2006 21:16:42 -0400
From: Kevin Winchester <kwin@ns.sympatico.ca>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Compile Warnings on 2.6.16-rc5-mm1
References: <44078075.7000504@ns.sympatico.ca>
In-Reply-To: <44078075.7000504@ns.sympatico.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Winchester wrote:
>
> I get the following compile warnings on 2.6.16-rc5-mm1.  I am looking 
> into them, but someone probably knows why they're there right off.
>
> In file included from include/asm/hw_irq.h:23,
>                 from include/linux/irq.h:94,
>                 from include/asm/hardirq.h:6,
>                 from include/linux/hardirq.h:7,
>                 from include/linux/interrupt.h:11,
>                 from include/linux/rtc.h:14,
>                 from drivers/rtc/interface.c:14:
> include/linux/profile.h:66: warning: "struct notifier_block" declared 
> inside parameter list
> include/linux/profile.h:66: warning: its scope is only this definition 
> or declaration, which is probably not what you want
> include/linux/profile.h:71: warning: "struct notifier_block" declared 
> inside parameter list
> include/linux/profile.h:76: warning: "struct notifier_block" declared 
> inside parameter list
> include/linux/profile.h:81: warning: "struct notifier_block" declared 
> inside parameter list
>
>
> These come up in lots and lots of files.  Everything that includes 
> hardirq.h it seems.  My config is below.
>
<snip config>

I discovered I can make these go away by enabling CONFIG_PROFILING, 
which was a wild guess since the problem happened in profile.h.

Kevin

