Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbUKRWBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUKRWBt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbUKRWAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:00:07 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:41457 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261176AbUKRV5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:57:25 -0500
Message-ID: <419D1AC0.9030404@verizon.net>
Date: Thu, 18 Nov 2004 16:57:20 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: simon@nuit.ca
CC: linux-kernel@vger.kernel.org
Subject: Re: follow-up to: OOPS in tulip 2.6.10-rc2-bk2
References: <20041118203258.GC7555@nuit.ca>
In-Reply-To: <20041118203258.GC7555@nuit.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [209.158.220.243] at Thu, 18 Nov 2004 15:57:22 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

simon@nuit.ca wrote:
> i get build warnings:
> 
> drivers/net/appletalk/ipddp.c:292: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
>   CC [M]  drivers/net/tulip/de2104x.o
> drivers/net/tulip/de2104x.c:61: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/tulip/de2104x.c:72: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
>   CC [M]  drivers/net/tulip/eeprom.o
>   CC [M]  drivers/net/tulip/interrupt.o
>   CC [M]  drivers/net/tulip/media.o
>   CC [M]  drivers/net/tulip/timer.o
>   CC [M]  drivers/net/tulip/tulip_core.o
> drivers/net/tulip/tulip_core.c:118: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/tulip/tulip_core.c:119: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/tulip/tulip_core.c:120: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/tulip/tulip_core.c:121: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/tulip/tulip_core.c:122: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/tulip/tulip_core.c:123: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> 
> and:
> 
> drivers/net/mace.c:1050: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
>   CC [M]  drivers/net/3c59x.o
> drivers/net/3c59x.c:281: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:282: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:283: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:284: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:285: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:286: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:287: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:288: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:289: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:290: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:291: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:292: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:293: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:294: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> drivers/net/3c59x.c:295: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
> 
> 
> with -bk3. got the same ones in -bk2.
> 
> eric
> 

There's a project underway to convert those to module_param() (defined in 
include/linux/moduleparam.h) at kernel-janitors@lists.osdl.org - right now, it's 
not a critical problem.  Probably won't be corrected until after 2.6.10 is 
released - Linus is only accepting bugfixes right now.

Jim
