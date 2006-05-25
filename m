Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWEYS4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWEYS4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWEYS4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:56:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:41838 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030339AbWEYS4E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:56:04 -0400
X-IronPort-AV: i="4.05,173,1146466800"; 
   d="scan'208"; a="41397476:sNHT2465282316"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.17-rc4-mm3 - kernel panic
Date: Thu, 25 May 2006 14:55:37 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB68F03DB@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-rc4-mm3 - kernel panic
Thread-Index: AcaALANwnXEg1L/mRwCfi8KDwZc3kwAAFqdg
From: "Brown, Len" <len.brown@intel.com>
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc: "Andreas Saur" <saur@acmelabs.de>, <linux-acpi@vger.kernel.org>,
       <pavel@suse.cz>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 May 2006 18:55:38.0505 (UTC) FILETIME=[D01BFF90:01C6802C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>the possibility that the acpiphp driver may enter it's 
>module_init before the dock driver has completed it's init?

Would there be a problem if the init for acpiphp ran
before the init for dock started?

(no, I don't think that use of acpi_walk_namespace
 would/could have any effect on the order)

I don't know if we have tight controls on module load order.
IIR it depends on the link order in the makefiles for
static modules, and the init scripts for loadable modules.

-Len
