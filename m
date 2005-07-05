Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVGEL5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVGEL5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 07:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVGEL5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 07:57:42 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:8669 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261778AbVGEL5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 07:57:37 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: enabled udev - empty flash drive fills log with garbage
Date: Tue, 5 Jul 2005 07:57:36 -0400
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507050757.36161.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running 12-mm2.  I recently enabled udev_0.060-1_amd64.deb.  It booted with full support (eg. /etc/init.d/udev
was not disabled).  However the empty sddr09 based flash drive keeps being queried - this fills the log with garbage.
How do I tell udev/kernel that an empty device is ok?  There is an entry in fstab for this: 

/dev/sda1       /mnt/sd         auto    rw,user,noauto  0       0

should it be disabled or changed?

TIA
Ed Tomlinson

Jul  5 07:46:16 grover kernel: [  267.496336] usb 1-4.2: reset full speed USB device using ohci_hcd and address 4
Jul  5 07:46:17 grover kernel: [  267.547434] usb 1-4.2: reset full speed USB device using ohci_hcd and address 4
Jul  5 07:46:17 grover kernel: [  267.599091] usb 1-4.2: reset full speed USB device using ohci_hcd and address 4
Jul  5 07:46:17 grover kernel: [  267.644078] sddr09: could not read card info
Jul  5 07:46:17 grover kernel: [  267.654076] sddr09: could not read card info
Jul  5 07:46:17 grover kernel: [  267.654165] Device  not ready.
Jul  5 07:46:17 grover kernel: [  267.664629] sddr09: could not read card info
Jul  5 07:46:17 grover kernel: [  267.664724] Device  not ready.
Jul  5 07:46:17 grover kernel: [  267.674627] sddr09: could not read card info
Jul  5 07:46:17 grover kernel: [  267.674716] Device  not ready.
Jul  5 07:46:17 grover kernel: [  267.674800] sda : READ CAPACITY failed.
Jul  5 07:46:17 grover kernel: [  267.674801] sda : status=1, message=00, host=0, driver=08
Jul  5 07:46:17 grover kernel: [  267.674836] sd: Current: sense key: No Sense
Jul  5 07:46:17 grover kernel: [  267.674853]     Additional sense: No additional sense information
Jul  5 07:46:17 grover kernel: [  267.675143] sda: test WP failed, assume Write Enabled

Then there will be another reset or two and it all start over...

