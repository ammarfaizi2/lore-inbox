Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272497AbVBFKH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272497AbVBFKH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 05:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272527AbVBFKH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 05:07:27 -0500
Received: from av1-2-sn4.m-sp.skanova.net ([81.228.10.115]:53140 "EHLO
	av1-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S272497AbVBFKHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 05:07:12 -0500
To: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1
References: <20050204103350.241a907a.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Feb 2005 11:07:09 +0100
In-Reply-To: <20050204103350.241a907a.akpm@osdl.org>
Message-ID: <m3d5vengs2.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/

It gives me a kernel panic at boot if I have CONFIG_FB_RADEON
enabled. If I also have CONFIG_FRAMEBUFFER_CONSOLE enabled, I get this
output:

        Unable to handle kernel NULL pointer dereference at virtual address 00000000
        ...
        PREEMPT
        ...
        EIP is a strncpy_from_user+0x33/0x47
        ...
        Call Trace:
         getname+0x69/0xa5
         sys_open+0x12/0xc6
         sysenter_past_esp+0x52/0x75
        ...
        Kernel panic - not syncing: Attempted to kill init!

If I don't have CONFIG_FRAMEBUFFER_CONSOLE enabled, I get a screen
with random junk and some blinking colored boxes, and the machine
hangs.

2.6.11-rc3 doesn't have this problem. When I boot that kernel, I get
these messages during boot:

Feb  6 02:27:31 r3000 kernel: radeonfb: Retreived PLL infos from BIOS
Feb  6 02:27:31 r3000 kernel: radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=215.00 Mhz, System=220.00 MHz
Feb  6 02:27:31 r3000 kernel: radeonfb: PLL min 20000 max 35000
Feb  6 02:27:31 r3000 kernel: Non-DDC laptop panel detected
Feb  6 02:27:31 r3000 kernel: radeonfb: Monitor 1 type LCD found
Feb  6 02:27:31 r3000 kernel: radeonfb: Monitor 2 type no found
Feb  6 02:27:31 r3000 kernel: radeonfb: panel ID string: LGP
Feb  6 02:27:31 r3000 kernel: radeonfb: detected LVDS panel size from BIOS: 1280x800
Feb  6 02:27:31 r3000 kernel: radeondb: BIOS provided dividers will be used
Feb  6 02:27:31 r3000 kernel: radeonfb: Power Management enabled for Mobility chipsets
Feb  6 02:27:31 r3000 kernel: Console: switching to colour frame buffer device 160x50
Feb  6 02:27:31 r3000 kernel: radeonfb: ATI Radeon \a  DDR SGRAM 64 MB

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
