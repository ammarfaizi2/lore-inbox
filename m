Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbTD1PV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 11:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbTD1PV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 11:21:28 -0400
Received: from relay03.valueweb.net ([216.219.253.237]:61856 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id S261166AbTD1PV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 11:21:26 -0400
Message-ID: <3EAD49C0.1030701@coyotegulch.com>
Date: Mon, 28 Apr 2003 11:33:20 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.6x Sound frustration
References: <3EA9AC16.4070903@coyotegulch.com> <s5hr87myb6c.wl@alsa2.suse.de>
In-Reply-To: <s5hr87myb6c.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> if it's not the case, try to unmute and raise "Headphone" volume.
> some devices use True LINEOUT as the wave lineout.
> if this solves the problem, please let me know the output of
> "lspci -vv" and "lspci -nv" (for the sound deice only).

That didn't solve the problem, but here's the output anyway, in case 
it's of any use to you.

The output from lspci -vv (rewrapped for clarity)

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio 
(rev 04)
         Subsystem: Intel Corp.: Unknown device 4d44
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort-                <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 17
         Region 0: I/O ports at e800 [size=256]
         Region 1: I/O ports at ef00 [size=64]

And lspci -nv

00:1f.5 Class 0401: 8086:2445 (rev 04)
         Subsystem: 8086:4d44
         Flags: bus master, medium devsel, latency 0, IRQ 17
         I/O ports at e800 [size=256]
         I/O ports at ef00 [size=64]

The above was generated while running the 2.5.66 kernel. I've run 
several different mixers, looking for any unusual "

This morning, I compiled 2.5.68; while I'm running Rusty's latest 
modutils, I had many symbol errors when trying to compile sound support 
as modules.  With sound compiled into the kernel, the ALSA driver 
appeared to load, but none of the devices were created; when the boot 
tried to restore mixer settings, for example, it reported that the mixer 
could not be found.

Everything else on the system seems to work fine with both .66 and .68.

I have had sound working on this machine using Debian sid's stock 2.4.20 
kernel.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)


