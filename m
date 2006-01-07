Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbWAGQe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbWAGQe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 11:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbWAGQe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 11:34:57 -0500
Received: from imo-m27.mx.aol.com ([64.12.137.8]:51855 "EHLO
	imo-m27.mx.aol.com") by vger.kernel.org with ESMTP id S1030498AbWAGQe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 11:34:56 -0500
Date: Sat, 07 Jan 2006 11:34:39 -0500
From: andyliebman@aol.com
Message-Id: <8C7E1BF63B9F5F4-AC8-506C@FWM-M45.sysops.aol.com>
X-MB-Message-Source: WebUI
X-MB-Message-Type: User
X-Mailer: AOL WebMail 15106
Subject: Changes in SATA, IDE and ATAPI configuration
Content-Type: text/plain; charset="us-ascii"; format=flowed
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
X-AOL-IP: 64.12.193.247
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the risk of getting flamed for asking a basic question here, could I 
suggest that a kernel and/or driver developer provide a brief "how-to 
acticle" somehere (like on the kernel.org site, or in the kernel 
documentation) that explains the way things have changed from the early 
2.6.x days to more recent kernels like 2.6.14 or 2.6.15 with respect to 
configuring fundamental devices like IDE drives, SATA drives, and ATAPI 
drives.

Personally, I have been struggling for about two weeks to move an image 
of an IDE OS Drive that's running a 2.6.14 kernel over to a SATA drive. 
Clearly, SATA + ATAPI is not the same as IDE + ATAPI. Apparently, 
several factors MIGHT be causing my ATAPI CDROM not to show up when I 
boot from the SATA drive:

-- BIOS settings for the ICH5 SATA controller on my Xeon motherboard 
(Auto, SATA, PATA?)
-- Whether the CD is connected to the Primary or Secondary IDE channel
-- Use (or NOT) of "options libata atapi_enabled=1" in modprobe.conf
-- Order of loading modules
-- Use (or NOT) of the AHCI module. When making fresh installs onto 
SATA drives, some distributions seem to load the AHCI module and some 
don't, on exactly the same hardware with the same kernel.

Whatever it is, I haven't found the magic formula for making the 
transfer from IDE to SATA work. And various "support personnel" 
associated with my two favorite Linux distributions have similarly 
failed to provide a solution. I am not the only one struggling with 
these issues. Just seach on the Forum of ANY distribution and you will 
find people having similar issues.

Things used to be so simple. But now, with improvements like SATA, UDEV 
and libata, for some users who are upgrading things have gotten more 
confusing than ever. A little basic info -- if you use A, you have to 
use B. X has to load before Y -- etc. might go a long way to making 
some happier Linux users. I feel as if I have made a valient effort to 
find the answers myself. Linux shouldn't be THIS difficult.

Regards,
Andy Liebman
