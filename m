Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282670AbRK0ATV>; Mon, 26 Nov 2001 19:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282668AbRK0ATM>; Mon, 26 Nov 2001 19:19:12 -0500
Received: from domino1.resilience.com ([209.245.157.33]:29834 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S282666AbRK0AS5>; Mon, 26 Nov 2001 19:18:57 -0500
Mime-Version: 1.0
Message-Id: <p05100301b82887aff497@[207.213.214.37]>
In-Reply-To: <002f01c176d4$f79a3f70$0201a8c0@HOMER>
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de>
 <20011124103642.A32278@vega.ipal.net>
 <20011124184119.C12133@emma1.emma.line.org>
 <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de>
 <4.3.2.7.2.20011124150445.00bd4240@10.1.1.42>
 <3C002D41.9030708@zytor.com> <0f050uosh4lak5fl1r07bs3t1ecdonc4c0@4ax.com>
 <002f01c176d4$f79a3f70$0201a8c0@HOMER>
Date: Mon, 26 Nov 2001 16:18:15 -0800
To: "Martin Eriksson" <nitrax@giron.wox.org>,
        "Steve Brueggeman" <xioborg@yahoo.com>, <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Journaling pointless with today's hard disks?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:49 AM +0100 11/27/01, Martin Eriksson wrote:
>I sure think the drives could afford the teeny-weeny cost of a power failure
>detection unit, that when a power loss/sway is detected, halts all
>operations to the platters except for the writing of the current sector.

That's hard to do. You really need to do the power-fail detection on 
the AC line, or have some sort of energy storage and a dc-dc 
converter, which is expensive. If you simply detect a drop in dc 
power, there simply isn't enough margin to reliably write a block.

Years (many years) back, Diablo had a short-lived model (400, IIRC) 
that had an interesting twist on this. On a power failure, the 
spinning disk (this was in the days of 14" platters, so plenty of 
energy) drove the spindle motor as a generator, providing power to 
the drive electronics for several seconds before it spun down to 
below operating speed.

Of course, that was in the days of thousands of dollars for maybe 
20MB of storage....
-- 
/Jonathan Lundell.
