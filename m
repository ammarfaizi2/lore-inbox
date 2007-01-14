Return-Path: <linux-kernel-owner+w=401wt.eu-S1751083AbXANGOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbXANGOx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 01:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbXANGOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 01:14:53 -0500
Received: from muan.mtu.ru ([195.34.34.229]:3209 "EHLO muan.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbXANGOx (ORCPT <rfc822; linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 01:14:53 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: No more "device" symlinks for classes
To: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Date: Sun, 14 Jan 2007 09:10:59 +0300
References: <45A97089.5090004@drzeus.cx>
User-Agent: KNode/0.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20070114061104.1C53839AF7F@muan.mtu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:

> Hi guys,
> 
> I just wanted to know the rationale behind
> 99ef3ef8d5f2f5b5312627127ad63df27c0d0d05 (no more "device" symlink in
> class devices). I thought that was a rather convenient way of finding
> which physical device the class device was coupled to.
> 

Actually I wonder why those links still present even when I told system not
to create them?

{pts/1}% grep DEPRE /boot/config
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_PM_SYSFS_DEPRECATED is not set
{pts/1}% find /sys/class -name device
/sys/class/pcmcia_socket/pcmcia_socket2/device
/sys/class/pcmcia_socket/pcmcia_socket1/device
/sys/class/pcmcia_socket/pcmcia_socket0/device
/sys/class/usb_device/usbdev1.1/device
/sys/class/usb_host/usb_host1/device
/sys/class/scsi_disk/0:0:0:0/device
/sys/class/scsi_device/1:0:0:0/device
/sys/class/scsi_device/0:0:0:0/device
/sys/class/scsi_host/host1/device
/sys/class/scsi_host/host0/device
/sys/class/net/eth0/device
/sys/class/net/eth1/device
/sys/class/input/input1/ts0/device
/sys/class/input/input1/mouse0/device
/sys/class/input/input1/event1/device
/sys/class/input/input1/device
/sys/class/input/input0/event0/device
/sys/class/input/input0/device
{pts/1}% uname -a
Linux cooker 2.6.20-rc5-1avb #10 Sat Jan 13 14:05:34 MSK 2007 i686 Pentium
III (Coppermine) GNU/Linux

-andrey

