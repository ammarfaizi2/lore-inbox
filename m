Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbTD1TD7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 15:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbTD1TD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 15:03:59 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:17832 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S261247AbTD1TD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 15:03:57 -0400
Message-Id: <5.1.0.14.2.20030428121150.10a1c960@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 28 Apr 2003 12:15:19 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: [BK] Bluetooth fixes for 2.4.21-rc1
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

We've got several important BT fixes for 2.4.21.
Please pull from
        bk://linux-bt.bkbits.net/bt-2.4

This will update the following files:

 include/net/bluetooth/rfcomm.h |   10 ++++--
 net/bluetooth/l2cap.c          |    2 -
 net/bluetooth/rfcomm/core.c    |   60 ++++++++++++++++++++++++++++++++++++++---
 net/bluetooth/rfcomm/tty.c     |   23 ++++++++++-----
 4 files changed, 81 insertions(+), 14 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (03/04/26 1.1126.2.3)
   [Bluetooth] Fix race condition in RFCOMM session and dlc scheduler.
   This fixes random RFCOMM freezes reported by a few people.

<maxk@qualcomm.com> (03/04/26 1.1126.2.2)
   [Bluetooth] Improved RFCOMM TTY buffer management. Don't buffer more data than
   we have credits for.
   Patch from David Woodhouse <dwmw2@infradead.org>

<marcel@holtmann.org> (03/04/23 1.1006.23.2)
   [Bluetooth] Fix L2CAP binding to local address
   
   In the function l2cap_connect_ind() we compare the bounded
   address with the address of an incoming connection, but we
   have to compare it with the local address of the HCI device.

<marcel@holtmann.org> (03/03/30 1.1006.23.1)
   [Bluetooth] Respond correctly to RLS packets
   
   This patch adds the recognition and correct responding to the
   RFCOMM RLS packets to fulfill the requirements of the Bluetooth
   specification.


Thanks

Max

http://bluez.sf.net
http://vtun.sf.net

