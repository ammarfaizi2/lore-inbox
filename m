Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263999AbRFMTgM>; Wed, 13 Jun 2001 15:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264200AbRFMTgD>; Wed, 13 Jun 2001 15:36:03 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:50410 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S264183AbRFMTfx>; Wed, 13 Jun 2001 15:35:53 -0400
Message-Id: <4.3.1.0.20010613105628.02083e80@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Wed, 13 Jun 2001 12:35:44 -0700
To: esr@thyrsus.com, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: Undocumented configuration symbols in 2.4.6pre2
In-Reply-To: <20010610100935.A11098@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

>CONFIG_BLUEZ
>CONFIG_BLUEZ_HCIEMU
>CONFIG_BLUEZ_HCIUART
>CONFIG_BLUEZ_HCIUSB
>CONFIG_BLUEZ_L2CAP
>
>Would the people responsible for these symbols please write Configure.help entries and send them to me?  
Yep, those are mine. They belong to Linux Bluetooth subsystem.

btw Linux is the first OS that has official Bluetooth support.

Here we go:

CONFIG_BLUEZ
   Bluetooth is low-cost, low-power, short-range wireless technology. 
   It was designed as a replacement for cables and other short-range 
   technologies like IrDA. Bluetooth operates in personal area range
   that typically extends up to 10 meters.
   More information about Bluetooth can be found at http://www.bluetooth.com

   Linux Bluetooth subsystem consist of several layers:
                 HCI Core (device and connection manager, scheduler)
                 HCI Device drivers (interface to the hardware)
                 L2CAP Module (L2CAP protocol)

   Say Y here to enable Linux Bluetooth support and to build HCI Core 
   layer.

   To use Linux Bluetooth subsystem, you will need several user-space utilities 
   like hciconfig and hcid. These utilities and updates to Bluetooth kernel 
   modules are provided in the BlueZ package.
   For more information, see http://bluez.sf.net.

   If you want to compile HCI Core as module (hci.o) say M here.

   Not unsure ? say N.

CONFIG_BLUEZ_L2CAP
   L2CAP (Logical Link Control and Adaptation Protocol) provides connection 
   oriented and connection-less data transport. L2CAP support is required for 
   most Bluetooth applications.

   Say Y here to compile L2CAP support into the kernel or say M to compile it 
   as module (l2cap.o).

   Not unsure ? say M.

CONFIG_BLUEZ_HCIUART
   Bluetooth HCI UART driver.
   This driver is required if you want to use Bluetooth devices with serial
   port interface.

   Say Y here to compile support for Bluetooth UART devices into the kernel 
   or say M to compile it as module (hci_uart.o).

   Not unsure ? say M.


CONFIG_BLUEZ_HCIUSB
   Bluetooth HCI USB driver.
   This driver is required if you want to use Bluetooth devices with USB
   interface. 

   Say Y here to compile support for Bluetooth USB devices into the kernel 
   or say M to compile it as module (hci_usb.o).

   Not unsure ? say M.

CONFIG_BLUEZ_HCIEMU
   Bluetooth Virtual HCI device driver.
   This driver is required if you want to use HCI Emulation software.

   Say Y here to compile support for Virtual HCI devices into the kernel or 
   say M to compile it as module (hci_usb.o).

   Not unsure ? say M.

Thanks
Max

Maksim Krasnyanskiy		
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
(408) 557-1092

