Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbTDLXME (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 19:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbTDLXME (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 19:12:04 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:2833 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S261632AbTDLXMD (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 19:12:03 -0400
Message-ID: <3E98A050.2090005@torque.net>
Date: Sun, 13 Apr 2003 09:25:04 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jim_jim33@hotmail.com
Subject: Re: USB Mass Storage Device
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Bean wrote:
 > The following USB Mass Storage device is found during bootup:
 >
 > scsi0 : SCSI emulation for USB
 > Mass Storage devices
 >   Vendor: SOYO      Model: USB Storage-SMC   Rev: 0214
 >   Type:   Direct-Access                      ANSI SCSI revision: 02
 > Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
 >
 > Is it a CompactFlash reader that plugs directly into a USB1 header
 > on my motherboard.

 > /sys/bus/scsi/devices/0:0:0:0/* contains information regarding
 > the device, however there is nothing
 > /dev/scsi/host0/bus0/target0/lun0 for me to mount, regardless
 > of whether there is a card in the drive or not.  I have
 > hotplug enables, and inserting a card in the drive does not
 > generate any new messages under dmesg (although verbosity
 > stuff is not enabled).  Is this device not yet supported,
 > or am I missing something that I need to enable?

Jim,
Have a look in /var/log/messages for errors coming from the
sd driver (e.g. it could be stuck on a READ CAPACITY or MODE
SENSE command). Other than that it could be a problem with
devfs. You could make a temporary device node (e.g.
'cd /root; mknod my_sda b 8 0') then try fdisk on my_sda.

Doug Gilbert

