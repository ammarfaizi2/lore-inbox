Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTEMQYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbTEMQYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:24:50 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:42215 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S261437AbTEMQYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:24:40 -0400
Subject: USB mouse freezes under X - 2.5.69 and 2.5.69-mm*
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-PTZhOIcnRkfAsouFLioy"
Organization: 
Message-Id: <1052843843.1148.7.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 May 2003 09:37:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PTZhOIcnRkfAsouFLioy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, Greg -

I just booted into vanilla 2.5.69, and confirmed that my mouse still
freezes under X.  I have something vaguely like a reproduction recipe:
drag a window around vigorously on the screen for a bit, and the mouse
will seize up.

I've attached the usual files, in case they're useful to you in figuring
out what might be wrong.  My userspace is Red Hat 9, barely modified.

	<b

--=-PTZhOIcnRkfAsouFLioy
Content-Disposition: attachment; filename=lsusb.out
Content-Type: text/plain; name=lsusb.out; charset=UTF-8
Content-Transfer-Encoding: 7bit


Bus 004 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.05
  iManufacturer           3 Linux 2.5.69 uhci-hcd
  iProduct                2 Intel Corp. 82801DB USB (Hub #3)
  iSerial                 1 00:1d.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 003 Device 002: ID 045e:001e Microsoft Corp. IntelliMouse Explorer
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x045e Microsoft Corp.
  idProduct          0x001e IntelliMouse Explorer
  bcdDevice            1.21
  iManufacturer           1 
  iProduct                2 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      72
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          4
        bInterval              10
  Language IDs: (length=24)
     0409 English(US)
     0809 English(UK)
     0c09 English(Australian)
     1009 English(Canadian)
     1409 English(New Zealand)
     1809 English(Ireland)
     1c09 English(South Africa)
     2009 English(Jamaica)
     2409 English(Carribean)
     2809 English(Belize)
     2c09 English(Trinidad)

Bus 003 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.05
  iManufacturer           3 Linux 2.5.69 uhci-hcd
  iProduct                2 Intel Corp. 82801DB USB (Hub #2)
  iSerial                 1 00:1d.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 002 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.05
  iManufacturer           3 Linux 2.5.69 uhci-hcd
  iProduct                2 Intel Corp. 82801DB USB (Hub #1)
  iSerial                 1 00:1d.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         1 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.05
  iManufacturer           3 Linux 2.5.69 ehci-hcd
  iProduct                2 Intel Corp. 82801DB USB EHCI Con
  iSerial                 1 00:1d.7
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval              12
  Language IDs: (length=4)
     0409 English(US)

--=-PTZhOIcnRkfAsouFLioy
Content-Disposition: attachment; filename=lspci.out
Content-Type: text/plain; name=lspci.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 01)
00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge (rev 01)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]
02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (LOM) Ethernet Controller (rev 81)

--=-PTZhOIcnRkfAsouFLioy
Content-Disposition: attachment; filename=proc-interrupts.out
Content-Type: text/plain; name=proc-interrupts.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

           CPU0       
  0:     527126          XT-PIC  timer
  1:       1969          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:          0          XT-PIC  ehci-hcd
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  uhci-hcd
 10:      25761          XT-PIC  uhci-hcd
 11:      13885          XT-PIC  uhci-hcd, eth0, Intel 82801DB-ICH4
 12:         53          XT-PIC  i8042
 14:      18362          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0 
ERR:          0

--=-PTZhOIcnRkfAsouFLioy
Content-Disposition: attachment; filename=lsmod.out
Content-Type: text/plain; name=lsmod.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

Module                  Size  Used by
snd_pcm_oss            52100  0 
snd_mixer_oss          18816  1 snd_pcm_oss
snd_intel8x0           22852  0 
snd_pcm                89472  2 snd_pcm_oss,snd_intel8x0
snd_timer              23936  1 snd_pcm
snd_ac97_codec         47492  1 snd_intel8x0
snd_page_alloc         10372  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         7424  1 snd_intel8x0
snd_rawmidi            23552  1 snd_mpu401_uart
snd_seq_device          8068  1 snd_rawmidi
snd                    48772  9 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               8640  1 snd
iptable_filter          2944  0 
ip_tables              16256  1 iptable_filter
autofs4                14592  3 
parport_pc             26760  0 
parport                41792  1 parport_pc
ide_scsi               15488  0 
hid                    31808  0 
uhci_hcd               28040  0 
ehci_hcd               23040  0 
usbcore               100564  5 hid,uhci_hcd,ehci_hcd

--=-PTZhOIcnRkfAsouFLioy--

