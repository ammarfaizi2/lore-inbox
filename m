Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265988AbUBJTJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUBJTJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:09:34 -0500
Received: from proxy.quengel.org ([213.146.113.159]:42368 "EHLO
	gerlin1.hsp-law.de") by vger.kernel.org with ESMTP id S265988AbUBJTJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:09:27 -0500
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: irq 7: nobody cared! (intel8x0 sound / 2.6.2-rc3-mm1)
References: <4023BEA8.5060306@vision.ee> <s5hd68o2ia7.wl@alsa2.suse.de>
From: Ralf Gerbig <rge-news@quengel.org>
Date: 10 Feb 2004 20:09:22 +0100
In-Reply-To: <s5hd68o2ia7.wl@alsa2.suse.de>
Message-ID: <m3llnaycnx.fsf-news@hsp-law.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moins,

* On Mon, 09 Feb 2004 19:56:48 +0100, Takashi Iwai <tiwai@suse.de> said:

> could you check the status register value when this happens with the
> attached patch?

I'm not Lenar, but this is what I get upon module load:

Epox EP8RDA3 Mobo, nforce2, acpi, apic, preempt, 2.6.3-rc1-mm1

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)

21:     751435   IO-APIC-level  NVidia nForce2

line in -> line out (bttv) works fine, aplay just plays the first
snippet of sound a couple of times and then hangs.

 kernel: PCI: Setting latency timer of device 0000:00:06.0 to 64
 kernel: intel8x0: ignored irq, status = 0x0, sta_mask = 0x0
 kernel: intel8x0: ignored irq, status = 0x0, sta_mask = 0x0
 kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
 last message repeated 2377 times
 kernel: intel8x0: ignored irq, status = 0x300100,red irq, status = 0xred irq, status = 0x300100, sta_mask = 0xf0
 kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
 last message repeated 2146 times
 kernel: intel8x0: ignored irq, status = 0x3001red irq, status = 0x300100, sta_mask = 0xf0
 kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
 last message repeated 1863 times
 /sbin/hotplug[5795]: no runnable /etc/hotplug/sound.agent is installed
 /sbin/hotplug[5802]: no runnable /etc/hotplug/sound.agent is installed
 /sbin/hotplug[5810]: no runnable /etc/hotplug/sound.agent is installed
 /sbin/hotplug[5809]: no runnable /etc/hotplug/sound.agent is installed
 kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
 last message repeated 283 times
 kernel: red irred irq, status = 0x300100, sta_mask = 0xf0
 kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
 last message repeated 2146 times
 kernel: intel8x0: ignored irq, status = 0x300100, sta_mask =red irq, status = 0x300100, sta_mask = 0xf0
 kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
 last message repeated 481 times
 /sbin/hotplug[5825]: no runnable /etc/hotplug/sound.agent is installed
 kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
 last message repeated 1665 times
 kernel: rq, status = 0x300100, sta_mask = 0xf0
 kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
 last message repeated 2142 times
 kernel: irq 21: nobody cared!
 kernel: Call Trace:
 kernel:  [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
 kernel:  [<c010cc7a>] __report_bad_irq+0x2a/0x90
 kernel:  [note_interrupt+112/176] note_interrupt+0x70/0xb0
 kernel:  [<c010cd70>] note_interrupt+0x70/0xb0
 kernel:  [do_IRQ+304/320] do_IRQ+0x130/0x140
 kernel:  [<c010d060>] do_IRQ+0x130/0x140
 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
 kernel:  [<c0321d64>] common_interrupt+0x18/0x20
 kernel: 
 kernel: handlers:
 kernel: [_end+542335376/1069053776] (snd_intel8x0_interrupt+0x0/0x260 [snd_intel8x0])
 kernel: [<e09aba40>] (snd_intel8x0_interrupt+0x0/0x260 [snd_intel8x0])
 kernel: Disabling IRQ #21

without hotplug:

kernel: PCI: Setting latency timer of device 0000:00:06.0 to 64
kernel: intel8x0: ignored irq, status = 0x0, sta_mask = 0x0
kernel: intel8x0: ignored irq, status = 0x0, sta_mask = 0x0
kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
last message repeated 939 times
kernel: red irq, status = 0x300100, sta_mask = 0xf0
kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
last message repeated 2147 times
kernel: red irq, statured irq, status = 0x300100, sta_mask = 0xf0
kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
last message repeated 2146 times
kernel: intel8x0: ignored irq, status = 0x300100, stred irq, status = 0x300100, sta_mask = 0xf0
kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
last message repeated 2147 times
kernel: red irq, status = 0x300100, sta_mask = 0xf0
kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
last message repeated 2147 times
kernel: red irq, status = 0x300100, sta_mask = 0xf0
kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
last message repeated 981 times
kernel: intel8x0: ignored irq, status = 0x300100red irq, status = 0x300100, sta_mask = 0xf0
kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
last message repeated 1163 times
kernel: intel8x0: ignored irq, status = red irq, status = 0x300100, sta_mask = 0xf0
kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
last message repeated 2147 times
kernel: >intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
kernel: intel8x0: ignored irq, status = 0x300100, sta_mask = 0xf0
last message repeated 2134 times
kernel: irq 21: nobody cared!
kernel: Call Trace:
kernel:  [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
kernel:  [<c010cc7a>] __report_bad_irq+0x2a/0x90
kernel:  [note_interrupt+112/176] note_interrupt+0x70/0xb0
kernel:  [<c010cd70>] note_interrupt+0x70/0xb0
kernel:  [do_IRQ+304/320] do_IRQ+0x130/0x140
kernel:  [<c010d060>] do_IRQ+0x130/0x140
kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
kernel:  [<c0321d64>] common_interrupt+0x18/0x20
kernel:  [schedule+884/1456] schedule+0x374/0x5b0
kernel:  [<c011dff4>] schedule+0x374/0x5b0
kernel:  [preempt_schedule+54/96] preempt_schedule+0x36/0x60
kernel:  [<c011e266>] preempt_schedule+0x36/0x60
kernel:  [unix_dgram_sendmsg+872/1392] unix_dgram_sendmsg+0x368/0x570
kernel:  [<c031c518>] unix_dgram_sendmsg+0x368/0x570
kernel:  [call_console_drivers+101/288] call_console_drivers+0x65/0x120
kernel:  [<c01221b5>] call_console_drivers+0x65/0x120
kernel:  [call_console_drivers+101/288] call_console_drivers+0x65/0x120
kernel:  [<c01221b5>] call_console_drivers+0x65/0x120
kernel:  [sock_aio_write+191/240] sock_aio_write+0xbf/0xf0
kernel:  [<c02b8a3f>] sock_aio_write+0xbf/0xf0
kernel:  [do_sync_write+140/192] do_sync_write+0x8c/0xc0
kernel:  [<c0157d5c>] do_sync_write+0x8c/0xc0
kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
kernel:  [<c0321d64>] common_interrupt+0x18/0x20
kernel:  [vfs_write+254/304] vfs_write+0xfe/0x130
kernel:  [<c0157e8e>] vfs_write+0xfe/0x130
kernel:  [sys_write+66/112] sys_write+0x42/0x70
kernel:  [<c0157f72>] sys_write+0x42/0x70
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel:  [<c03213f7>] syscall_call+0x7/0xb
kernel: 
kernel: handlers:
kernel: [_end+542335376/1069053776] (snd_intel8x0_interrupt+0x0/0x260 [snd_intel8x0])
kernel: [<e09aba40>] (snd_intel8x0_interrupt+0x0/0x260 [snd_intel8x0])
kernel: Disabling IRQ #21

hope this helps,

Ralf
-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
