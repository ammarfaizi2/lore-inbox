Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131375AbQLIMCQ>; Sat, 9 Dec 2000 07:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131474AbQLIMB5>; Sat, 9 Dec 2000 07:01:57 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:15547 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S131375AbQLIMBo>; Sat, 9 Dec 2000 07:01:44 -0500
Date: Sat, 9 Dec 2000 11:30:44 +0000 (GMT)
From: davej@suse.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mj@suse.cz
Subject: pdev_enable_device no longer used ?
Message-ID: <Pine.LNX.4.21.0012091122460.3465-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 I noticed a lot of drivers are setting the PCI_CACHE_LINE_SIZE
themselves, some to L1_CACHE_BYTES/sizeof(u32), others
to arbitrary values (4, 8, 16).

Then I spotted that we have a routine in the PCI subsystem
(pdev_enable_device) that sets all these to L1_CACHE_BYTES/sizeof(u32)
Further digging revealed that this routine was not getting called.

On my Athlon box, I've noticed some devices are getting their
default values set to 8 (where (I think) it should be 16 ?)

Questions:
1. Is there reason for the drivers to be setting this themselves
   to hardcoded values ?
2. Why is pdev_device_enable no longer used ?

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
