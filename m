Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272074AbRH2VPQ>; Wed, 29 Aug 2001 17:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272075AbRH2VPH>; Wed, 29 Aug 2001 17:15:07 -0400
Received: from donna.siteprotect.com ([64.41.120.44]:60681 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S272074AbRH2VOy>; Wed, 29 Aug 2001 17:14:54 -0400
Date: Wed, 29 Aug 2001 17:17:47 -0400 (EDT)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: <linux-kernel@vger.kernel.org>
Subject: Re: ALi USB Problems..similar to VIA ones?
In-Reply-To: <Pine.LNX.4.33.0108290120440.3566-100000@pianoman.cluster.toy>
Message-ID: <Pine.LNX.4.33.0108291713500.3566-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whoops, forgot to add the kernel output when you plug something in.

kernel 2.4.9, USB device is a generic USB keyboard.

hub.c: USB new device connect on bus1/1, assigned device number 2
usb_control/bulk_msg: timeout
usb-ohci.c: UNLINK URB:[89aa] dev: 0,ep: 0-O,type:CTRL,flags:
0,len:0/0,stat:-115(ffffff8d)
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: USB new device connect on bus1/1, assigned device number 3
usb_control/bulk_msg: timeout
usb-ohci.c: UNLINK URB:[9aa9] dev: 0,ep: 0-O,type:CTRL,flags:
0,len:0/0,stat:-115(ffffff8d)
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=3 (error=-110)

and proc interrupts looks like:

           CPU0
  0:   17550170          XT-PIC  timer
  1:     119155          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          1          XT-PIC  acpi, usb-ohci
 11:     301788          XT-PIC  Texas Instruments PCI1420, Texas
Instruments PCI1420 (#2), eth0
 12:     371142          XT-PIC  PS/2 Mouse
 14:      94279          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0
ERR:          0
MIS:          0


On Wed, 29 Aug 2001, John Clemens wrote:

>
> Hi,
>
> I already reported this to the usb list, but noone there seemed to know
> anything.  And given recent similar things mentioned on this list
> recently, I figured I'd try posting here.
>
> I've got an HP laptop with the ALi Magik1 (1647) chipset in it, and an
> OCHI USB controller (standard ALi 1535 southbridge).  Under Windows, USB
> works ok, but 'cuts out' for about 3-5 seconds every minute or so, as if
> it's resetting itself.  This seems eeriely similar to the VIA UHCI
> problems reported last week on this list, even though i know OHCI and UHCI
> should be nothing alike.
>
> Under Linux, both my USB joystick and my USB keyboard fail, and it appears
> that interrupts aren't getting through (/proc/interrupts shows 1
> interrupt, no matter how many times i plug and unplug things in and get
> URB timeouts).  This is a notebook, and the usb interrupt is shared with
> acpi. (irq 9).
>
> System information can be found at
> http://www.deater.net/john/PavilionN5430.html, with links to dmesg, lspci,
> and other information at the bottom of the page.  I would appreciate any
> help in tracking this one down.  I've tried kernels 2.4.5-2.4.9, and I'm
> willing to test or write any patches.
>
> john.c
>
>

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


