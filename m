Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266632AbUBMAk1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 19:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266634AbUBMAk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 19:40:26 -0500
Received: from CPE-65-28-18-238.kc.rr.com ([65.28.18.238]:52133 "EHLO
	mail.2thebatcave.com") by vger.kernel.org with ESMTP
	id S266632AbUBMAkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 19:40:22 -0500
Message-ID: <52044.192.168.1.12.1076632825.squirrel@mail.2thebatcave.com>
In-Reply-To: <Pine.LNX.4.58.0402121715310.27694@student.dei.uc.pt>
References: <46246.192.168.1.12.1076553774.squirrel@mail.2thebatcave.com>    
    <Pine.LNX.4.58.0402120457250.28596@student.dei.uc.pt>  
    <50365.192.168.1.12.1076590069.squirrel@mail.2thebatcave.com><50391.192.168.1.12.1076590842.squirrel@mail.2thebatcave.com>
    <Pine.LNX.4.58.0402121715310.27694@student.dei.uc.pt>
Date: Thu, 12 Feb 2004 18:40:25 -0600 (CST)
Subject: Re: /proc/partitions not done updating when init is ran?
From: "Nick Bartos" <spam99@2thebatcave.com>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Well, does it still happen with 2.4.25-rc2 ?
>

yes it does, and it does for 2.6.2 as well.

I did a couple of dmesg's and it looks like the usb device is not being
detected until after init is ran.  I would think that the kernel would
have done all the device detection before running init but I guess not.

Is there a way to check somewhere to make sure it is done detecting
devices?  I cannot just check to see if any of the usb/scsi stuff exists
since some systems may be booting off ide and have no usb bus enabled.

Here are a few of the lines that get added after I wait for a few seconds
in my init script:

+scsi0 : SCSI emulation for USB Mass Storage devices
+  Vendor: OEI-USB2  Model: CompactFlash      Rev: 1.04
+  Type:   Direct-Access                      ANSI SCSI revision: 02
+Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
+SCSI device sda: 250880 512-byte hdwr sectors (128 MB)
+sda: Write Protect is off
+ /dev/scsi/host0/bus0/target0/lun0: p1 p2
+WARNING: USB Mass Storage data integrity not assured
+USB Mass Storage device found at 2



