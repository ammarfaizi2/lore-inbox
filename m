Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293596AbSBZMXE>; Tue, 26 Feb 2002 07:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293595AbSBZMWy>; Tue, 26 Feb 2002 07:22:54 -0500
Received: from butterblume.comunit.net ([192.76.134.57]:25348 "EHLO
	butterblume.comunit.net") by vger.kernel.org with ESMTP
	id <S293593AbSBZMWq>; Tue, 26 Feb 2002 07:22:46 -0500
Date: Tue, 26 Feb 2002 13:22:43 +0100 (CET)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: linux-kernel@vger.kernel.org
cc: hermes@gibson.dropbear.id.au
Subject: Problems with orinoco_cs and i810_audio
Message-ID: <Pine.LNX.4.40.0202261314260.695-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi...

Keywords: Kernel 2.4.18-pre7, orinoco_cs and i810_audio,
	Toshiba Satellite Pro 4600 Built-In Wavelancard,
	IRQ Sharing

While playing streaming mp3 over the orinoco-network:

Feb 26 13:13:40 aurora kernel: i810_audio: Audio Controller supports 6
channels.
Feb 26 13:13:40 aurora kernel: ac97_codec: AC97 Audio codec, id:
0x594d:0x4800 (
Unknown)
Feb 26 13:13:40 aurora kernel: i810_audio: only 48Khz playback available.
Feb 26 13:13:40 aurora kernel: i810_audio: AC'97 codec 0 supports AMAP,
total ch
annels = 2
Feb 26 13:13:40 aurora kernel: ac97_codec: AC97 Modem codec, id:
0x5349:0x4c27 (
Unknown)
Feb 26 13:13:50 aurora kernel: i810_audio: timed out waiting for codec 1
analog
ready<4>eth1: Null event in orinoco_interrupt!
Feb 26 13:13:50 aurora kernel: eth1: Null event in orinoco_interrupt!
Feb 26 13:14:21 aurora last message repeated 2478 times
Feb 26 13:15:22 aurora last message repeated 4866 times
Feb 26 13:16:23 aurora last message repeated 4871 times
Feb 26 13:17:24 aurora last message repeated 5026 times


Both sound and net work, but my syslog is spammed with this message. The
same interrupt-message happens when I insert a pcmcia-card.
My bios seems to put every interrupt onto irq 11, and there is no setting
to move them somewhere else.

aurora:~# cat /proc/interrupts
           CPU0
  0:    4648825          XT-PIC  timer
  1:      32405          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
 11:     439062          XT-PIC  Texas Instruments PCI1410 PC card Cardbus
Controller, Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge
with ZV Support, Toshiba America Info Systems ToPIC95 PCI to Cardbus
Bridge with ZV Support (#2), usb-uhci, usb-uhci, orinoco_cs, Intel ICH2
 12:     927659          XT-PIC  PS/2 Mouse
 14:     132987          XT-PIC  ide0
 15:          0          XT-PIC  ide1
NMI:          0
ERR:          0

Please ask if you need more informations

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

