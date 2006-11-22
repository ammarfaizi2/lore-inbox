Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756395AbWKVSqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756395AbWKVSqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756398AbWKVSqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:46:07 -0500
Received: from mx27.mail.ru ([194.67.23.64]:1855 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1756395AbWKVSqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:46:04 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-usb-devel@lists.sourceforge.net
Subject: 2.6.19-rc5: modular USB rebuilds vmlinux?
Date: Wed, 22 Nov 2006 21:45:55 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611222145.59560.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I was under impression that I have fully modular USB. Still:

{pts/1}% make -C ~/src/linux-git O=$HOME/build/linux-2.6.19
make: Entering directory `/home/bor/src/linux-git'
  GEN     /home/bor/build/linux-2.6.19/Makefile
scripts/kconfig/conf -s arch/i386/Kconfig
  Using /home/bor/src/linux-git as source for kernel
  GEN     /home/bor/build/linux-2.6.19/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  CC [M]  drivers/usb/core/usb.o
  CC [M]  drivers/usb/core/hub.o
  CC [M]  drivers/usb/core/hcd.o
  CC [M]  drivers/usb/core/urb.o
  CC [M]  drivers/usb/core/message.o
  CC [M]  drivers/usb/core/driver.o
  CC [M]  drivers/usb/core/config.o
  CC [M]  drivers/usb/core/file.o
  CC [M]  drivers/usb/core/buffer.o
  CC [M]  drivers/usb/core/sysfs.o
  CC [M]  drivers/usb/core/endpoint.o
  CC [M]  drivers/usb/core/devio.o
  CC [M]  drivers/usb/core/notify.o
  CC [M]  drivers/usb/core/generic.o
  CC [M]  drivers/usb/core/hcd-pci.o
  CC [M]  drivers/usb/core/inode.o
  CC [M]  drivers/usb/core/devices.o
  LD [M]  drivers/usb/core/usbcore.o
  CC      drivers/usb/host/pci-quirks.o
  LD      drivers/usb/host/built-in.o
 
Sorry? How comes it still compiles something into main kernel?

 {pts/0}% grep USB build/linux-2.6.19/.config | grep -v '^#'
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_SUSPEND=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_PL2303=m

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFZJrnR6LMutpd94wRAh3DAJ97nMrIHG3pG4ZBaB8b6svZNm/39ACgt4Yd
19FExn1dKtTtFtyriNpP9dU=
=q9YV
-----END PGP SIGNATURE-----
