Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267412AbTBLSKw>; Wed, 12 Feb 2003 13:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267414AbTBLSKv>; Wed, 12 Feb 2003 13:10:51 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:7684
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267412AbTBLSKo>; Wed, 12 Feb 2003 13:10:44 -0500
Date: Wed, 12 Feb 2003 13:21:27 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: was Re: [2.4.20][2.5.60] /proc/interrupts - Now: ACPI moving of IRQs
In-Reply-To: <3E4A8F9C.5080107@blue-labs.org>
Message-ID: <Pine.LNX.4.44.0302121319360.315-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see that you see APIC level

           CPU0
  0:   12194031          XT-PIC  timer
  1:         15          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:        149          XT-PIC  serial
  5:          0          XT-PIC  soundblaster
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:         20          XT-PIC  aic7xxx
 11:      49135          XT-PIC  uhci-hcd, eth0
 12:         60          XT-PIC  i8042
 14:       6082          XT-PIC  ide0
 15:          9          XT-PIC  ide1
NMI:          0
LOC:   12193302
ERR:          0
MIS:          0


Since this box has ACPI why didn't it move the PCI SCSI controller
(aic7xxx) to a higher IRQ?

I thought this would happen with ACPI enabled?

Shawn.


On Wed, 12 Feb 2003, David Ford wrote:

> Most semi-modern devices can share quite well.
>
> $ cat /proc/interrupts
>            CPU0
>   0:    6125690          XT-PIC  timer
>   1:       1326          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   4:      10331          XT-PIC  serial
>   8:          2          XT-PIC  rtc
>   9:         12          XT-PIC  acpi
>  11:       9073          XT-PIC  ohci1394, Texas Instruments PCI4451 PC
> card Cardbus Controller, Texas Instruments PCI4451 PC card Cardbus
> Controller (#2), Texas Instruments PCI1410 PC card Cardbus Controller,
> usb-uhci, usb-uhci, orinoco_cs, eth0
>  14:       5557          XT-PIC  ide0
> NMI:          0
> LOC:          0
> ERR:          0
> MIS:          0
>
> $ cat /proc/interrupts
>            CPU0       CPU1
>   0:  120673941  122176068    IO-APIC-edge  timer
>   2:          0          0          XT-PIC  cascade
>   8:          1          1    IO-APIC-edge  rtc
>  11:     630755     642282   IO-APIC-level  aic7xxx, aic7xxx
>  14:    6545133    6566711   IO-APIC-level  eth0
>  15:     300184     300649   IO-APIC-level  megaraid
> NMI:          0          0
> LOC:  242861052  242861124
> ERR:          0
> MIS:          0
>
> $ cat /proc/interrupts
>            CPU0
>   0:    3888568          XT-PIC  timer
>   1:       7458          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   7:     265929          XT-PIC  uhci-hcd, uhci-hcd, eth0
>   8:          2          XT-PIC  rtc
>   9:          1          XT-PIC  acpi
>  10:         45          XT-PIC  sym53c8xx
>  11:       6143          XT-PIC  sym53c8xx, sym53c8xx, CS46XX
>  12:        355          XT-PIC  i8042
>  14:          6          XT-PIC  ide0
>  15:          9          XT-PIC  ide1
> NMI:          0
> LOC:    3878160
> ERR:       1664
> MIS:          0
>
>
>  :)
>
> Take care,
> David
>
> --
> I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.
>
> When it absolutely, positively, has to be destroyed overnight.
>                            AIR FORCE
>
>
>
>

