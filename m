Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268463AbTANBAW>; Mon, 13 Jan 2003 20:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268467AbTANBAW>; Mon, 13 Jan 2003 20:00:22 -0500
Received: from hera.cwi.nl ([192.16.191.8]:34484 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268463AbTANBAW>;
	Mon, 13 Jan 2003 20:00:22 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 14 Jan 2003 02:09:06 +0100 (MET)
Message-Id: <UTC200301140109.h0E196W01345.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, greg@kroah.com, mdharm-usb@one-eyed-alien.net,
       patmans@us.ibm.com
Subject: Re: sysfs
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks like there is a missing scsi_set_device() call in scsiglue.c,

OK, added. Now rmmod usb-storage followed by insmod usb-storage
resulted in an oops, as usual, but after a fresh reboot:
Yes indeed, just like desired:

% ls -l /sysfs/block/sdb/device
... -> ../../devices/pci0/00:07.2/usb1/1-2/1-2.4/1-2.4.1/2:0:0:0

Good.
Now that you removed this scsi device from /sysfs/devices, I suppose
you'll also want to remove

/sysfs/devices/1:0:6:0

which is an Iomega ZIP drive on the parallel port, driver imm.c,
device sda.
(I can also do it but have no time now. Friday.)

All the best - Andries
