Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276622AbRJGTke>; Sun, 7 Oct 2001 15:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276632AbRJGTkZ>; Sun, 7 Oct 2001 15:40:25 -0400
Received: from peace.netnation.com ([204.174.223.2]:774 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S276622AbRJGTkJ>; Sun, 7 Oct 2001 15:40:09 -0400
Date: Sun, 7 Oct 2001 12:40:38 -0700
From: Simon Kirby <sim@netnation.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Greg KH <greg@kroah.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.11-pre5
Message-ID: <20011007124038.A22923@netnation.com>
In-Reply-To: <Pine.LNX.4.33.0110071148380.7382-100000@penguin.transmeta.com> <20011007121851.A1137@netnation.com> <20011007153433.G14479@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20011007153433.G14479@sventech.com>; from johannes@erdfelt.com on Sun, Oct 07, 2001 at 03:34:33PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 03:34:33PM -0400, Johannes Erdfelt wrote:

> > hub.c: USB new device connect on bus1/2, assigned device number 2
> > usb_control/bulk_msg: timeout
> > usb.c: USB device not accepting new address=2 (error=-110)
> 
> Could you give me the output of /proc/interrupts?

           CPU0       CPU1
  0:      71555      64454    IO-APIC-edge  timer
  1:       1355       1274    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:          0          0    IO-APIC-edge  NE2000
 14:       4157       5136    IO-APIC-edge  ide0
 15:          2         19    IO-APIC-edge  ide1
 16:       2462       2381   IO-APIC-level  eth0
 17:          0          0   IO-APIC-level  Trident 4DWave NX
 18:          1          1   IO-APIC-level  bttv
 19:       2330       2467   IO-APIC-level  aic7xxx, usb-uhci
NMI:          0          0
LOC:     135894     135912
ERR:          0
MIS:          0

> Do you see any other messages in dmesg?

Here is an entire "insmod uhci" output:

uhci.c: USB Universal Host Controller Interface driver v1.1
uhci.c: USB UHCI at I/O 0xb400, IRQ 19
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: USB new device connect on bus1/2, assigned device number 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: USB new device connect on bus1/2, assigned device number 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)

> What UHCI controller is this? (lspci -v)

00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at b400 [size=32]

It's on an ASUS P2B-DS (with broken USB resistor shorted).

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
