Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSE0EFQ>; Mon, 27 May 2002 00:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314106AbSE0EFQ>; Mon, 27 May 2002 00:05:16 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.133]:60350 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S310206AbSE0EFN>; Mon, 27 May 2002 00:05:13 -0400
Date: Mon, 27 May 2002 00:10:16 -0400
From: sean darcy <seandarcy@hotmail.com>
Subject: Re: [PATCH] Re: usb mass storage fails in 2.5.18
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Message-id: <3CF1B1A8.30706@hotmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
In-Reply-To: <fa.j16a1tv.1q4sio7@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK. Did that. Got a *lot* more stuff from dmesg. But still doesn't work. 
Still nothing in /proc/bus/usb.

FWIW, the camera is a Sony DSC-p71 - not one of the cameras listed in 
dmesg. Do I need to edit unnatural?  It does work, however, in 2.4.18.

Anything else you'd like me to try?

thanks for the help.
jay

  usb snips from dmesg:

hcd.c: usb-uhci-hcd @ 00:04.2, Intel Corp. 82371AB PIIX4 USB
hcd.c: irq 14, io base 0000d400
hcd.c: new USB bus registered, assigned bus number 1
usb-uhci-hcd.c: Detected 2 ports
hcd.c: 00:04.2 root hub device address 1
usb.c: kmalloc IF dbbcbec0, numif 1
usb.c: new device strings: Mfr=3, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Manufacturer: Linux 2.5.18 usb-uhci-hcd
Product: Intel Corp. 82371AB PIIX4 USB
SerialNumber: 00:04.2
hub.c: USB hub found at /
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dbbcbec0
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
......
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: hub / port 1 connection change
hub.c: hub / port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 0, 12 Mb/s
hub.c: new USB device 00:04.2-1, assigned address 2
usb.c: kmalloc IF dbb392e0, numif 1
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Manufacturer: Sony
Product: Sony DSC
usb-storage: act_altsettting is 0
usb-storage: id_index calculated to be: 20
usb-storage: Array length appears to be: 67
usb-storage: Vendor: Sony
usb-storage: Product: DSC-S30/S70/S75/505V/F505/F707
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xdbb4e3f4 Out: 0xdbb4e3e0 Int: 0xdbb4e408 
(Period 255)
usb-storage: New GUID 054c00100000000000000000
usb-storage: Transport: Control/Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: *** thread sleeping.
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage: 12 00 00 00 24 00 00 00 00 00 00 00
usb-storage: Invoking Mode Translation
usb-storage: Call to usb_stor_control_msg() returned 6
usb-storage: usb_stor_transfer_partial(): xfer 36 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 36/36
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CB data stage result is 0x0
usb-storage: -- CB transport device requiring auto-sense
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Call to usb_stor_control_msg() returned 6
usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CB data stage result is 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x5, ASC: 0x20, ASCQ: 0x0
usb-storage: Illegal Request: invalid command operation code
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1/0)
[REPEATED 7 TIMES]
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
usb.c: usb-storage driver claimed interface dbb392e0
usb.c: kusbd: /sbin/hotplug add 2
hub.c: port 2, portstatus 101, change 1, 12 Mb/s
hub.c: hub / port 2 connection change
hub.c: hub / port 2, portstatus 101, change 1, 12 Mb/s
hub.c: port 2, portstatus 101, change 0, 12 Mb/s
hub.c: port 2, portstatus 101, change 0, 12 Mb/s
hub.c: port 2, portstatus 101, change 0, 12 Mb/s
hub.c: port 2, portstatus 101, change 0, 12 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
hub.c: new USB device 00:04.2-2, assigned address 3
usb.c: kmalloc IF dbb39460, numif 1
usb.c: new device strings: Mfr=0, Product=0, SerialNumber=0
hub.c: USB hub found at 2
hub.c: 4 ports detected
hub.c: part of a compound device
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 20ms
hub.c: hub controller current requirement: 10mA
hub.c: port removable status: RRRF
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dbb39460
usb.c: kusbd: /sbin/hotplug add 3
hub.c: port 1, portstatus 100, change 0, 12 Mb/s
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 3, portstatus 100, change 0, 12 Mb/s
hub.c: port 4, portstatus 101, change 1, 12 Mb/s
hub.c: hub 2 port 4 connection change
hub.c: hub 2 port 4, portstatus 101, change 1, 12 Mb/s
hub.c: port 4, portstatus 101, change 0, 12 Mb/s
hub.c: port 4, portstatus 101, change 0, 12 Mb/s
hub.c: port 4, portstatus 101, change 0, 12 Mb/s
hub.c: port 4, portstatus 101, change 0, 12 Mb/s
hub.c: port 4, portstatus 103, change 10, 12 Mb/s
hub.c: new USB device 00:04.2-2.4, assigned address 4
usb.c: kmalloc IF dbb395e0, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=0, Product=0, SerialNumber=0
usb.c: unhandled interfaces on device
usb.c: USB device 4 (vend/prod 0x452/0x51) is not claimed by any active 
driver.
   Length              = 18
   DescriptorType      = 01
   USB version         = 1.00
   Vendor:Product      = 0452:0051
   MaxPacketSize0      = 8
   NumConfigurations   = 1
   Device version      = 2.06
   Device Class:SubClass:Protocol = 00:00:00
     Per-interface classes
Configuration:
   bLength             =    9
   bDescriptorType     =   02
   wTotalLength        = 0022
   bNumInterfaces      =   01
   bConfigurationValue =   01
   iConfiguration      =   00
   bmAttributes        =   40
   MaxPower            =  100mA

   Interface: 0
   Alternate Setting:  0
     bLength             =    9
     bDescriptorType     =   04
     bInterfaceNumber    =   00
     bAlternateSetting   =   00
     bNumEndpoints       =   01
     bInterface Class:SubClass:Protocol =   03:00:00
     iInterface          =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   81 (in)
       bmAttributes        =   03 (Interrupt)
       wMaxPacketSize      = 0008
       bInterval           =   20
usb.c: kusbd: /sbin/hotplug add 4
hub.c: port 1, portstatus 100, change 0, 12 Mb/s
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 3, portstatus 100, change 0, 12 Mb/s
hub.c: port 4, portstatus 103, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 0, 12 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s





Andries.Brouwer@cwi.nl wrote:
> In 2.5.16 - 2.5.18 there is one bad bug in usb-storage
> fixed by the 1-char patch below. Other things are wrong,
> but try this first.
> 
> Andries
> 
> --- /linux/2.5/linux-2.5.18/linux/drivers/usb/storage/transport.c       Tue May 
> 21 07:07:37 2002
> +++ /linux/2.5/linux-2.5.18a/linux/drivers/usb/storage/transport.c      Sun May 
> 26 00:32:48 2002
> @@ -430,7 +430,7 @@
>  
>         /* fill the URB */
>         FILL_CONTROL_URB(us->current_urb, us->pusb_dev, pipe, 
> -                        (unsigned char*) &dr, data, size, 
> +                        (unsigned char*) dr, data, size, 
>                          usb_stor_blocking_completion, NULL);
>  
>         /* submit the URB */



