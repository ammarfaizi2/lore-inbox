Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264777AbSJPAP7>; Tue, 15 Oct 2002 20:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264778AbSJPAP7>; Tue, 15 Oct 2002 20:15:59 -0400
Received: from [129.46.51.59] ([129.46.51.59]:39078 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S264777AbSJPAP5>; Tue, 15 Oct 2002 20:15:57 -0400
Message-Id: <5.1.0.14.2.20021015171539.0523ab18@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 15 Oct 2002 17:21:38 -0700
To: Linus Torvalds <torvalds@transmeta.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: [BK] More Bluetooth 2.5.x cleanups and fixes.
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, 

Here goes another round of Bluetooth updates and fixes. Touches whole bunch of
files but it's mostly minor stuff here and there.

Please pull from
        bk://linux-bt.bkbits.net/bt-2.5

This will update the following files:

 drivers/Makefile                  |    2 
 drivers/bluetooth/Config.help     |   18 +++---
 drivers/bluetooth/Config.in       |   22 +++----
 drivers/bluetooth/Makefile        |   16 ++---
 drivers/bluetooth/bluecard_cs.c   |    6 +-
 drivers/bluetooth/bt3c_cs.c       |    4 -
 drivers/bluetooth/dtl1_cs.c       |    6 +-
 drivers/bluetooth/hci_bcsp.c      |   14 ++--
 drivers/bluetooth/hci_h4.c        |    8 +-
 drivers/bluetooth/hci_ldisc.c     |   20 +++---
 drivers/bluetooth/hci_usb.c       |   18 +++---
 drivers/bluetooth/hci_vhci.c      |   10 +--
 include/net/bluetooth/bluetooth.h |   80 +++++++++------------------
 include/net/bluetooth/hci.h       |    4 +
 include/net/bluetooth/hci_core.h  |    2 
 net/Makefile                      |    2 
 net/bluetooth/Config.help         |   14 ++--
 net/bluetooth/Makefile            |   14 ++--
 net/bluetooth/af_bluetooth.c      |  111 +++++++++++++++++++-------------------
 net/bluetooth/bnep/Config.help    |    6 +-
 net/bluetooth/bnep/Config.in      |    8 +-
 net/bluetooth/bnep/Makefile       |    2 
 net/bluetooth/bnep/core.c         |   16 ++---
 net/bluetooth/bnep/netdev.c       |   12 ++--
 net/bluetooth/bnep/sock.c         |    8 +-
 net/bluetooth/hci_conn.c          |    2 
 net/bluetooth/hci_core.c          |   40 +++++++------
 net/bluetooth/hci_event.c         |   20 +++---
 net/bluetooth/hci_sock.c          |   28 ++++-----
 net/bluetooth/l2cap.c             |   94 ++++++++++++++++----------------
 net/bluetooth/lib.c               |    8 +-
 net/bluetooth/rfcomm/Config.help  |    4 -
 net/bluetooth/rfcomm/Config.in    |    6 +-
 net/bluetooth/rfcomm/Makefile     |    4 -
 net/bluetooth/rfcomm/core.c       |   24 ++++----
 net/bluetooth/rfcomm/sock.c       |   54 +++++++++---------
 net/bluetooth/rfcomm/tty.c        |    2 
 net/bluetooth/sco.c               |   70 +++++++++++------------
 net/bluetooth/syms.c              |   33 ++++++-----
 39 files changed, 400 insertions(+), 412 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (02/10/14 1.856)
   Support for suspend/resume interface for the HCI devices.

<maxk@qualcomm.com> (02/10/14 1.855)
   Get rid of the MIN() thing in Bluetooth code and use min_t() instead.

<maxk@qualcomm.com> (02/10/14 1.854)
   Consistent naming for Bluetooth function and constants.
   Some of them were named like BT_XXX and bt_xxx others BLUEZ_XXX and bluez_xxx.
   From now on use BT_XXX and bt_xxx throughout Bluetooth code, including CONFIG_ defines.
   Clean up small typos and misspelling along the way.

<maxk@qualcomm.com> (02/10/14 1.853)
   Now that the module name bluetooth.o is not used by USB subsystem anymore
   we can rename bluez.o to what it should have been from the beginning 
   bluetooth.o

<maxk@qualcomm.com> (02/10/13 1.740.1.2)
   Increase BNEP thread priority.

<maxk@qualcomm.com> (02/10/12 1.740.1.1)
   Fix typo in HCI_FILTER get/setsockopt

Thanks

Max

http://bluez.sf.net
http://vtun.sf.net

