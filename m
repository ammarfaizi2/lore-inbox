Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbSKZHt6>; Tue, 26 Nov 2002 02:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbSKZHt6>; Tue, 26 Nov 2002 02:49:58 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:4
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S266292AbSKZHt4>; Tue, 26 Nov 2002 02:49:56 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM][SOUND][2.5] - ALSA & OSS cannot find SBAWE32 Card 
Date: Tue, 26 Nov 2002 02:58:05 -0500
User-Agent: KMail/1.5
Cc: alsa-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211260258.05564.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: all drivers compiled into kernel.

Spec of machine:

AP/AX53 AOpen Motherboard (Revision 4)
64MB RAM
Sound Blaster 32-AWE w/ CSP (2MB installed)
Pentium 233MMX 

Enabled:

[*] Plug and Play support
[*]   Plug and Play device name database
[*]   PnP Debug Messages
Protocols
[*]   ISA Plug and Play support (EXPERIMENTAL) 
[*]   Plug and Play BIOS support (EXPERIMENTAL)

dmesg 2.5 - OSS:
========
isapnp: Scanning for PnP cards...
isapnp: Card 'Creative SB32 PnP'
isapnp: 1 Plug & Play card detected total
pnp: Calling quirk for 01:01.00
pnp: SB audio device quirk - increasing port range
pnp: Calling quirk for 01:01.02
pnp: AWE32 quirk - adding two ports
.....
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: No ISAPnP cards found, trying standard ones...
sb: I/O, IRQ, and DMA are mandatory
AWE32: No ISAPnP cards found
AWE32: not detected

dmesg 2.5 - ALSA:
==============

isapnp: Scanning for PnP cards...
isapnp: Card 'Creative SB32 PnP'
isapnp: 1 Plug & Play card detected total
pnp: Calling quirk for 01:01.00
pnp: SB audio device quirk - increasing port range
pnp: Calling quirk for 01:01.02
pnp: AWE32 quirk - adding two ports
...
Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Sun Nov 10 19:48:18 2002 UTC).
request_module[snd-card-0]: not ready
request_module[snd-card-1]: not ready
request_module[snd-card-2]: not ready
request_module[snd-card-3]: not ready
request_module[snd-card-4]: not ready
request_module[snd-card-5]: not ready
request_module[snd-card-6]: not ready
request_module[snd-card-7]: not ready
ALSA device list:
   No soundcards found.

dmesg 2.4.20-pre7 - OSS: - WORKS
============================

isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB32 PnP'
isapnp: 1 Plug & Play card detected total
...
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB32 PnP detected
sb: ISAPnP reports 'Creative SB32 PnP' at i/o 0x220, irq 5, dma 1, 5
<Sound Blaster 16 (4.13)> at 0x220 irq 5 dma 1,5
<Sound Blaster 16> at 0x330 irq 5 dma 0,0
sb: 1 Soundblaster PnP card(s) found.
ISAPnP reports AWE32 WaveTable at i/o 0x620
<SoundBlaster EMU8000 (RAM2048k)>

--
Someone else I'm talking to is reporting the same problem :/. ISAPNP busted in 2.5? ;)

Shawn.
