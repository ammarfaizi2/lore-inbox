Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUKHPzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUKHPzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 10:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUKHPxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 10:53:51 -0500
Received: from fmr12.intel.com ([134.134.136.15]:65180 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261898AbUKHOqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:46:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] [PATCH/RFC 0/4]Bind physical devices with ACPI devices
Date: Mon, 8 Nov 2004 22:46:30 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC032@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] [PATCH/RFC 0/4]Bind physical devices with ACPI devices
Thread-Index: AcTFmwaijU5vMXuPQD2CbZw4t8W1XAAA0btA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Matthew Wilcox" <matthew@wil.cx>, "Li, Shaohua" <shaohua.li@intel.com>
Cc: "ACPI-DEV" <acpi-devel@lists.sourceforge.net>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>, "Greg" <greg@kroah.com>,
       "Patrick Mochel" <mochel@digitalimplant.org>
X-OriginalArrivalTime: 08 Nov 2004 14:46:31.0171 (UTC) FILETIME=[BC3C9530:01C4C5A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>All we need is an acpi_get_gendev_handle that takes a struct device and
>returns the acpi_handle for it.  Now, maybe that'd be best 
>done by placing
>a pointer in the struct device, but I bet it'd be just as good to walk
>the namespace looking for the corresponding device.

  It will fail if you just simply walk namespace to find out 
the corresponding acpi object, because there are NO
hardware id or compatible id  can be passed in.
Please check function acpi_bus_match.
  The fundamental problem here is how to use device's geographical
address( or other information ) to locate the corresponding 
acpi object in namespace.

Thanks,
Luming
 




