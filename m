Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270375AbTHBVrs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 17:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270378AbTHBVrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 17:47:47 -0400
Received: from [66.212.224.118] ([66.212.224.118]:5381 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270375AbTHBVrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 17:47:07 -0400
Date: Sat, 2 Aug 2003 16:57:00 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Carsten Otto <c-otto@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e1000 statistics timer
In-Reply-To: <3F2C14BF.9060505@gmx.de>
Message-ID: <Pine.LNX.4.53.0308021651120.3473@montezuma.mastecende.com>
References: <3F2C14BF.9060505@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Aug 2003, Carsten Otto wrote:

> "mod_timer(&adapter->watchdog_timer, jiffies + 2* HZ);"

> "mod_timer(&adapter->watchdog_timer, HZ);"

After HZ jiffies have passed you're adding a timer to trigger in the past.

> Now my questions:
> 1) Is my implementation right? It works...

That is often the case with lots of software, it may be wrong but by 
$DEITY's gracious hand, still 'works'

> 2) Can I change that delay to 1 sec withhout "hurting someone"?

Dunno, try jiffies + HZ, they're just statistics

> 3) What are these jiffies? Mathematically they are about 20 :>

jiffies is the global variable which stores how many timer ticks have 
occured since system startup.

> 4) There are other timers in the code, that use "jiffies + 2 * HZ" too. 
> Should they  be changed, too?

Nooo!! =)

> IMPORTANT:
> Please answer to c-otto@gmx.de, because I don't get the whole LKML.

Have fun,
	Zwane

-- 
function.linuxpower.ca
