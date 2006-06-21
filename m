Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbWFVBlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbWFVBlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbWFVBlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:41:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:6430 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030484AbWFVBlB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:41:01 -0400
X-IronPort-AV: i="4.06,163,1149490800"; 
   d="scan'208"; a="56530861:sNHT7513312086"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH -mm 5/6] cpu_relax(): use in ACPI lock
Date: Wed, 21 Jun 2006 15:17:02 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A47CBF37@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH -mm 5/6] cpu_relax(): use in ACPI lock
Thread-Index: AcaVdf2pmyy+6swvR2OHtk6I9jIxJAAAHfBQAAJif1A=
From: "Moore, Robert" <robert.moore@intel.com>
To: "Moore, Robert" <robert.moore@intel.com>,
       "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Cc: "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Jun 2006 01:39:50.0338 (UTC) FILETIME=[C07B4A20:01C6959C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Loop may be correctly waiting for the owner/pending bit to be set, just
checking, I don't remember all the bit values.

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Moore, Robert
> Sent: Wednesday, June 21, 2006 2:09 PM
> To: Andreas Mohr; Andrew Morton
> Cc: Brown, Len; linux-acpi@vger.kernel.org;
linux-kernel@vger.kernel.org
> Subject: RE: [PATCH -mm 5/6] cpu_relax(): use in ACPI lock
> 
> I may be interpreting this incorrectly, but are you busy-waiting on
the
> ACPI Global Lock to become free?
> 
> Bob
> 
> 
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Andreas Mohr
> > Sent: Wednesday, June 21, 2006 2:01 PM
> > To: Andrew Morton
> > Cc: Brown, Len; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org
> > Subject: [PATCH -mm 5/6] cpu_relax(): use in ACPI lock
> >
> >
> > Use cpu_relax() in __acpi_acquire_global_lock() etc.
> >
> >
