Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbULTSPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbULTSPt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 13:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbULTSPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 13:15:49 -0500
Received: from fmr19.intel.com ([134.134.136.18]:17096 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261593AbULTSPn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 13:15:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]PCI Express Port Bus Driver
Date: Mon, 20 Dec 2004 10:15:30 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024074749A1@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]PCI Express Port Bus Driver
Thread-Index: AcTklVIZX01d0RhTSZ6Jb8kFP6PmRgCJ4HMg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 20 Dec 2004 18:15:31.0491 (UTC) FILETIME=[E4330F30:01C4E6BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friday, December 17, 2004 4:06 PM, Greg KH wrote: 
> Hm, I get a oops message at boot time, on a non-pci express box, with
> PCI_GOMMCONFIG enabled and your patch.  Something down in the ACPI
> subsystem. 
>
> Have you tested this kind of configuration?
With PCI_GOMMCONFIG enabled and PCIE Port Bus driver included, I got
kernel 
panic at boot time on a non-pci express box. Similar to your case, I 
observed something down in the ACPI subsystem. I tested the other case 
where the kernel is built with PCI_GOMMCONFIG and without PCIE Port 
Bus driver being included, same kernel panic occurred at boot time. I
tested 
another case where the kernel is built with PCI_GOANY and with PCIE Port

Bus driver being included, the kernel boots fine. Based on these test
results, 
it seems that PCI_GOMMCONFIG, not PCIE Port Bus driver, is a root cause 
of kernel panic.

> I'll hold off on applying the patch for now due to this :)
It seems that it is ok to apply the patch for now. What do you think?

Thanks,
Long
