Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbTL3V0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 16:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbTL3V0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 16:26:20 -0500
Received: from luli.rootdir.de ([213.133.108.222]:33739 "EHLO luli.rootdir.de")
	by vger.kernel.org with ESMTP id S265817AbTL3V0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 16:26:14 -0500
X-Qmail-Scanner-Mail-From: claas@rootdir.de via luli
X-Qmail-Scanner: 1.20 (Clear:RC:1(217.186.137.119):SA:0(0.0/5.0):. Processed in 0.257062 secs)
Date: Tue, 30 Dec 2003 22:26:09 +0100
From: Claas Langbehn <claas@rootdir.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0: atyfb broken
Message-ID: <20031230212609.GA4267@rootdir.de>
Reply-To: claas@rootdir.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-By: Fr Jan  2 20:25:05 CET 2004
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0 i686
X-No-archive: yes
X-Uptime: 20:25:05 up  9:00,  7 users,  load average: 0.00, 0.04, 0.03
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have got an HP omnibook 4150B. When booting with atyfb,
the kernel messages look great:

atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTAL, 230 MHz PLL, 50 Mhz MCLK
fb0: ATY Mach64 frame buffer device on PCI

But either the screen is black and I see only the cursor and Background
colors (CONFIG_FRAMEBUFFER_CONSOLE disabled), but X11 starts fine.


With CONFIG_FRAMEBUFFER_CONSOLE enabled it does not work at all:
I get a completely broken picture that is not syncing and blinking and so on.
Its completely useless. X11 will not work either :(


I enabled in the kernel config:
CONFIG_FB_ATY, CONFIG_FB_ATY_CT and CONFIG_FB_ATY_XL_INIT


lspci -v:
01:00.0 VGA compatible controller: 
    ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
    Subsystem: Hewlett-Packard Company: Unknown device 000a
    Flags: bus master, stepping, medium devsel, latency 66, IRQ 10
    Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
    I/O ports at e800 [size=256]
    Memory at fedfe000 (32-bit, non-prefetchable) [size=4K]
    Expansion ROM at <unassigned> [disabled] [size=128K]
    Capabilities: [50] AGP version 1.0
    Capabilities: [5c] Power Management version 1

According to dmesg and to the omnibook's manual the card shall have 8 MB
memory and not 16 MB as lspci is saying.



Regards, claas
