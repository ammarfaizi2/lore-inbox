Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265472AbSJSCCc>; Fri, 18 Oct 2002 22:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265473AbSJSCCb>; Fri, 18 Oct 2002 22:02:31 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:41349 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S265472AbSJSCC1>; Fri, 18 Oct 2002 22:02:27 -0400
Message-Id: <5.1.0.14.2.20021018190424.055a4600@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 18 Oct 2002 19:08:18 -0700
To: Linus Torvalds <torvalds@transmeta.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: [BK] More Bluetooth 2.5.x HCI, L2CAP and RFCOMM updates.
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, 

Here is some more Bluetooth stuff before I'll let you go enjoy your vacation ;-)

Please pull from
        bk://linux-bt.bkbits.net/bt-2.5

This will update the following files:

 drivers/bluetooth/hci_h4.c       |   12 
 drivers/bluetooth/hci_usb.c      |    8 
 include/net/bluetooth/hci.h      |  701 +++++++++++++++++----------------------
 include/net/bluetooth/hci_core.h |   99 +++--
 include/net/bluetooth/l2cap.h    |   57 +--
 include/net/bluetooth/rfcomm.h   |    5 
 net/bluetooth/hci_conn.c         |   52 +-
 net/bluetooth/hci_core.c         |  147 +++-----
 net/bluetooth/hci_event.c        |  313 ++++++++---------
 net/bluetooth/hci_sock.c         |   20 -
 net/bluetooth/l2cap.c            |  345 +++++++++----------
 net/bluetooth/rfcomm/core.c      |   16 
 net/bluetooth/rfcomm/sock.c      |    7 
 net/bluetooth/rfcomm/tty.c       |   93 +++--
 net/bluetooth/syms.c             |    1 
 15 files changed, 895 insertions(+), 981 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (02/10/17 1.798)
   Correct RFCOMM modem status implementation.
   RFCOMM DLC API fixes.

<maxk@qualcomm.com> (02/10/17 1.797)
   Consistent naming for Bluetooth HCI events, commands and parameters.
   Cleanup unused HCI stuff.
   Optimize HCI receive path.

<maxk@qualcomm.com> (02/10/17 1.796)
   Just like many other parts of the kernel Bluetooth code was abusing
   typedefs for non opaque objects. This Changeset cleanups Bluetoth HCI
   code and headers.

<maxk@qualcomm.com> (02/10/17 1.795)
   Just like many other parts of the kernel Bluetooth code was abusing
   typedefs for non opaque objects. This changeset cleans up L2CAP code
   and headers. In addition it optimizes sendmsg for L2CAP sockets.

<maxk@qualcomm.com> (02/10/16 1.794)
   Users must have CAP_NET_ADMIN capability in order to create
   or destroy RFCOMM devices. 



Max

http://bluez.sf.net
http://vtun.sf.net

