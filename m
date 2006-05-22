Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWEVNXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWEVNXj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 09:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWEVNXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 09:23:39 -0400
Received: from i5-7.dnslinks.net ([66.98.167.159]:37509 "HELO ip01-web5.net")
	by vger.kernel.org with SMTP id S1750822AbWEVNXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 09:23:39 -0400
Subject: Device name persist and initrd problem
From: govind <garumuga@sahasrasolutions.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1148304505.3395.36.camel@gopi.gopi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 22 May 2006 18:58:25 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel Version :   2.6.16

udev Version :     092

We are trying to boot using the USB flash drive. 

The USB gets detected as sda or sdb or sdc depending on the number of
hard
disk. In our case we have the root file system in the USB disk. 

We get kernel panic because USB detected as sd? (? being a or b or c
etc).
Even though this can be solved by giving root= option in the kernel
parameter during boot up, in our case we should not edit the grub
configuration.

We tried to use the udev where we wrote a rule to find USB  by using the
symlink called usbhd which is created by udev. 

We are planning to give the usbhd in the root= option. The usbhd link
will point to USB (sda, sdb) dynamically.

Before mounting root device, udevstart is started in the /linuxrc
script. This is to create the dynamic link mentioned above.

We have downloaded mkinitrd from 
http://www.simonf.com/usb/mkinitrd.usb.txt

However we get the following error message:-

The error message mount error 6 ext2 filesystem.
switchroot failed:22

Has anyone tried this before and if so, what is the suggested solution?

Thanks in advance,
A.Govind.

-- 
"Actions lie louder than words." 
				-Carolyn Wells

DISCLAIMER:
Information contained and transmitted by this E-MAIL is
proprietary to Sahasra Solutions and is intended for use
only by the individual or entity to which it is addressed
and may contain information that is privileged, confidential
or exempt from disclosure under applicable law. If this is a
forwarded message, the content of this E-MAIL may not have
been sent with the authority of the Company. If you are not
the intended recipient, an agent of the intended recipient or
a person responsible for delivering the information to the
named recipient, you are notified that any use, distribution,
transmission, printing, copying or dissemination of this
information in any way or in any manner is strictly prohibited.
If you have received this communication in error, please
delete this mail & notify the sender immediately.

