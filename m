Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310686AbSCMPvy>; Wed, 13 Mar 2002 10:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310676AbSCMPvd>; Wed, 13 Mar 2002 10:51:33 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:8119 "EHLO ns1.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S310686AbSCMPv1>;
	Wed, 13 Mar 2002 10:51:27 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 13 Mar 2002 07:51:14 -0800
Message-Id: <200203131551.HAA09551@adam.yggdrasil.com>
To: davej@suse.de
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I pushed that revert to Linus. It was basically a cp of the driver
>from the 2.4 tree to the current 2.5 one, diff and send. 

	Thanks for the information.  If I understand you correctly,
you are saying that Linus's current 2.5 tree (2.5.7-pre1) has the
new driver from 2.4, albeit one that does not compile.

	Diffing the 2.4.18 and 2.5.6 versions of NCR53C8x.c and
fdomain.c, they look the same, aside from some io_request_lock's
replaced by scsi_host->host_lock.  dtc.c appears to have a few
minor changes, which I assume are for 2.5.  So, it looks like
the NCR53C80 drivers in 2.5.7-pre1 are approximately the correct
starting point for generating working NCR53C80 drivers in 2.5 (as
opposed to recopying them from 2.4).  Please correct me if I am wrong.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
