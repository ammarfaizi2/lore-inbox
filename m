Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSGVJMx>; Mon, 22 Jul 2002 05:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSGVJMx>; Mon, 22 Jul 2002 05:12:53 -0400
Received: from s217-115-138-13.colo.hosteurope.de ([217.115.138.13]:11496 "EHLO
	mail.vomhagen.com") by vger.kernel.org with ESMTP
	id <S316599AbSGVJMw>; Mon, 22 Jul 2002 05:12:52 -0400
Message-ID: <3D3BCDB3.8000006@beamnet.de>
Date: Mon, 22 Jul 2002 11:17:39 +0200
From: Thomas Viehmann <tv@beamnet.de>
Organization: beamNet
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: FS problems with a7v266-e-Promise + UDMA + Raid 1 + ReiserFS when
 using USB or Sound (K 2.4.18)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I've been bitten by the following problem:
Im using an A7V266-E with an onboard promise contoller.
Ontop of that I use Linux-md in Raid 1 mode on the two Promise channels, 
usually with UDMA activated. My root filesystem is ReiserFS on md0. This 
worked fine for quite a while, however last month I tried to use the 
alsa-cmipci driver with the onboard sound, I got a crash and such 
terrible corruption that I decided to reinstall.
Now I've tried activating USB, which appears to be using IRQ 5 as do the 
two promise ports. The system crashed and when it came back up, my 
filesystem was warped from July to May, all newer files were lost.
Oh: To be able to boot the System, I've had to enable the promise bios, 
but did not activate raid there.

Any coments would be very appreciated. I'd be happy to provide more 
details, but it might be a couple of days to find out.
CC to me would be much appreciated.

Regards

Thomas


$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:06.0 Unknown mass storage controller: Promise Technology, Inc. 20265 
(rev 02)
00:0e.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871
00:0f.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
00:10.0 Network controller: AVM Audiovisuelles MKTG & Computer System 
GmbH A1 ISDN [Fritz] (rev 02)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1b)
01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) 
(rev b2)
$ cat /proc/ide/pdc202xx

                                 PDC20265 Chipset.
------------------------------- General Status 
---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 10 mA
Status Polling Period                : 4
Interrupt Check Status Polling Delay : 0
--------------- Primary Channel ---------------- Secondary Channel 
-------------
                 enabled                          enabled
66 Clocking     enabled                          disabled
            Mode PCI                         Mode PCI
                 FIFO Empty                       FIFO Empty
--------------- drive0 --------- drive1 -------- drive0 ---------- 
drive1 ------
DMA enabled:    no               no              no                yes
DMA Mode:       UDMA 4           UDMA 4          NOTSET            NOTSET
PIO Mode:       PIO 4            PIO 4           NOTSET            NOTSET



