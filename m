Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264432AbUFRVP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbUFRVP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUFRVMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:12:46 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:31247 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264432AbUFRVJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:09:51 -0400
Date: Fri, 18 Jun 2004 23:10:31 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: vandrove@vc.cvut.cz
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Matroxfb in 2.6 still doesn't work in 2.6.7
Message-ID: <20040618211031.GA4048@irc.pl>
Mail-Followup-To: vandrove@vc.cvut.cz,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

I am constantly having problems with my G550 matrox card.
I'm trying to get same video mode in framebuffer as in XFree.
I'm using 1280x1024x16 in XFree but this mode in fb don't work.
My LCD monitor turns black and slowly change into all white.
There is some very bright white area in lower right corner of monitor.

% dmesg | grep -i matrox
Kernel command line: root=/dev/hda4 acpi=force ro video=matroxfb:1280x1024-16@60
matroxfb: Matrox G550 detected
matroxfb: MTRR's turned on
matroxfb: 1280x1024x16bpp (virtual: 1280x6553)
matroxfb: framebuffer at 0xE8000000, mapped to 0xd080b000, size 33554432
fb0: MATROX frame buffer device
[drm] Initialized mga 3.1.0 20021029 on minor 0: Matrox Graphics, Inc. MGA G550 AGP
matroxfb_crtc2: secondary head of fb0 was registered as fb1


 Modeline used by XFree (if it helps):
(**) MGA(0): *Default mode "1280x1024": 108.0 MHz, 64.0 kHz, 60.0 Hz
(II) MGA(0): Modeline "1280x1024"  108.00  1280 1328 1440 1688  1024 1025 1028 1066 +hs
ync +vsync

 My card is:
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at e8000000 (32-bit, prefetchable) [size=32M]
        Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
        Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0

 I have LCD plugged into analog output (my LCD does not have DVI in).

 It stopped working somewhere in 2.5.x series. It still doesn't
work in
Linux version 2.6.7 (zdzichu@mother) (gcc version 3.4.0) #1 Fri Jun 18 22:39:14 CEST 2004

-- 
Tomasz Torcz                 "God, root, what's the difference?" 
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."   

