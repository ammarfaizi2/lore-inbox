Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269606AbUI3XPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269606AbUI3XPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269611AbUI3XPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:15:43 -0400
Received: from smtp2.eldosales.com ([63.78.12.18]:1805 "EHLO
	tweeter.eldosales.com") by vger.kernel.org with ESMTP
	id S269606AbUI3XPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:15:33 -0400
Posted-Date: Thu, 30 Sep 2004 16:15:32 -0700
Subject: Megaraid random loss of luns
From: comsatcat <comsatcat@earthlink.net>
Reply-To: comsatcat@earthlink.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1096586111.25603.13.camel@solaris.skunkware.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Sep 2004 16:15:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if this is the correct list or not to ask about this, but
it seemed proper.  We have a machine running the megaraid module that
came with vanilla 2.6.7.  Earlier this morning all the luns suddenly
disappeared for no apparent reason.

The kernel logged the following messages:

Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7ade cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7adf cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7b00 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7b0e cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7b0f cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7b13 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7b14 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7b15 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7b18 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7b19 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7b1a cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7b1b cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7b1c cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:29 core-easynews kernel: megaraid: ABORTING-c7a7b28 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b29 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b29[6e], fw
owner.
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b2a cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b2a[41], fw
owner.
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b2b cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b2b[1e], fw
owner.
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b2c cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b2d cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b32 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b33 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b48 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b49 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b4a cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b4b cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b4c cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b4d cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b4e cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7b4e[8], fw
owner.
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7bb1 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7bb2 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7bb3 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7bb4 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7bbf cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7bc0 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7bd0 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7bd1 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7bd2 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:30 core-easynews kernel: megaraid: ABORTING-c7a7bd4 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7bd5 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7bd5[e], fw
owner.
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c01 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c02 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c03 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c04 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c05 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c06 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c07 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c08 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c0b cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c0c cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c0d cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c0e cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7c93 cmd=2a
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7cac cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7cac[57], fw
owner.
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7cad cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7cad[6a], fw
owner.
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7cd2 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7cd3 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7cd4 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7cd4[4a], fw
owner.
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7cd5 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:31 core-easynews kernel: megaraid: ABORTING-c7a7ce6 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7ce7 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7ceb cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7ceb[14], fw
owner.
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7cec cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7cec[6f], fw
owner.
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7ced cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7ced[b], fw
owner.
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7d24 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7d25 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7d25[3f], fw
owner.
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7d31 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7d32 cmd=28
<c=0 t=0 l=0>
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7d39 cmd=28
<c=0 t=1 l=0>
Sep 30 12:41:32 core-easynews kernel: megaraid: ABORTING-c7a7d3a cmd=28
<c/O to offline device


At this point the scsi subsystem kicked in with the following message
repeated 100 or so times when an I/O attempt was made:

Sep 30 12:41:33 core-easynews kernel: scsi2 (1:0): rejecting I/O to
offline device

Then the following again from the megaraid module:

Sep 30 12:41:33 core-easynews kernel: megaraid: aborted cmd c7a7ceb[14]
complete.


At this point I could no longer access any of the luns.  I checked the
lun configuration on the raid controller and no disks had failed and
everything was okay.  I reloaded the module and all luns came back
normally with no data corruption.

Could someone provide an explanation of what exactly went wrong if
possible (if the megaraid driver was at fault or the raid controller)? 
Are there any known bugs with large raid 5 volumes using the megaraid
driver?  The volumes are each 325G (4 total) in this situation.  We've
experienced other problems with the megaraid driver such as 1TB luns
(two per controller) loosing almost all disks in them (I thought this
was a controller problem at first, but we have 2 different models of
controllers, 1 LSI PCI 320-4x and 2 LSI PCI 320-2x's, on 3 identical
hardware configurations and have been experiencing problems on all of
them).


Thanks,
Ben

