Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269151AbTGUBmt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 21:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269169AbTGUBmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 21:42:49 -0400
Received: from skamp.net1.nerim.net ([62.212.117.209]:1152 "EHLO tatooine")
	by vger.kernel.org with ESMTP id S269151AbTGUBmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 21:42:47 -0400
Message-ID: <3F1B47F3.60309@laposte.net>
Date: Mon, 21 Jul 2003 03:54:59 +0200
From: Guillaume Cocatre-Zilgien <guillaume.cocatre-zilgien@laposte.net>
Reply-To: guillaume.cocatre-zilgien@laposte.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030704 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: user feedback on 2.6.0-test1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been testing the new kernel for a few days, so I thought someone 
could use my feedback about it. I installed it on my Dell Latitude C400 
laptop, which has a jp-106 keyboard; see the output of lspci at the end.
http://www.cse.unsw.edu.au/~chak/linux/c400.html

Problems:
- the "pipe" key is not responding anymore in text mode (init 3), 
although it works in xterm. Pressing the key doesn't print out anything.
- music is skipping when using xmms under CPU load, only during the 
first seconds of each track (until the entire file is cached?). xmms 
NEVER skipped with kernel 2.4.20, even under heavy CPU load. My hard 
drive has DMA enabled.
- the cursor under XFree86 4.3.0 gets "jumpy" under CPU load; as with 
xmms, it never did that with kernel 2.4.20.
- monitoring ACPI status (with WM dockapps) is overly CPU intensive: it 
takes from 5% to 35% of the CPU!!! I did not test ACPI with the stable 
kernel, and I couln't tell if the problem lies in user-land applications...

Improvements:
- ripping audio CD's with cdparanoia and the new ide-cd driver is waaaay 
faster now, as expected (jumped from 2 - 3x to 10x and up). I didn't 
manage to get cdda2wav to work with that driver, though.
- XFree86 loads faster.
- glxgears shows 260 FPS now, versus 150 FPS with the older driver, with 
my i830M chipset (I assume I have to thank the new driver for that?). 
Quake III Arena didn't gain from it though, I don't know why.

I've switched back to kernel 2.4.21, mainly because I know better how to 
handle it than the new one. I'm eager to see the stable version of linux 
2.6.0.

I didn't subscribe to the ML, but I read the newsgroup, so there's no 
need to CC me.

lspci:
00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 03)
00:02.0 VGA compatible controller: Intel Corp. 82830 CGC [Chipset 
Graphics Controller] (rev 03)
00:02.1 Display controller: Intel Corp. 82830 CGC [Chipset Graphics 
Controller]
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 41)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio 
(rev 01)
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 01)
02:00.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 78)
02:01.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus 
Controller (rev 02)

Best regards to the kernel hackers,

-- 
Guillaume Cocatre-Zilgien
http://www.skamp.net/

