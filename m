Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264353AbRFGHnz>; Thu, 7 Jun 2001 03:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264354AbRFGHnp>; Thu, 7 Jun 2001 03:43:45 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:21394 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S264353AbRFGHnd>; Thu, 7 Jun 2001 03:43:33 -0400
From: Miroslav Ruda <ruda@ics.muni.cz>
Message-Id: <200106070743.f577hQH31913@erebor.ics.muni.cz>
Subject: 2.4.5, VIA KT133, sound corruption
To: home@cpbotha.net, linux-kernel@vger.kernel.org
Date: Thu, 7 Jun 2001 09:43:26 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL71 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

 I have experienced similar problems to
http://lists.kernelnotes.de/linux-kernel/Week-of-Mon-20010430/002158.html

When I send _anything_ to /dev/dsp, I get continuous high-pitched beeping 
(nothing remotely resembling what the sound card should be doing).

I'm running 2.4.5 kernel with debian system, Abit KT7 (IA KT133 chipset) and
SB PC128 (es1371 driver). Similar to previous thread, removing VIA latency
patch - quirk_vialatency() in driver/pci/quirks.c works. The only problem is
that I probably have VT82C686B chipset (at least 
pci_read_config_byte(vt82c686, PCI_CLASS_REVISION, &rev) returns 0x40)
but patch makes problems on my board. Motherboard is just bought so it may 
be some newer version?

I have attached copy of /proc/pci.  If anyone requires more information, 
please sent me email. I am not subscribed to this list.
 
Best regards, 

                       Mirek Ruda

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 3).
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.  
      I/O at 0xd000 [0xd00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 22).
      IRQ 11.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 22).
      IRQ 11.
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd81f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
      IRQ 9.
  Bus  0, device  11, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 5).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Prefetchable 32 bit memory at 0xdb100000 [0xdb100fff].
      I/O at 0xdc00 [0xdc1f].
      Non-prefetchable 32 bit memory at 0xdb000000 [0xdb0fffff].
  Bus  0, device  13, function  0:
    Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 2).
      IRQ 12.
      Master Capable.  Latency=64.  Min Gnt=12.Max Lat=128.
      I/O at 0xe000 [0xe03f].
  Bus  1, device   0, function  0:
    VGA compatible controller: PCI device 1002:5446 (ATI Technologies Inc)
(rev 0).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xd4000000 [0xd7ffffff].
      I/O at 0xc000 [0xc0ff].
      Non-prefetchable 32 bit memory at 0xd9000000 [0xd9003fff].
