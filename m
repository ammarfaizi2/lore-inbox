Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbVIAQKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVIAQKF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVIAQKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:10:05 -0400
Received: from mxsf35.cluster1.charter.net ([209.225.28.160]:28561 "EHLO
	mxsf35.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1030221AbVIAQKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:10:04 -0400
X-IronPort-AV: i="3.96,161,1122868800"; 
   d="scan'208"; a="1477301554:sNHT481399202"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17175.10191.634957.119742@smtp.charter.net>
Date: Thu, 1 Sep 2005 12:09:51 -0400
From: "John Stoffel" <john@stoffel.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
In-Reply-To: <200509011738.45821.dominik.karall@gmx.net>
References: <20050901035542.1c621af6.akpm@osdl.org>
	<200509011738.45821.dominik.karall@gmx.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dominik" == Dominik Karall <dominik.karall@gmx.net> writes:

Dominik> When I switch on my external harddisk, which is connected
Dominik> through usb, the kernel hangs. First time I did that at
Dominik> bootup there were a lot of backtraces printed on the screen
Dominik> but they did not find the way in the logfile :/ Now I
Dominik> switched the drive on while running and everything freezes
Dominik> after those messages:

Dominik> usb 1-2.2: new high speed USB device using ehci_hcd and address 3
Dominik> scsi2 : SCSI emulation for USB Mass Storage devices
Dominik> usb-storage: device found at 3
Dominik> usb-storage: waiting for device to settle before scanning
Dominik>   Vendor: ST325082  Model: 3A                Rev: 3.02
Dominik>   Type:   Direct-Access                      ANSI SCSI revision: 00
Dominik> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Dominik> sda: assuming drive cache: write through
Dominik> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Dominik> sda: assuming drive cache: write through

Have you updated the firmware on the USB enclosure?  I have one using
the Prolific chipset for both USB/Firewire and it was crappy until I
upgraded the firmware on there.  It made all the difference.  

Also, can you use this USB enclosure on Windows or another computer?
And which kernel version are you running?  It's not clear if your on
2.6.13-mm1 or some other version.  

More details would be good too, such as:

	lsusb
	cat /proc/version
	

What happens if you unplug the drive when the system hangs?  Does it
recover?  And try powering up the enclosure without it being hooked to
anything, then once 30 seconds have passed, hook it upto the Linux box
and see what happens then.  Maybe the power on stuff is doing strange
things.

John
