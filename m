Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTKEBPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 20:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTKEBPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 20:15:31 -0500
Received: from [198.70.193.2] ([198.70.193.2]:48445 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S262114AbTKEBP3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 20:15:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Date: Tue, 4 Nov 2003 17:15:33 -0800
Message-ID: <B179AE41C1147041AA1121F44614F0B060ED62@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Thread-Index: AcOjOk9mO3sUwLBYShaWX97iZMcMkg==
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 05 Nov 2003 01:15:33.0595 (UTC) FILETIME=[4FA1F2B0:01C3A33A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

A new version of the 8.x series driver for Linux 2.6.x kernels has
been uploaded to SourceForge:

	http://sourceforge.net/projects/linux-qla2xxx/

Changes from previous release (8.00.00b5) include:

	o Intelligent RSCN handling.
	o Slab cache allocations for driver SRBs.
	o Support larger numbers of targets.
	o Initial rework of debug logging facilities.

Review the revision notes for further details of the changes in
8.00.00b6.

Beginning with this beta, distributions of the driver will only be in
the source-type tarball format.  It's not worth the extra effort of
building a separate drop-in kernel tarball, given the varying release
periods of the driver.  Similar drop-in-kernel-tarball results can be
had by:

	driver source in /tmp/qla8_b6

	# cd <kernel source>
	# patch -p1 < /tmp/qla8_b6/add_to_kernel.diff
	# mkdir drivers/scsi/qla2xxx
	# cp /tmp/qla8_b6/* drivers/scsi/qla2xxx
	# make ...

Failover functionality is present in this distribution, at this time I
do not foresee a policy change regarding its presence in the 8.x
series driver.  The next beta release of 8.x will be failover-feature
resync'd with our latest 6.x beta (6.07.xx).

Regards,
Andrew Vasquez
