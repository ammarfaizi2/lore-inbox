Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262770AbTC0Bji>; Wed, 26 Mar 2003 20:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbTC0Bji>; Wed, 26 Mar 2003 20:39:38 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:25572 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262770AbTC0Bjg>; Wed, 26 Mar 2003 20:39:36 -0500
Message-Id: <5.1.0.14.2.20030326174507.05351f98@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 26 Mar 2003 17:50:41 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: [BK] Bluetooth updates for 2.4.21-pre6
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, 

Could you pull a few Bluetooth updates from
        bk://linux-bt.bkbits.net/bt-2.4

This will update the following files:

 Documentation/Configure.help     |   13 
 drivers/bluetooth/Config.in      |    1 
 drivers/bluetooth/hci_usb.c      |  748 +++++++++++++++++++++++----------------
 drivers/bluetooth/hci_usb.h      |  105 ++++-
 include/net/bluetooth/hci.h      |   98 ++---
 include/net/bluetooth/hci_core.h |   24 -
 net/bluetooth/hci_conn.c         |    1 
 net/bluetooth/hci_core.c         |   84 ++--
 net/bluetooth/hci_sock.c         |  104 ++---
 net/bluetooth/syms.c             |    4 
 10 files changed, 712 insertions(+), 470 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (03/03/24 1.1110)
   [Bluetooth] Use atomic allocations in HCI USB functions called under spinlock.

<marcel@holtmann.org> (03/03/21 1.1109)
   [Bluetooth] Add help entry for CONFIG_BLUEZ_USB_SCO
   
   This patch adds the missing help entry for CONFIG_BLUEZ_USB_SCO.

<marcel@holtmann.org> (03/03/21 1.1108)
   [Bluetooth] Use R1 for default value of pscan_rep_mode
   
   Most devices seem to use R1 for pscan_rep_mode to save power
   consumption, so R1 is preferable for default value, if there
   is no entry in the inquiry cache. Using R1 will improve the
   average of connect time in many cases.

<marcel@holtmann.org> (03/03/20 1.1107)
   [Bluetooth] Add support for the Ultraport Module from IBM
   
   This patch adds the specific vendor and product id's for the
   Bluetooth Ultraport Module from IBM. This is needed, because
   the device itself don't uses the USB Bluetooth class id.

<maxk@qualcomm.com> (03/03/19 1.1106)
   [Bluetooth]
   Do not submit more than one usb bulk rx request. It crashes uhci.o driver.

<maxk@qualcomm.com> (03/03/19 1.1105)
   [Bluetooth]
   Support for SCO (voice) over HCI USB

<maxk@qualcomm.com> (03/03/19 1.1053.2.2)
   [Bluetooth]
   Kill incoming SCO connection when SCO socket is closed.

<maxk@qualcomm.com> (03/03/05 1.953.2.3)
   [Bluetooth] 
   Use very short disconnect timeout for SCO connections.
   They cannot be reused and therefor there is no need to
   keep them around.

--

Thanks
Max

