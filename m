Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269515AbRHQCyY>; Thu, 16 Aug 2001 22:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269535AbRHQCyQ>; Thu, 16 Aug 2001 22:54:16 -0400
Received: from blackhole.compendium-tech.com ([64.156.208.74]:46736 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S269515AbRHQCyC>; Thu, 16 Aug 2001 22:54:02 -0400
Date: Thu, 16 Aug 2001 19:54:13 -0700 (PDT)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
X-X-Sender: <kernel@sol.compendium-tech.com>
To: Justin A <justin@bouncybouncy.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM nuisance
In-Reply-To: <20010816202412.B20072@bouncybouncy.net>
Message-ID: <Pine.LNX.4.33.0108161948470.12406-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, Justin A wrote:

> case 'f':    /* F -- oom handlder _f_ree memory */
> 	printk("Run OOM Handler\n");
> 	oom_kill();
> 	break;

This causes a nasty ass BUG() to get asserted. I can trigger the OOM
killer normally, but if I trigger it using SysRq, it'll complain rather
loudly and kill the interrupt handler. It appears to kill the proper
process first, however.

If I get some time later on, I'll boot up my devel machine at home and get
this thing all squared away. It looks as though some sort of lock or
something is being held when it shouldnt be, and it's causing Bad
Things(tm) to happen. Either way, I'll figure it out at home (or when I
get back from vacation on Monday).

LMK what you think.

 Kelsey Hudson                                           khudson@ctica.com
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

