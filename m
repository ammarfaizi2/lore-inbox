Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276743AbRJKTZH>; Thu, 11 Oct 2001 15:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276716AbRJKTYw>; Thu, 11 Oct 2001 15:24:52 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:3598 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S276751AbRJKTYg>;
	Thu, 11 Oct 2001 15:24:36 -0400
Date: Thu, 11 Oct 2001 16:36:47 -0300
From: sergio@bruder.net
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: usb-uhci broken in 2.4.10-ac11?
Message-ID: <20011011163646.A4163@bruder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a USB printer that was working fine with 2.4.10-ac7.

Just switched to 2.4.10-ac11 and now I get the following at usb-uhci's
modprobe:

/var/log/messages
Oct 11 16:32:17 stratus kernel: usb-uhci.c: $Revision: 1.259 $ time 14:24:14 Oct 11 2001
Oct 11 16:32:17 stratus kernel: usb-uhci.c: High bandwidth mode enabled
Oct 11 16:32:17 stratus kernel: PCI: Found IRQ 10 for device 00:07.2
Oct 11 16:32:17 stratus kernel: usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 10
Oct 11 16:32:17 stratus kernel: usb-uhci.c: Detected 2 ports
Oct 11 16:32:17 stratus kernel: usb.c: new USB bus registered, assigned bus number 1
Oct 11 16:32:17 stratus kernel: hub.c: USB hub found
Oct 11 16:32:17 stratus kernel: hub.c: 2 ports detected
Oct 11 16:32:17 stratus kernel: usb-uhci.c: v1.251:USB Universal Host Controller Interface driver
Oct 11 16:32:17 stratus kernel: hub.c: USB new device connect on bus1/1, assigned device number 2
Oct 11 16:32:20 stratus kernel: usb_control/bulk_msg: timeout
Oct 11 16:32:20 stratus kernel: usb.c: USB device not accepting new address=2 (error=-110)
Oct 11 16:32:21 stratus kernel: hub.c: USB new device connect on bus1/1, assigned device number 3
Oct 11 16:32:24 stratus kernel: usb_control/bulk_msg: timeout
Oct 11 16:32:24 stratus kernel: usb.c: USB device not accepting new address=3 (error=-110)

/proc/interrupts
           CPU0
  0:     727719          XT-PIC  timer
  1:      14394          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:      56134          XT-PIC  serial
 10:      10449          XT-PIC  usb-uhci
 11:      21430          XT-PIC  eth0
 14:      45469          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0
ERR:          0


NOTE: via82cxxx_audio is using the same IRQ (10) when loaded. But the error is
the same with or without via82cxxx.


Sergio Bruder
--
http://pontobr.org, http://sergio.bruder.net, http://bruder.homeip.net:81
-----------------------------------------------------------------------------
pub  1024D/0C7D9F49 2000-05-26 Sergio Devojno Bruder <sergio@bruder.net>
     Key fingerprint = 983F DBDF FB53 FE55 87DF  71CA 6B01 5E44 0C7D 9F49
sub  1024g/138DF93D 2000-05-26
