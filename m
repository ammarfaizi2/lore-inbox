Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUIGQQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUIGQQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268200AbUIGQOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:14:36 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:28178 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S268111AbUIGQNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:13:30 -0400
Date: Tue, 7 Sep 2004 11:12:54 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, axboe@suse.de
Subject: clustering and 2.6
Message-ID: <20040907161254.GA23325@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
I'm having some issues when trying to use some clustering software when
running any 2.6.x kernel.
Basically, there are 2 nodes connected to 1 storage storage enclosure.
When node 1 comes up it reserves the volume(s) in the enclosure. When
node 2 comes up the read capacity fails as expected because of the 
SCSI reservation. However, if node 1 fails node 2 breaks the reservation,
but cannot register the disk. At this time we're assuming it's because the read
capacity failed and the size of the disk is zero blocks.

The SCSI mid-layer sets a bogus size on a device when read capacity fails.
Is this the preferred way to get around this issue? Seems like there
should be a better way.

Any input is greatly appreciated.

Thanks,
mikem
