Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129949AbRBJAnR>; Fri, 9 Feb 2001 19:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130151AbRBJAnH>; Fri, 9 Feb 2001 19:43:07 -0500
Received: from raven.toyota.com ([63.87.74.200]:64011 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S129949AbRBJAm4>;
	Fri, 9 Feb 2001 19:42:56 -0500
Message-ID: <3A848E8E.943540F@toyota.com>
Date: Fri, 09 Feb 2001 16:42:54 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Cavan <johnc@damncats.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mucho timeouts on USB
In-Reply-To: <3A8489DE.D8C2B80A@damncats.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a similar usb timeout message here
with an HP 5200C usb scanner, e.g:

usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout

My config:

AMD-K6 450 on ASUS P5 mb
256 MB RAM, Ali chipset
Red Hat 7.0 updated, kernel 2.4.1-ac8

jjs

John Cavan wrote:

> Hi,
>
> Just got a D-Link USB radio (R100) and I'm seeing lots of timeouts with
> it. I've seen this through the last few 2.4.1+ and -ac+ kernels.
>
> Current config:
>
> Dual P3-500 w/ 512mb of RAM
> Tyan Tiger 133 mobo with VIA chipset, onboard USB
> Kernel 2.4.1-ac9 compiled with egcs-1.1.2
>
> The only thing funky is that three devices are sharing an interrupt:
>
>            CPU0       CPU1
>   0:     216690     219652    IO-APIC-edge  timer
>   1:       3564       3816    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   3:          7         20    IO-APIC-edge  serial
>   5:       1017       1135   IO-APIC-level  EMU10K1
>   8:          0          1    IO-APIC-edge  rtc
>  11:      22978      22756   IO-APIC-level  aic7xxx, eth0, usb-uhci
>  12:      64220      63272    IO-APIC-edge  PS/2 Mouse
>  14:      12132      12810    IO-APIC-edge  ide0
>  15:          3         10    IO-APIC-edge  ide1
> NMI:     436327     436327
> LOC:     436151     436128
> ERR:          0
>
> The ethernet card is a 3Com 3c905, the SCSI card is Adaptec 7892B (19160
> card). No problems with either as far as I can tell, but one of these
> modules may not be playing nice with interrupt sharing.
>
> The messages:
>
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.251 $ time 17:33:47 Feb  9 2001
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 11
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> usb_control/bulk_msg: timeout
> usb.c: USB device not accepting new address=2 (error=-110)
> usb.c: USB device 3 (vend/prod 0x4b4/0x1002) is not claimed by any
> active driver.
> usb_control/bulk_msg: timeout
> usb.c: error getting string descriptor 0 (error=-110)
> usb_control/bulk_msg: timeout
> usb.c: error getting string descriptor 0 (error=-110)
> usb_control/bulk_msg: timeout
> usb.c: error getting string descriptor 0 (error=-110)
> usb_control/bulk_msg: timeout
> usb.c: error getting string descriptor 0 (error=-110)
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
