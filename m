Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUBJUte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUBJUte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:49:34 -0500
Received: from proxy.quengel.org ([213.146.113.159]:59520 "EHLO
	gerlin1.hsp-law.de") by vger.kernel.org with ESMTP id S265955AbUBJUtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:49:25 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>,
       Lenar =?iso-8859-1?q?L=F5hmus?= <lenar@vision.ee>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: irq 7: nobody cared! (intel8x0 sound / 2.6.2-rc3-mm1)
References: <4023BEA8.5060306@vision.ee> <s5hd68o2ia7.wl@alsa2.suse.de>
	<4029143B.30408@vision.ee> <s5hvfmebvr4.wl@alsa2.suse.de>
	<m3hdxyyar8.fsf-news@hsp-law.de>
	<Pine.LNX.4.58.0402101221210.2128@home.osdl.org>
From: Ralf Gerbig <rge-news@quengel.org>
Date: 10 Feb 2004 21:49:19 +0100
In-Reply-To: <Pine.LNX.4.58.0402101221210.2128@home.osdl.org>
Message-ID: <m34qtyslrk.fsf-news@hsp-law.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moins,

* Linus Torvalds said:

> Can you add something like

> 	static int count = 10;
> 	if (count) {
> 		count--;
> 		printk("sound status = %08x (mask %08x)\n", 
> 			status, chip->int_sta_mask);
> 	}

> to just before the return?

> That should tell what the register contents are, and might be a clue
> about what event it thinks is active.


kernel: PCI: Setting latency timer of device 0000:00:06.0 to 64
kernel: sound status = 00000000 (mask 00000000)
kernel: sound status = 00000000 (mask 00000000)
kernel: sound status = 00300100 (mask 000000f0)
last message repeated 7 times
/sbin/hotplug[18871]: no runnable /etc/hotplug/sound.agent is installed
/sbin/hotplug[18886]: no runnable /etc/hotplug/sound.agent is installed
/sbin/hotplug[18878]: no runnable /etc/hotplug/sound.agent is installed
/sbin/hotplug[18885]: no runnable /etc/hotplug/sound.agent is installed
kernel: intel8x0_measure_ac97_clock: measured 49492 usecs
kernel: intel8x0: clocking to 47354
kernel: ALSA sound/pci/intel8x0.c:2787: joystick(s) found
/sbin/hotplug[18901]: no runnable /etc/hotplug/sound.agent is installed

playing a video with mplayer:

kernel: ALSA sound/core/pcm_lib.c:233: Unexpected hw_pointer value [2] (stream = 0, delta: -1108, max jitter = 4456): wrong interrupt acknowledge?
-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
