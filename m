Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTE3NUh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 09:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263643AbTE3NUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 09:20:37 -0400
Received: from 143.153-136-217.adsl.skynet.be ([217.136.153.143]:27407 "EHLO
	gw.ici") by vger.kernel.org with ESMTP id S263642AbTE3NUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 09:20:35 -0400
Message-ID: <3ED75D75.2010302@trollprod.org>
Date: Fri, 30 May 2003 15:32:37 +0200
From: Olivier NICOLAS <olivn@trollprod.org>
Organization: TrollPod
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.7.50 : irq17: nobody cared! 
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel:
	2.5.70 (gcc 3.3)

hw:
	Bi Athlon 1800 MP
	MSI K7D mb
	512 Mb RAM
	IDE


irq 17: nobody cared!
Call Trace:
  [handle_IRQ_event+127/256] handle_IRQ_event+0x7f/0x100
  [<c010bb4f>] handle_IRQ_event+0x7f/0x100
  [do_IRQ+221/544] do_IRQ+0xdd/0x220
  [<c010be9d>] do_IRQ+0xdd/0x220
  [common_interrupt+24/32] common_interrupt+0x18/0x20
  [<c010a160>] common_interrupt+0x18/0x20
  [_end+543529348/1069646152] snd_pcm_playback_drop+0x14c/0x240 [snd_pcm]
  [<e0a3f83c>] snd_pcm_playback_drop+0x14c/0x240 [snd_pcm]
  [_end+543539281/1069646152] snd_pcm_playback_ioctl1+0x159/0x3f0 [snd_pcm]
  [<e0a41f09>] snd_pcm_playback_ioctl1+0x159/0x3f0 [snd_pcm]
  [sys_select+903/1152] sys_select+0x387/0x480
  [<c0171af7>] sys_select+0x387/0x480
  [scheduler_tick+213/944] scheduler_tick+0xd5/0x3b0
  [<c011b8d5>] scheduler_tick+0xd5/0x3b0
  [vfs_read+181/288] vfs_read+0xb5/0x120
  [<c015bca5>] vfs_read+0xb5/0x120
  [sys_ioctl+681/825] sys_ioctl+0x2a9/0x339
  [<c0170be9>] sys_ioctl+0x2a9/0x339
  [syscall_call+7/11] syscall_call+0x7/0xb
  [<c01097f3>] syscall_call+0x7/0xb

handlers:
[e100intr+0/784] (e100intr+0x0/0x310)
[<c024aa70>] (e100intr+0x0/0x310)
[_end+543443912/1069646152] (snd_intel8x0_interrupt+0x0/0x280 
[snd_intel8x0])
[<e0a2aa80>] (snd_intel8x0_interrupt+0x0/0x280 [snd_intel8x0])
irq 17: nobody cared!
Call Trace:
  [handle_IRQ_event+127/256] handle_IRQ_event+0x7f/0x100
  [<c010bb4f>] handle_IRQ_event+0x7f/0x100
  [do_IRQ+221/544] do_IRQ+0xdd/0x220
  [<c010be9d>] do_IRQ+0xdd/0x220
  [schedule+273/1488] schedule+0x111/0x5d0
  [<c011bcd1>] schedule+0x111/0x5d0
  [default_idle+0/64] default_idle+0x0/0x40
  [<c0107170>] default_idle+0x0/0x40
  [common_interrupt+24/32] common_interrupt+0x18/0x20
  [<c010a160>] common_interrupt+0x18/0x20
  [default_idle+0/64] default_idle+0x0/0x40
  [<c0107170>] default_idle+0x0/0x40
  [default_idle+47/64] default_idle+0x2f/0x40
  [<c010719f>] default_idle+0x2f/0x40
  [cpu_idle+69/96] cpu_idle+0x45/0x60
  [<c0107235>] cpu_idle+0x45/0x60
  [rest_init+0/128] _stext+0x0/0x80
  [<c0105000>] _stext+0x0/0x80
  [start_kernel+362/416] start_kernel+0x16a/0x1a0
  [<c036892a>] start_kernel+0x16a/0x1a0
  [unknown_bootoption+0/272] unknown_bootoption+0x0/0x110
  [<c03684e0>] unknown_bootoption+0x0/0x110

handlers:
[e100intr+0/784] (e100intr+0x0/0x310)
[<c024aa70>] (e100intr+0x0/0x310)
[_end+543443912/1069646152] (snd_intel8x0_interrupt+0x0/0x280 
[snd_intel8x0])
[<e0a2aa80>] (snd_intel8x0_interrupt+0x0/0x280 [snd_intel8x0])


... sys_nanosleep+0x80/0xf0
  [syscall_call+7/11] syscall_call+0x7/0xb
  [<c01097f3>] syscall_call+0x7/0xb




irq 17 seems to be shared between the sound card and the ethernet card


olivier@bia:~> cat /proc/interrupts
            CPU0       CPU1
   0:    5795201    5906792    IO-APIC-edge  timer
   1:      11253      11604    IO-APIC-edge  i8042
   2:          0          0          XT-PIC  cascade
   4:        388        336    IO-APIC-edge  serial
   8:    1540088    1484758    IO-APIC-edge  rtc
   9:          0          0   IO-APIC-level  acpi
  12:      48279      49740    IO-APIC-edge  i8042
  14:      92822      57795    IO-APIC-edge  ide0
  15:        658        498    IO-APIC-edge  ide1
  17:     146045     147677   IO-APIC-level  AMD AMD768, eth0
NMI:          0          0
LOC:   11701889   11701985
ERR:          0
MIS:          0

