Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756200AbWK0CXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200AbWK0CXF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 21:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756203AbWK0CXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 21:23:05 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:22193 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1756200AbWK0CXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 21:23:03 -0500
Date: Sun, 26 Nov 2006 20:21:37 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: udev going crazy in 2.6.19-rc6-mm1
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <456A4BB1.2000303@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

udev seems to be going nuts in 2.6.19-rc6-mm1, adding and removing 
/dev/md0 and using a ton of CPU. This with the versions in both Fedora 
Core 5 and 6. This doesn't happen in older kernels, the last one I 
tested was 2.6.19-rc3-mmsomething. If I kill udevd and start it again it 
seems fine then. Some kind of feedback loop perhaps?

Here is some output from udevmonitor:

udevmonitor prints the received event from the kernel [UEVENT]
and the event which udev sends out after rule processing [UDEV]

UDEV  [1164592627.338820] add@/block/md0
UDEV  [1164592627.350451] remove@/block/md0
UEVENT[1164592627.363442] add@/block/md0
UEVENT[1164592627.363586] remove@/block/md0
UDEV  [1164592627.366819] add@/block/md0
UDEV  [1164592627.384568] remove@/block/md0
UEVENT[1164592627.397634] add@/block/md0
UEVENT[1164592627.397774] remove@/block/md0
UDEV  [1164592627.398789] add@/block/md0
UDEV  [1164592627.411989] remove@/block/md0
UEVENT[1164592627.425727] add@/block/md0
UEVENT[1164592627.425870] remove@/block/md0
UDEV  [1164592627.434808] add@/block/md0
UDEV  [1164592627.446824] remove@/block/md0
UEVENT[1164592627.460346] add@/block/md0
UEVENT[1164592627.460487] remove@/block/md0
UDEV  [1164592627.462802] add@/block/md0
UDEV  [1164592627.474785] remove@/block/md0
UEVENT[1164592627.487564] add@/block/md0
UEVENT[1164592627.487704] remove@/block/md0
UDEV  [1164592627.490820] add@/block/md0
UDEV  [1164592627.508704] remove@/block/md0
UEVENT[1164592627.521678] add@/block/md0
UEVENT[1164592627.521823] remove@/block/md0
UDEV  [1164592627.534839] add@/block/md0
UDEV  [1164592627.546471] remove@/block/md0
UEVENT[1164592627.559436] add@/block/md0
UEVENT[1164592627.559577] remove@/block/md0
UDEV  [1164592627.566836] add@/block/md0
UDEV  [1164592627.580566] remove@/block/md0
UEVENT[1164592627.593629] add@/block/md0
UEVENT[1164592627.593773] remove@/block/md0
UDEV  [1164592627.594800] add@/block/md0
UDEV  [1164592627.608021] remove@/block/md0
UEVENT[1164592627.621574] add@/block/md0

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


