Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUDVROd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUDVROd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 13:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUDVROd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 13:14:33 -0400
Received: from fmr11.intel.com ([192.55.52.31]:32683 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S264577AbUDVRO0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 13:14:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/3] efivars driver update and move
Date: Thu, 22 Apr 2004 10:14:05 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFEAB3@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/3] efivars driver update and move
Thread-Index: AcQoiXClS/Fo3Q3fRqmFKH7vAFFu9QAAY/cA
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Matt Tolentino" <metolent@snoqualmie.dp.intel.com>
Cc: <akpm@osdl.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <Matt_Domsch@dell.com>
X-OriginalArrivalTime: 22 Apr 2004 17:14:06.0495 (UTC) FILETIME=[37CDCAF0:01C4288D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I like these changes.

Thanks!  

> I did notice that the new drivers/.../efivars.c is not identical to
> the old arch/ia64/kernel/efivars.c (the hints to emacs were removed).
> I like the emacs hint removal, but didn't review patch for any other
> differences.

Right, it's been fully converted to sysfs.  Just for reference, the 
resultant sysfs tree looks something like:

/sys |
     ...
     |-firmware 
	       |-efi
		   |-systab
		   |-vars 
			 |- BootNext-xxxx-xxx-x-x-x-x *
				|-attributes
				|-data
				|-guid
				|-raw_var
				|-size
			 |- BootCurrent-xxxxxx-x-x-x-x *
			 |- ConOut-xxxx-x-x-x-x-x-x-*
			 ...
			 |- del_var
			 |- new_var 

where xxxx-x-x-x-x-x is the GUID.  

> Any plans to consolidate other bits from efi.c?  There are a number
> of things there that look like they could be shared:

Yes, I plan to consolidate as much of the common code as possible soon.


matt

