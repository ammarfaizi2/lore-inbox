Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317652AbSGOVc1>; Mon, 15 Jul 2002 17:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317651AbSGOVc1>; Mon, 15 Jul 2002 17:32:27 -0400
Received: from freenet1.carleton.ca ([134.117.136.20]:8104 "EHLO
	freenet.carleton.ca") by vger.kernel.org with ESMTP
	id <S317652AbSGOVcY>; Mon, 15 Jul 2002 17:32:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Richard Sembera <es034@freenet.carleton.ca>
Reply-To: es034@freenet.carleton.ca
To: linux-kernel@vger.kernel.org
Subject: 2.4.x kernels cause random launch of xscreensaver?
Date: Mon, 15 Jul 2002 17:26:00 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02071517260100.00186@cooper>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I asked around in the Slackware NG about this problem last week and got 
redirected here. I hope someone can help. I'm not subscribed to the mailing 
list so please cc me copies of your replies.

On Slackware 8.0, when I try to install the 2.4.5 kernel, I get a problem 
with X, namely, xscreensaver starts up at random intervals. Sometimes the 
problem shows up immedately, sometimes it takes longer (the longest period so 
far has been 2 days). While I'm working, xscreensaver will suddenly go off, 
complain about not being able to grab the mose pointer, and launch a random 
screen saver. After typing in my password to unlock the screen, xscreensaver 
launches again after an interval of about 2-10 seconds.

If I disable xscreensaver in my .xinitrc file (or try fvwm2 instead of my 
standard xfce), then instead of xscreensaver I just get a blank screen, as if 
there were no video signal. Moving the mouse gets me a normal display, but at 
2-5 second intervals the screen will simply black out as described.

I've tried installing the 2.4.18 kernel but got the same problem. The 2.2.19 
kernel works just fine, however. I've also experienced the same problem with 
SuSE 7.1 and a 2.4.0 kernel.

It was suggested in the Slackware NG that it might be a clock problem. I do 
have the "clock timer configuration lost--probably a VIA686" message coming 
up intermittently at boot time and during shutdown, although I don't have a 
VIA chipset (in fact, this is why I switched to Slack, which by default 
doesn't log or display kernel messages).

I hope someone can offer suggestions or advice. I'm including as much 
trechnical information as seems relevant, though I'm just a hobbyist, so 
please ask if something's not quite clear.

Thanks in advance,

Richard Sembera.

Technical Info:

Monitor: old 14" el cheapo non-PnP

Graphics Card: (SuperProbe output):
	First video: Super-VGA
        Chipset: S3 ViRGE/DX (PCI Probed)
        Memory:  4096 Kbytes
        RAMDAC:  Generic 8-bit pseudo-color DAC
                 (with 6-bit wide lookup tables (or in 6-bit mode))

Mouse: standard serial mouse on ttyS0

CPU: Intel Pentium MMX 166 MHz

Motherboard: AOpenAP57
Chipset: SiS 5571 PCIset
(I recall that there is an issue with these boards, they were supposed to be 
USB-enabled, but the company goofed something up and they were sold as 
non-USB boards. See below:)

lspci -v output:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5571
	Flags: bus master, medium devsel, latency 255

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
	Flags: bus master, medium devsel, latency 0

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev c0) 
(prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device 0058:0000
	Flags: bus master, fast devsel, latency 64, IRQ 14
	I/O ports at 01f0
	I/O ports at 03f4
	I/O ports at 0170
	I/O ports at 0374
	I/O ports at 4000

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev b0) 
(prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at e4000000 (32-bit, non-prefetchable)
	I/O ports at 6000

00:0c.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 
00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at e0000000 (32-bit, non-prefetchable)

-- 
Richard Sembera, Ph.D.
es034@ncf.carleton.ca
http://ncf.carleton.ca/~es034
