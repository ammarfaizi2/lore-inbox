Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbTJFQUb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTJFQUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:20:31 -0400
Received: from cs666870-201.austin.rr.com ([66.68.70.201]:5763 "EHLO
	mod.homelinux.org") by vger.kernel.org with ESMTP id S262345AbTJFQUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:20:08 -0400
From: Sraphim <sraphim@mofd.net>
To: linux-kernel@vger.kernel.org
Subject: SBP2 does not work with Apple iPod in versions later than 2.4.19
Date: Mon, 6 Oct 2003 11:49:28 -0500
User-Agent: KMail/1.5
Organization: Mists of Destiny
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310061149.28426.sraphim@mofd.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently upgraded from 2.4.19 to 2.4.22, and have discovered that the 
SBP2 module no longer functions correctly with the Apple iPod (which should 
behave like a standard firewire disk drive). In the 2.4.19 kernel, it works 
perfectly, every time, however, it does not anymore. I have also tried every 
version after 2.4.19, and the same problem exists.

It detects the device fine, and it "logs into" it, and on the screen of the 
iPod, it has the "do not disconnect' sign, meaning that it did that step 
successfully, but its impossible to mount. In the old kernel version, I would 
use mount /dev/sda2 , and it would mount the volume just fine, but now, mount 
claims that sda2 is not a valid block device. 

Here is the output from dmesg after I insmod sbp2. Note how there is no 
information regarding SCSI device assignment and the like:

ieee1394: Node added: ID:BUS[0-01:1023]  GUID[000a2700020c8630]
ieee1394: The root node is not cycle master capable; selecting a new root node 
and resetting...
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
sbp2: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]

I am sure that I compiled in SCSI support, and SCSI disk/CDROM/tape/generic 
support into the kernel. I have also compiled in support for ieee1394. No 
matter what, it does not work correctly. Am I missing something? Or perhaps 
this new SBP2 module requires me to pass something to it in order to enable 
the SCSI emulation or something?
