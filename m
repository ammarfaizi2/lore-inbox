Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135786AbRD2OzU>; Sun, 29 Apr 2001 10:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135790AbRD2OzL>; Sun, 29 Apr 2001 10:55:11 -0400
Received: from dutidad.twi.tudelft.nl ([130.161.158.199]:16524 "EHLO dutidad")
	by vger.kernel.org with ESMTP id <S135786AbRD2OzD>;
	Sun, 29 Apr 2001 10:55:03 -0400
Date: Sun, 29 Apr 2001 16:55:01 +0200
From: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 Sound corruption
Message-ID: <20010429165501.A7545@dutidad.twi.tudelft.nl>
Reply-To: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

2.4.4 has broken sound here in a very strange way.  I have a debian testing
system, Abit KT7 (thus VIA KT133 chipset) and SB PC128 (es1371-based) sound
card.

Up until 2.4.3 everything was fine.  Now, however, when I send _anything_ to
/dev/dsp, I get continuous high-pitched beeping (nothing remotely resembling
what the sound card should be doing).  

The strange thing is that when I cause hard disk activity (find / -name "*")
the correct sound is produced in time with hard disc accesses (I have tried
this with DMA enabled and disabled on the drive, same results).  Also, when I
switch desktops (icewm, XFree86 4.0.2, Nvidia 0.9.767 drivers) the correct
sound is (very) momentarily produced (almost non-detectibly).  After these
periods of lucidity, the sound card returns to its high-pitched cacophony.

I have attached copies of both /proc/interrupts and /proc/pci.  If anyone
requires more information, please say the word.  I am not subscribed to this
list.

Best regards,

-- 
charl p. botha      | computer graphics and cad/cam 
http://cpbotha.net/ | http://www.cg.its.tudelft.nl/

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=proc_interrupts

           CPU0       
  0:     320161          XT-PIC  timer
  1:      19658          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  usb-uhci, usb-uhci
 10:     272660          XT-PIC  nvidia
 11:      93973          XT-PIC  eth0, es1371
 12:      42760          XT-PIC  PS/2 Mouse
 14:      39388          XT-PIC  ide0
 15:          5          XT-PIC  ide1
NMI:          0 
ERR:          0

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=proc_pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 3).
      Prefetchable 32 bit memory at 0xd8000000 [0xdbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 34).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
      Master Capable.  Latency=32.  
      I/O at 0xd000 [0xd00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 16).
      IRQ 9.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 16).
      IRQ 9.
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd81f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 48).
      IRQ 11.
  Bus  0, device   8, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 (rev 17).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xde000000 [0xde000fff].
  Bus  0, device   8, function  1:
    Multimedia controller: Brooktree Corporation Bt878 (rev 17).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xde001000 [0xde001fff].
  Bus  0, device   9, function  0:
    Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev 16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xdc00 [0xdcff].
      Non-prefetchable 32 bit memory at 0xde002000 [0xde0020ff].
  Bus  0, device  13, function  0:
    Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 8).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xe000 [0xe03f].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV11 (rev 161).
      IRQ 10.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xdc000000 [0xdcffffff].
      Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].

--W/nzBZO5zC0uMSeA--
