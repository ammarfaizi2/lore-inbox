Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUAMHis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 02:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUAMHis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 02:38:48 -0500
Received: from fmr06.intel.com ([134.134.136.7]:28378 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261659AbUAMHip convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 02:38:45 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] [PATCH] 2.4/2.6 use xdsdt to print table header
Date: Tue, 13 Jan 2004 15:38:38 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720CC2@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] [PATCH] 2.4/2.6 use xdsdt to print table header
Thread-Index: AcPZbNrV/Un7Bar0SNWvSnREthg+6gANNHPg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Alex Williamson" <alex.williamson@hp.com>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
Cc: "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 13 Jan 2004 07:38:39.0465 (UTC) FILETIME=[42C81D90:01C3D9A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I'm resending this patch to get it into the main ACPI source.  This
> fixes a problem where the DSDT pointer in the FADT is NULL because it
> uses the 64bit XDSDT instead.  The current code is happy to map a NULL
> address and return success to the caller.  This can crash the 
> system or
> printout garbage headers to the console.  It's a simple 
> matter to check
> table revision and use the XDSDT in favor of the DSDT.  This has been
> living happily in both the 2.4 and 2.6 ia64 tree for some 
> time.  Please
> accept.  Thanks,

I just checked with http://lia64.bkbits.net:8080/linux-ia64-2.4 .
The patch has been merged. Please take a look at
http://lia64.bkbits.net:8080/linux-ia64-2.4/diffs/drivers/acpi/tables.c@
1.11.1.1?nav=index.html|src/.|src/drivers|src/drivers/acpi|hist/drivers/
acpi/tables.c
and
http://lia64.bkbits.net:8080/linux-ia64-2.4/diffs/drivers/acpi/tables.c@
1.11.1.2?nav=index.html|src/.|src/drivers|src/drivers/acpi|hist/drivers/
acpi/tables.c
