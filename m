Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281435AbRKEXoD>; Mon, 5 Nov 2001 18:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281436AbRKEXny>; Mon, 5 Nov 2001 18:43:54 -0500
Received: from addleston.eee.nott.ac.uk ([128.243.70.70]:52907 "HELO
	addleston.eee.nott.ac.uk") by vger.kernel.org with SMTP
	id <S281435AbRKEXni>; Mon, 5 Nov 2001 18:43:38 -0500
Date: Mon, 5 Nov 2001 23:43:35 +0000 (GMT)
From: Matthew Clark <matt@eee.nott.ac.uk>
X-X-Sender: <matt@perry>
To: <linux-kernel@vger.kernel.org>
Subject: PCI interrupts
Message-ID: <Pine.OSF.4.31.0111052332160.25619-100000@perry>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear kernel list,

I am writing a dev driver for a pci device and I am having some
difficultly getting the interrupts line.

As far as I understood the BIOS / kernel would sort out a unique
interrupt line for me which I could then get by registering with
the system.

In my development system the PCI card I am developing  the
driver for reports (from the PCI config region) that it is using
interrupt 5.  I can't register this interrupt as it is already
in use by the USB controller.


(a) should my card have a unique number- if so what should I
do?

(b) if it shouldn't have a unique number do I have to share the
interrupt (with the usb controller) or can I change it to
another address (by writing to the config space?)?
If I have to share it how do I do this- (my card will generate a
lot of interrupt traffic)?.

I have free interrupts and would prefer not to share the
interrrupt for this device.

Any help / suggestions gratefully received-

apologies if this is in the wrong place--


Thanks matt


snippet from lspci -v
.....
00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801AA USB
        Flags: bus master, medium devsel, latency 0, IRQ 5
......
01:05.0 DMA controller: PLX Technology, Inc. PCI <-> IOBus
Bridge (rev 02) (prog-if 00 [8237])
        Subsystem: PLX Technology, Inc. PCI <-> IOBus Bridge
        Flags: medium devsel, IRQ 5
......
Ignore the PLX PCI id- the card developers didn't get their own
number.....


cat /proc/interrupts

           CPU0
  0:    2099604          XT-PIC  timer
  1:       3541          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:         11          XT-PIC  serial
  4:       1537          XT-PIC  serial
  5:          0          XT-PIC  usb-uhci
  8:          1          XT-PIC  rtc
 11:     196886          XT-PIC  eth0, i810@PCI:0:1:0
 14:      13005          XT-PIC  ide0
 15:          0          XT-PIC  ide1
NMI:          0
ERR:          0

