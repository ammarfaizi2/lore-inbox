Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVG2ToJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVG2ToJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbVG2ToE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:44:04 -0400
Received: from fmr18.intel.com ([134.134.136.17]:52097 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262763AbVG2TnS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:43:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] Re: 2.6.13-rc3-mm3
Date: Fri, 29 Jul 2005 12:42:58 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E023F8527@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] Re: 2.6.13-rc3-mm3
thread-index: AcWUdK47NjHWd8npTUOhoC/MWhUkFgAALQfw
From: "Moore, Robert" <robert.moore@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Michael Thonke" <tk-shockwave@web.de>
Cc: <iogl64nx@gmail.com>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 29 Jul 2005 19:43:00.0045 (UTC) FILETIME=[B9DF97D0:01C59475]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+    ACPI-0287: *** Error: Region SystemMemory(0) has no handler
+    ACPI-0127: *** Error: acpi_load_tables: Could not load namespace:
AE_NOT_EXIST
+    ACPI-0136: *** Error: acpi_load_tables: Could not load tables:

This looks like a nasty case where some executable code in the table is
attempting to access a SystemMemory operation region before any OpRegion
handlers are initialized.

We certainly want to see the output of acpidump to attempt to diagnose
and/or reproduce the problem.

Bob

