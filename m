Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132958AbRECQVY>; Thu, 3 May 2001 12:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132991AbRECQVO>; Thu, 3 May 2001 12:21:14 -0400
Received: from spc.esa.lanl.gov ([128.165.46.232]:11136 "HELO spc.esa.lanl.gov")
	by vger.kernel.org with SMTP id <S132958AbRECQVB>;
	Thu, 3 May 2001 12:21:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: linux-kernel@vger.kernel.org
Subject: 2.4.4-ac4 build error with CONFIG_USB=y
Date: Thu, 3 May 2001 10:20:43 -0600
X-Mailer: KMail [version 1.2]
Cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Message-Id: <01050310204300.01141@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_USB=y, I got the following error building 2.4.4-ac4:

drivers/usb/usbdrv.o: In function `uhci_alloc_td':
drivers/usb/usbdrv.o(.text+0x57b7): undefined reference to `pci_pool_alloc'
drivers/usb/usbdrv.o: In function `uhci_free_td':
drivers/usb/usbdrv.o(.text+0x5a41): undefined reference to `pci_pool_free'
drivers/usb/usbdrv.o: In function `uhci_alloc_qh':
drivers/usb/usbdrv.o(.text+0x5a67): undefined reference to `pci_pool_alloc'
drivers/usb/usbdrv.o: In function `uhci_free_qh':
drivers/usb/usbdrv.o(.text+0x5ad1): undefined reference to `pci_pool_free'
drivers/usb/usbdrv.o: In function `alloc_uhci':
drivers/usb/usbdrv.o(.text+0x88c7): undefined reference to `pci_pool_create'
drivers/usb/usbdrv.o(.text+0x88f6): undefined reference to `pci_pool_create'
drivers/usb/usbdrv.o(.text+0x8c22): undefined reference to `pci_pool_destroy'
drivers/usb/usbdrv.o(.text+0x8c2c): undefined reference to `pci_pool_destroy'
drivers/usb/usbdrv.o: In function `release_uhci':
drivers/usb/usbdrv.o(.text+0x8ce6): undefined reference to `pci_pool_destroy'
drivers/usb/usbdrv.o(.text+0x8cfb): undefined reference to `pci_pool_destroy'
make: *** [vmlinux] Error 1

Undefining CONFIG_USB gave me a clean build.

Steven
