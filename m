Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWG0VAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWG0VAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWG0U75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:59:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:23971 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751168AbWG0U7b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:59:31 -0400
X-IronPort-AV: i="4.07,189,1151910000"; 
   d="scan'208"; a="97151528:sNHT15655486"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] acpi: Add lock annotations to acpi_os_acquire_lock andacpi_os_release_lock
Date: Thu, 27 Jul 2006 16:59:21 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601168989@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] acpi: Add lock annotations to acpi_os_acquire_lock andacpi_os_release_lock
Thread-Index: AcaxrmOElUSK9BtYTuCGzGAzRbN/bgAECAmg
From: "Brown, Len" <len.brown@intel.com>
To: "Josh Triplett" <josht@us.ibm.com>, <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 27 Jul 2006 20:59:23.0406 (UTC) FILETIME=[89B83AE0:01C6B1BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh,
if __acquires() and __releases() are always handled in a
Linux kernel build, then we don't need the bit in actypes.h.
Linux specific changes for sparse will never be used
in upstream ACPICA -- Linux can just diverge on these bits,
like we do for other annotations, like asmlinkage.

thanks,
-Len
