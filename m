Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbUB0VDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbUB0VDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:03:38 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:22658 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263123AbUB0VAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:00:15 -0500
Date: Fri, 27 Feb 2004 22:00:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.3] Mouse loosing sync (again)
Message-ID: <20040227210057.GA924@ucw.cz>
References: <20040227201441.GA19946@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227201441.GA19946@dreamland.darkstar.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 09:14:41PM +0100, Kronos wrote:
> Hi,
> I still have troubles with mouse, it keeps jumping here and there and I
> see lots of messages in logs:
> 
> Feb 27 20:49:55 dreamland kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
> Feb 27 20:50:42 dreamland kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
> Feb 27 20:51:11 dreamland kernel: psmouse.c: bad data from KBC - bad parity
> Feb 27 20:51:11 dreamland kernel: psmouse.c: bad data from KBC - bad parity
> Feb 27 20:51:12 dreamland kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
> Feb 27 20:55:32 dreamland kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
> Feb 27 20:58:38 dreamland kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
> 
> These happened while surfing web with little activity on eth0 and while disks
> were almost idle (-u1 is set on both of them). Using vmstat I see that
> I'm getting around 1300 interrupts per second while moving mouse (less
> than 1100 while doing nothing), so I don't think that there's something 
> spinning in ISR for too long.
> 
> Problem first appeared in 2.6.2, 2.6.1 is unaffected. I see that in
> 2.6.3 there's a patch which is supposed to fix this, but it still
> happens for me.
> 
> Any clue?

The bad parity messages definitely suggest a problem with the mouse
cable - either too long or broken.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
