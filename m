Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbULWIvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbULWIvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 03:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbULWIvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 03:51:36 -0500
Received: from fmr20.intel.com ([134.134.136.19]:25524 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261176AbULWIvf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 03:51:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: the patch of restore-pci-config-space-on-resume break S1 on ASUS2400 NE
Date: Thu, 23 Dec 2004 16:51:09 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84069D51E8@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: the patch of restore-pci-config-space-on-resume break S1 on ASUS2400 NE
Thread-Index: AcToynoSDsCTlLylTEWftsMuv/Uc3wAAgFTA
From: "Yu, Luming" <luming.yu@intel.com>
To: <arjanv@redhat.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Dec 2004 08:51:10.0959 (UTC) FILETIME=[8CFD27F0:01C4E8CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

Since 2.6.7, the Changes for drivers/pci/pci-driver.c@1.37 make my
ASUS 2400NE hang on S1 resume. 

Should we by-pass pci_default_suspend(resume) for S1?
Because, ACPI spec defines : in S1, all system context is preserved 
with the exception of CPU caches.

Thanks,
Luming
