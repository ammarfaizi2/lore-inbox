Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWIBSFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWIBSFH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 14:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWIBSFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 14:05:06 -0400
Received: from bay0-omc1-s33.bay0.hotmail.com ([65.54.246.105]:16511 "EHLO
	bay0-omc1-s33.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751254AbWIBSFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 14:05:04 -0400
Message-ID: <BAY115-DAV166837F51FA77071580036DE3D0@phx.gbl>
X-Originating-IP: [69.143.34.36]
X-Originating-Email: [wumarkus@hotmail.com]
From: "M W" <wumarkus@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: HP dv6000z Laptop ACPI/nVidia/bcm43xx issues
Date: Sat, 2 Sep 2006 14:04:51 -0400
Message-ID: <000001c6ceba$4904d450$9601a8c0@wulaptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcbOukdQGgjDeFjmSd2qtmOLDsA7Gw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-OriginalArrivalTime: 02 Sep 2006 18:05:03.0914 (UTC) FILETIME=[50A928A0:01C6CEBA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon boot-up, I am seeing the following error message on both 2.16 and 2.17
kernels (32 or 64 bit):
 
PCI: Failed to allocate mem resource #6:20000@e0000000 for 0000:05:00.0
 
I am also unable to boot the system properly unless I boot with "acpi=off"
This may be related to my bcm43xx wireless card that I have been unable to
get working properly both with the native driver or ndiswrapper. 
 
Here is the information on my system:
HP dv6000z Laptop (just released in the past month)
AMD Turion x64 ML-52
nVidia nForce chipset (410/430?)
nVidia GeForce Go 7200 Video Chipset (256 "TurboCache)
Broadcom a/b/g wireless w/Bluetooth (bcm4306)
nVidia onboard NIC
Conexant HD audio? (works sometimes with generic nVidia driver in ubuntu)

I believe the mem resource issue may have something to do with the
"TurboCache" feature of the chipset, which I believe borrows some of the
system RAM. I can verify that the 000:05:00 address refers to the graphics
card. Also, there is a LED for the wireless functions, which stays blue
during boot-up with ACPI turned-on. When turned-off, the light stays red and
audio functions do not work.

I have tried several distributions (ubuntu, gentoo, suse) and have witnessed
this issue on all distributions (both the system lock-ups and the mem
resource message). Recompiling the kernel with the latest test build
resulted in the same issue, as well. At this point, I assume since this
hardware is so new that this is just a configuration that hasn't been
considered yet.


-- 
VGER BF report: U 0.500599
