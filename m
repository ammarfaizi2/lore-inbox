Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWITNTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWITNTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWITNTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:19:22 -0400
Received: from gl177a.glassen.ac ([82.182.223.101]:56213 "HELO findus.dhs.org")
	by vger.kernel.org with SMTP id S1751244AbWITNTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:19:21 -0400
Message-ID: <45113FD3.80509@findus.dhs.org>
Date: Wed, 20 Sep 2006 15:19:15 +0200
From: =?ISO-8859-15?Q?Petter_Sundl=F6f?= <petter.sundlof@findus.dhs.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Buffer I/O error on Sony Ericsson W810i (writing/sync to memory stick
 duo via phone's USB)
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.6.17 (Debian unstable 2.6.17-2-k7).

When after a copy operation I unmount the phone's smart card, the 
unmount stalls, and gives these errors in syslog

Buffer I/O error on device sdg1, logical block 960472
Buffer I/O error on device sdg1, logical block 960473
Buffer I/O error on device sdg1, logical block 960474
Buffer I/O error on device sdg1, logical block 960475
Buffer I/O error on device sdg1, logical block 960476
Buffer I/O error on device sdg1, logical block 960477
Buffer I/O error on device sdg1, logical block 960478
Buffer I/O error on device sdg1, logical block 960479
Buffer I/O error on device sdg1, logical block 960472
Buffer I/O error on device sdg1, logical block 960473
Sep 20 15:13:27 localhost NetworkManager: <debug 
info>^I[1158758007.553073] nm_hal_device_added (): New device added (hal 
udi is 
'/org/freedesktop/Hal/devices/storage_serial_Sony_Ericsson_Sony_Ericsso 
n_W810_359063000528328_0_0').
Sep 20 15:13:28 localhost NetworkManager: <debug 
info>^I[1158758008.701140] nm_hal_device_added (): New device added (hal 
udi is '/org/freedesktop/Hal/devices/volume_uuid_4511_4C30').


The card is a 512MB SanDisk Memory Stick PRO Dudo (labelled MagicGate).

After the start of the umount, 'df' starts reporting the device as much 
larger than it is:

/dev/sdg1             4,6G  4,3G  143M  97% /media/PHONE CARD

Before the unmount it reports it correctly.

The unmount operation never stops, and the files are not successfully 
copied.

I also tried to manually run 'sync' manually, and after a long, long 
while -- like 4-5 minutes, it exited, and I could unmount it gracefully.
The copy operation seems to have worked fine in this case.

Anyone using the same device with greater success? How can I easily 
debug this?

Cheers.
