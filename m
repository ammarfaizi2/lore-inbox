Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267566AbTA3RcL>; Thu, 30 Jan 2003 12:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267568AbTA3RcL>; Thu, 30 Jan 2003 12:32:11 -0500
Received: from hermes.cicese.mx ([158.97.1.34]:23208 "EHLO hermes.cicese.mx")
	by vger.kernel.org with ESMTP id <S267566AbTA3RcH>;
	Thu, 30 Jan 2003 12:32:07 -0500
Message-ID: <3E3963AF.8482B561@cicese.mx>
Date: Thu, 30 Jan 2003 09:41:03 -0800
From: Serguei Miridonov <mirsev@cicese.mx>
Organization: CICESE Research Center, Ensenada, B.C., Mexico
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Hirling Endre <endre@interware.hu>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: any brand recomendation for a linux laptop ?
References: <200301161100.45552.Nicolas.Turro@sophia.inria.fr>
		 <20030116113825.GB21239@codemonkey.org.uk>  <3E36A91F.8F1168DB@cicese.mx> <1043944207.4912.6.camel@dusk.interware.hu>
Content-Type: multipart/mixed;
 boundary="------------4D2B8B25F12CAA7C3520A27C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4D2B8B25F12CAA7C3520A27C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hirling Endre wrote:

> On Tue, 2003-01-28 at 17:00, Serguei Miridonov wrote:
> > I'm writing this in Compaq Presario 900Z which seems to be similar to your Evo
> > 1015v. After installing RedHat 7.3 with nomce, nopci, etc. I've disabled kudzu and
> > then compiled 2.4.20+ac2+acpi-20021212-2.4.20 with sound and IDE fixes. Now I have
> > UDMA IDE, sound, and 802.11b with prism card (actually I'm writing this at home on
>
> What IDE controller is in the 900z?

Complete /proc/pci is in the attached file...

> I have a fujitsu notebook with the
> igp320m chipset and ali southbridge and 2.5 can't do udma. 2.4 can but
> crashes often.

Have you applied sound fix? This is what I did:

1. Got stock 2.4.20 kernel;
2. Applied ac2 patch;
3. Applied ALI sound patch (discussed here recently);
4. Applied acpi-20021212 patch (some manual work needed after previous patches);
5. Reenabled IDE UDMA (ALI IDE support which was disabled in ac2 patch);

Then I've copied RedHat's 7.3 updated
/usr/src/linux-2.4.18-18.7.x/configs/kernel-2.4.18-athlon.config to .config  in the new
kernel directory and run 'make oldconfig' enabling new ACPI.

After kernel compilation and installation I have almost all features enabled.

--
Serguei Miridonov                CICESE, Research Center,
CICESE, Optics Dept.             Ensenada B.C., Mexico
PO Box 434944                    E-mail: mirsev@cicese.mx
San Diego, CA 92143-4944         FAX: +52 (646) 1750553
U.S.A.



--------------4D2B8B25F12CAA7C3520A27C
Content-Type: text/plain; charset=us-ascii;
 name="compaq-pci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compaq-pci"

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 1002:cab0 (ATI Technologies Inc) (rev 19).
      Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
      Prefetchable 32 bit memory at 0xf4400000 [0xf4400fff].
      I/O at 0x8090 [0x8093].
  Bus  0, device   1, function  0:
    PCI bridge: PCI device 1002:700f (ATI Technologies Inc) (rev 1).
      Master Capable.  Latency=99.  Min Gnt=12.
  Bus  0, device   2, function  0:
    USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 3).
      IRQ 11.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xf4010000 [0xf4010fff].
  Bus  0, device  15, function  0:
    USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (#2) (rev 3).
      IRQ 11.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xf4012000 [0xf4012fff].
  Bus  0, device   7, function  0:
    ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev 0).
  Bus  0, device   8, function  0:
    Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device (rev 2).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0x8400 [0x84ff].
      Non-prefetchable 32 bit memory at 0xf4011000 [0xf4011fff].
  Bus  0, device  10, function  0:
    CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 2).
      IRQ 5.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0xffbfe000 [0xffbfefff].
  Bus  0, device  11, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 32).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0x8800 [0x88ff].
      Non-prefetchable 32 bit memory at 0xf4013000 [0xf40130ff].
  Bus  0, device  12, function  0:
    Communication controller: Conexant HSF 56k HSFi Modem (rev 1).
      IRQ 10.
      Master Capable.  Latency=64.
      Non-prefetchable 32 bit memory at 0xf4000000 [0xf400ffff].
      I/O at 0x8098 [0x809f].
  Bus  0, device  16, function  0:
    IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 196).
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0x8080 [0x808f].
  Bus  0, device  17, function  0:
    Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 0).
  Bus  1, device   5, function  0:
    VGA compatible controller: PCI device 1002:4336 (ATI Technologies Inc) (rev 0).
      IRQ 10.
      Master Capable.  Latency=66.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xf6000000 [0xf7ffffff].
      I/O at 0x9000 [0x90ff].
      Non-prefetchable 32 bit memory at 0xf4100000 [0xf410ffff].

--------------4D2B8B25F12CAA7C3520A27C--

