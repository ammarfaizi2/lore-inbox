Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTKXI1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 03:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbTKXI1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 03:27:47 -0500
Received: from mail.x-plor.com ([196.37.99.211]:15787 "EHLO
	x-plor-mail.jhb-xplor") by vger.kernel.org with ESMTP
	id S263661AbTKXI1q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 03:27:46 -0500
content-class: urn:content-classes:message
Subject: New model of SanDisk compact flash not working
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Mon, 24 Nov 2003 10:32:23 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Message-ID: <0887314A0D67E14C8C255BEF09FC3D99501157@x-plor-mail.jhb-xplor>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: New model of SanDisk compact flash not working
Thread-Index: AcOyZXu+E05GJyzBQGyEo41mlMM0Ng==
From: "gmlinux" <gmlinux@x-plor.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Nov 2003 08:32:23.0718 (UTC) FILETIME=[7BEE9460:01C3B265]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I am running a SanDisk Compact Flash disk under linux 2.4.21. The
compact flash SDCFB-256-101-80 works 100%. The problem is this model has
been discontinued and replaced with an SDCFB-256-201-80. This has a new
internal controller it would seem. During kernel boot it will attempt to
detect the partitions on the drive, and hang at this point. The new
controller seems to support DMA, while the old one didn't. If I disable
DMA (ide=nodma), then the kernel will not hang, and will boot up
correctly. However, the drives are unusable. You cannot read/write from
them. Even an fdisk fails, it displays the partition table but when you
press 'q' to quit it hangs, and then begins sending kernel debug "hdc
lost interrupt".

I also get the following boot messages, which were not present on the
old model:
hdc: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: task_no_data_intr: error=0x04 { DriveStatusError }

I am running a stock standard 2.4.21.

Any ideas?

Regards
  Garth Marran
