Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315732AbSECVx3>; Fri, 3 May 2002 17:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315733AbSECVx2>; Fri, 3 May 2002 17:53:28 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:14510 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S315732AbSECVxY>; Fri, 3 May 2002 17:53:24 -0400
Message-Id: <5.1.0.14.2.20020503145040.0f3ed3a8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 03 May 2002 14:52:24 -0700
To: torvalds@transmeta.com
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: [PATCH] 2.5.13 Bluetooth subsystem sync up 
Cc: linux-kernel@vger.kernel.org, bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Following patch updates 2.5.x Bluetooth subsystem (against 2.5.13).
It removes EXPERIMENTAL status of the Bluetooth support.
         http://bluez.sf.net/patches/bluez-sync-up-2.5.gz

Same patch is already included in current 2.4 tree.
Please apply.

ChangeLog:
         BlueZ Core:
                 New generic HCI connection manager.
                 Complete role switch and link policy support.
                 Security mode 1 and 3 support.
                 L2CAP service level security support.
                 HCI filter support.
                 HCI frame time-stamps.
                 SCO (voice links) support.
                 Improved HCI device unregistration (device destructors).
                 Support for L2CAP signalling frame fragmentation.
                 Improved L2CAP timeout handling.
                 New HCI ioctls for changing ACL and SCO MTU.
                 Killed HCI_MAX_DEV limit.
                 Security fixes.

         HCI USB driver:
                 Performance improvements.
                 Firmware loading support.
                 Stability fixes. URB and disconnect handling rewrite.

         HCI UART driver:
                 Support for multiple UART protocols.

         HCI PCMCIA driver:
                 Support for Nokia Bluetooth PC Cards.
                 Support for Anycom Bluetooth PC/CF Cards.

  arch/alpha/config.in               |    4
  arch/arm/config.in                 |    4
  arch/i386/config.in                |    4
  arch/ia64/config.in                |    4
  arch/alpha/config.in               |    4
  arch/arm/config.in                 |    4
  arch/i386/config.in                |    4
  arch/ia64/config.in                |    4
  arch/ppc/config.in                 |    4
  arch/sparc64/config.in             |    4
  arch/x86_64/config.in              |    4
  drivers/bluetooth/Config.help      |   53
  drivers/bluetooth/Config.in        |   15
  drivers/bluetooth/Makefile         |   13
  drivers/bluetooth/bluecard_cs.c    | 1124 +++++++++++++++++
  drivers/bluetooth/dtl1_cs.c        |  939 +++++++++++++++
  drivers/bluetooth/hci_h4.c         |  273 ++++
  drivers/bluetooth/hci_h4.h         |   43
  drivers/bluetooth/hci_ldisc.c      |  554 ++++++++
  drivers/bluetooth/hci_uart.c       |  580 ---------
  drivers/bluetooth/hci_uart.h       |   80 +
  drivers/bluetooth/hci_usb.c        |  923 ++++++++------
  drivers/bluetooth/hci_usb.h        |   79 +
  drivers/bluetooth/hci_vhci.c       |   63 -
  drivers/bluetooth/hci_vhci.h       |   50
  include/net/bluetooth/bluetooth.h  |  133 ++
  include/net/bluetooth/bluez.h      |  124 -
  include/net/bluetooth/hci.h        |  459 ++++++-
  include/net/bluetooth/hci_core.h   |  462 ++++---
  include/net/bluetooth/hci_uart.h   |   62
  include/net/bluetooth/hci_usb.h    |   68 -
  include/net/bluetooth/hci_vhci.h   |   50
  include/net/bluetooth/l2cap.h      |  121 +
  include/net/bluetooth/l2cap_core.h |  144 --
  include/net/bluetooth/sco.h        |   81 +
  net/bluetooth/Config.help          |   17
  net/bluetooth/Config.in            |    1
  net/bluetooth/Makefile             |   11
  net/bluetooth/af_bluetooth.c       |  255 +++-
  net/bluetooth/hci_conn.c           |  437 ++++++
  net/bluetooth/hci_core.c           | 1901 +++++++++---------------------
  net/bluetooth/hci_event.c          |  874 +++++++++++++
  net/bluetooth/hci_sock.c           |  390 +++---
  net/bluetooth/l2cap.c              | 2048 ++++++++++++++++++++++++++++++++
  net/bluetooth/l2cap_core.c         | 2316 
-------------------------------------
  net/bluetooth/l2cap_proc.c         |  165 --
  net/bluetooth/lib.c                |    2
  net/bluetooth/sco.c                | 1011 ++++++++++++++++
  net/bluetooth/syms.c               |   16
  45 files changed, 10311 insertions(+), 5654 deletions(-)



Max

http://bluez.sf.net
http://vtun.sf.net

