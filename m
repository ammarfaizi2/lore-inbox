Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283481AbRK3Cvt>; Thu, 29 Nov 2001 21:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283483AbRK3Cvb>; Thu, 29 Nov 2001 21:51:31 -0500
Received: from net24-164-102-119.neo.rr.com ([24.164.102.119]:1673 "EHLO
	nova.qfire.net") by vger.kernel.org with ESMTP id <S283481AbRK3CvU>;
	Thu, 29 Nov 2001 21:51:20 -0500
From: James Cassidy <jcassidy@nova.qfire.net>
Date: Thu, 29 Nov 2001 21:50:57 -0500
To: linux-via@havoc.gtf.org, linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio doesn't play audio?
Message-ID: <20011129215057.A19542@qfire.net>
In-Reply-To: <20011129190617.A3975@codepoet.org> <3C06F125.A1D3EBD3@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C06F125.A1D3EBD3@mandrakesoft.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a similar problem with the 686b south bridge. The module loads
fine but no sound comes out. The alsa drivers don't work for this computer
either.

Via 686a audio driver 1.9.1
PCI: Found IRQ 11 for device 00:07.5
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
PCI: Sharing IRQ 11 with 00:0b.0
ac97_codec: AC97 Audio codec, id: 0x4144:0x5361 (Unknown)
via82cxxx: board #1 at 0x1000, IRQ 5

zahra:/home/jcassidy# cat /proc/interrupts 
           CPU0       
  0:    3078777          XT-PIC  timer
  1:      10593          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       1438          XT-PIC  ide2
  5:          0          XT-PIC  via82cxxx
  8:          1          XT-PIC  rtc
 10:          0          XT-PIC  acpi
 11:      26056          XT-PIC  Texas Instruments PCI1410 PC card Cardbus Controller, eth0
 12:      67491          XT-PIC  PS/2 Mouse
 14:       9866          XT-PIC  ide0
 15:          6          XT-PIC  ide1
NMI:          0 
ERR:          0

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
        Subsystem: Compaq Computer Corporation: Unknown device 0097
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at 1000 [size=256]
        Region 1: I/O ports at 1854 [size=4]
        Region 2: I/O ports at 1850 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



> You need ALSA drivers.
> 
> Via 686 audio is different from Via 8233 audio, and you have the
> latter.  The PCI ids were added to via82cxxx_audio, but they need to be
> removed since they apparently do not work (contrary to one report I
> received).
> 
> 	Jeff
> 
> 
> -- 
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
> 
