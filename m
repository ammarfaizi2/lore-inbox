Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265641AbSKAG3j>; Fri, 1 Nov 2002 01:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265642AbSKAG3i>; Fri, 1 Nov 2002 01:29:38 -0500
Received: from mail1.qualcomm.com ([129.46.64.223]:49094 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S265641AbSKAG3g>; Fri, 1 Nov 2002 01:29:36 -0500
Subject: [BK] Halloween Bluetooth updates
From: "Maksim (Max) " Krasnyanskiy <maxk@qualcomm.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 31 Oct 2002 20:40:06 -0800
Message-Id: <1036125653.3344.8.camel@champ.qualcomm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Folks, 

Happy Halloween.

Ok. We we ran out of candies. Which means it's time for next 
round of Bluetooth updates :).

Please pull from
	bk://linux-bt.bkbits.net/bt-2.5

This will update the following files:

 drivers/bluetooth/bluecard_cs.c   |   12 +-
 drivers/bluetooth/bt3c_cs.c       |   12 +-
 drivers/bluetooth/hci_bcsp.c      |    8 +
 drivers/bluetooth/hci_h4.c        |    8 +
 drivers/bluetooth/hci_ldisc.c     |    9 -
 drivers/bluetooth/hci_uart.h      |    2 
 drivers/bluetooth/hci_usb.c       |    4 
 drivers/bluetooth/hci_vhci.c      |    4 
 include/net/bluetooth/bluetooth.h |    4 
 include/net/bluetooth/hci_core.h  |   14 ++
 include/net/bluetooth/rfcomm.h    |    2 
 net/bluetooth/Makefile            |    2 
 net/bluetooth/af_bluetooth.c      |   18 ++-
 net/bluetooth/bnep/core.c         |   41 ++++----
 net/bluetooth/hci_conn.c          |    6 -
 net/bluetooth/hci_core.c          |   32 +++---
 net/bluetooth/hci_proc.c          |  187 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_sock.c          |    7 +
 net/bluetooth/l2cap.c             |  115 +++++++++++++++--------
 net/bluetooth/rfcomm/core.c       |  133 +++++++++++++++++++--------
 net/bluetooth/rfcomm/sock.c       |   97 ++++++++++++++++---
 net/bluetooth/rfcomm/tty.c        |   15 ++-
 net/bluetooth/sco.c               |  112 +++++++++++++++-------
 net/bluetooth/syms.c              |    2 
 24 files changed, 642 insertions(+), 204 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (02/10/31 1.857)
   Improved support for /proc/bluetooth
   - Convert /proc/bluetoth/l2cap to seq_file
   - Convert /proc/bluetoth/rfcomm to seq_file
   - Convert /proc/bluetooth/sco to seq_file
   - Export HCI device info via /proc/bluetooth/hci/N
   	 

<maxk@qualcomm.com> (02/10/23 1.808.5.3)
   Bluetooth HCI UART driver fixes
   - Don't call tx wakeup if uart protocol is not set.

<maxk@qualcomm.com> (02/10/23 1.808.14.2)
   Cleanup Bluetooth kernel messages.
   Info messages now prefixed with "Bluetooth:".
   

<maxk@qualcomm.com> (02/10/21 1.808.5.1)
   Initialize hw broadcast so that BNEP multicast filter can be
   properly initialized.

<marcel@holtmann.org> (02/10/19 1.793.7.2)
   [PATCH] Module description cleanup
   
   This patch modifies the module description and make it common with the
   rest of the Bluetooth subsystem.

<marcel@holtmann.org> (02/10/19 1.793.7.1)
   [PATCH] Don't use typedefs for non opaque HCI objects
   
   This patch is needed to let the PC Card drivers compile and work with
   the HCI typedef changes.


