Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVLKXmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVLKXmn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 18:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVLKXmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 18:42:43 -0500
Received: from bay103-f7.bay103.hotmail.com ([65.54.174.17]:20169 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750893AbVLKXmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 18:42:43 -0500
Message-ID: <BAY103-F753F61FDEC913D1E25AF1DF470@phx.gbl>
X-Originating-IP: [69.222.161.85]
X-Originating-Email: [dravet@hotmail.com]
From: "Jason Dravet" <dravet@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: parport module is a missing "dev" file
Date: Sun, 11 Dec 2005 17:42:42 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 11 Dec 2005 23:42:43.0079 (UTC) FILETIME=[9498A970:01C5FEAC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parport module is a missing "dev" file in /sys, which the kernel should 
provide.

Oct 19 09:11:52 jever udevd[18982]: get_udevd_msg: udevd event message 
received
Oct 19 09:11:52 jever udevd[18982]: main: skip uevent_helper message with
SEQNUM, netlink is active
Oct 19 09:11:52 jever udevd[18982]: msg_queue_insert: seq 699 queued, 'add'
'/module/parport'
Oct 19 09:11:52 jever udevd[18982]: udev_event_run: seq 699 forked, pid 
[19000],
'add' 'module', 0 seconds old
Oct 19 09:11:52 jever udevd[18982]: msg_queue_insert: seq 700 queued, 'add'
'/module/parport_pc'
Oct 19 09:11:52 jever udevd[18982]: udev_event_run: seq 700 forked, pid 
[19002],
'add' 'module', 0 seconds old
Oct 19 09:11:52 jever udevd[18982]: get_udevd_msg: udevd event message 
received
Oct 19 09:11:52 jever udevd[18982]: main: skip uevent_helper message with
SEQNUM, netlink is active
Oct 19 09:11:52 jever udevd[18982]: udev_done: seq 700, pid [19002] exit, 0
seconds old
Oct 19 09:11:52 jever udevd[18982]: msg_queue_insert: seq 701 queued, 'add'
'/bus/pnp/drivers/parport_pc'
Oct 19 09:11:52 jever udevd[18982]: udev_event_run: seq 701 forked, pid 
[19006],
'add' 'drivers', 0 seconds old
Oct 19 09:11:52 jever udevd[18982]: get_udevd_msg: udevd event message 
received
Oct 19 09:11:52 jever udevd[18982]: main: skip uevent_helper message with
SEQNUM, netlink is active
Oct 19 09:11:52 jever kernel: pnp: Device 00:08 activated.
Oct 19 09:11:52 jever udevd[18982]: udev_done: seq 699, pid [19000] exit, 0
seconds old
Oct 19 09:11:52 jever kernel: parport: PnPBIOS parport detected.
Oct 19 09:11:52 jever udevd[18982]: udev_done: seq 701, pid [19006] exit, 0
seconds old
Oct 19 09:11:52 jever kernel: parport0: PC-style at 0x378 (0x778), irq 7
[PCSPP,TRISTATE]
Oct 19 09:11:52 jever udevd[18982]: msg_queue_insert: seq 702 queued, 'add'
'/bus/pci/drivers/parport_pc'
Oct 19 09:11:52 jever udevd[18982]: udev_event_run: seq 702 forked, pid 
[19008],
'add' 'drivers', 0 seconds old
Oct 19 09:11:52 jever udevd[18982]: get_udevd_msg: udevd event message 
received
Oct 19 09:11:52 jever udevd[18982]: main: skip uevent_helper message with
SEQNUM, netlink is active
Oct 19 09:11:52 jever udevd[18982]: udev_done: seq 702, pid [19008] exit, 0
seconds old

No hotplug message from the kernel appears and no /sys "dev" file is 
offered.  This is bug number 5496 in bugzilla.kernel.org.

Thanks,
Jason


