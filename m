Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264395AbTLEUw3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 15:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbTLEUw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 15:52:29 -0500
Received: from [198.70.193.2] ([198.70.193.2]:65357 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S264400AbTLEUwY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 15:52:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
Date: Fri, 5 Dec 2003 12:52:31 -0800
Message-ID: <B179AE41C1147041AA1121F44614F0B0598D7F@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
Thread-Index: AcO7cbMZjhRF8YHOSHaO2cseGM+QAw==
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 05 Dec 2003 20:52:31.0953 (UTC) FILETIME=[B3D8BC10:01C3BB71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

A new version of the 8.x series driver for Linux 2.6.x kernels has
been uploaded to SourceForge:

	http://sourceforge.net/projects/linux-qla2xxx/

Changes from previous release (8.00.00b6) include:

	o Merge several large patches from Christoph Hellwig:
	  - split driver into a common qla2xxx.ko lib with light-weight
	    ISP driver modules (qla2?xx.ko).
	  - Failover code optional and split from main code.
	o Merge several patches from Jes Sorensen:
	  - IA64 allocations
	  - PCI posting issues. 
	o Clean-up slab-cache allocations (-> mempool).
	o Fix GA_NXT portid preparation problem.
	o NVRAM interface tool for all hardware platforms.
	o Tar-ball extracts to qla2xxx-<version>/

Review the revision notes for further details of the changes in
8.00.00b7.

Some words regarding the NVRAM tool:

	WARNINGS
		EXTREME CARE MUST TO BE TAKEN WHEN CHANGING 
		NVRAM CONTENTS, INCORRECT DATA MAY RENDER THE ADAPTER 
		UNUSABLE TO THE POINT THAT THE OPERATING SYSTEM MAY 
		NO LONGER FUNCTION.

	NOTES
		Each NVRAM is has a unique port name for every adapter 
		so the same data file generated from the NVRAM tool
		cannot be used to load multiple adapters. Each adapter 
		must have its NVRAM dumped then modified before loading. 
		In the case of adapters that contain multiple ports each 
		port has its own unique NVRAM and must be programmed 
		separately.

	Use of this tool is *STRONGLY* discouraged.  Most if not all 
	useful NVRAM parameters have module_param overrides.  This tool
	is meant only to assist users who use QLogic HBAs on platforms
	with no GUI/CLI support.

Finally, a large thanks goes out to Christoph for his persistence and
efforts.

Regards,
Andrew Vasquez
QLogic Corporation
