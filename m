Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbUB0URz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbUB0URv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:17:51 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:31316 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S263023AbUB0UOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:14:32 -0500
X-BrightmailFiltered: true
Date: Fri, 27 Feb 2004 21:14:41 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.3] Mouse loosing sync (again)
Message-ID: <20040227201441.GA19946@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I still have troubles with mouse, it keeps jumping here and there and I
see lots of messages in logs:

Feb 27 20:49:55 dreamland kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
Feb 27 20:50:42 dreamland kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
Feb 27 20:51:11 dreamland kernel: psmouse.c: bad data from KBC - bad parity
Feb 27 20:51:11 dreamland kernel: psmouse.c: bad data from KBC - bad parity
Feb 27 20:51:12 dreamland kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
Feb 27 20:55:32 dreamland kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
Feb 27 20:58:38 dreamland kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.

These happened while surfing web with little activity on eth0 and while disks
were almost idle (-u1 is set on both of them). Using vmstat I see that
I'm getting around 1300 interrupts per second while moving mouse (less
than 1100 while doing nothing), so I don't think that there's something 
spinning in ISR for too long.

Problem first appeared in 2.6.2, 2.6.1 is unaffected. I see that in
2.6.3 there's a patch which is supposed to fix this, but it still
happens for me.

Any clue?
Luca
-- 
Home: http://kronoz.cjb.net
La vasca da bagno fu inventata nel 1850, il telefono nel 1875.
Se fossi vissuto nel 1850, avrei potuto restare in vasca per 25 anni
senza sentir squillare il telefono
