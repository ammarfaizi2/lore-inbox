Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTGKPzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbTGKPzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:55:45 -0400
Received: from fmr06.intel.com ([134.134.136.7]:37345 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263462AbTGKPz0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:55:26 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [Pcihpd-discuss] Re: PCI Hot-plug driver patch for 2.5.74 kernel
Date: Fri, 11 Jul 2003 09:10:03 -0700
Message-ID: <42050DF556283A4D977B111EB706320810026E@orsmsx407.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Pcihpd-discuss] Re: PCI Hot-plug driver patch for 2.5.74 kernel
Thread-Index: AcNHZB5M2t29hks5SkWQut/ZGv5jCgAWwrNw
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: "Zink, Dan" <dan.zink@hp.com>, "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <pcihpd-discuss@lists.sourceforge.net>,
       "Luck, Tony" <tony.luck@intel.com>
X-OriginalArrivalTime: 11 Jul 2003 16:10:03.0908 (UTC) FILETIME=[E34D0C40:01C347C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

> We've looked at the patch a bit and would prefer that it not
> be applied as is.  In particular, it seems to remove proper
> detection for features that are in the driver today.  For example,
> the decisions that are made off the subsytem ID...

All the functionality of the original driver should still be there.
Are you referring to the chunk of code in cpqhpc_probe() that bases
on the subsystem ID to detect the capability of the HPC.  This 
feature is in phphpc_get_ctrl_cap() in cpqphp_hpc.c.  This patch use
a 16-bit variable, pctlrcap, to capture the capability and decode it
when needed. I can provide more detail information on this if you 
need. Let me know if there are some other features you found missing.

> Would it be possible to split this into smaller patches that
> each do one particular thing?

This patch has moved the code around quite a bit to separate out the 
resource gathering code to support both HRT & ACPI, and to put the 
code that is specific to the Compaq HPC HW programming model in 
cpqphp_hpc.c.  If you feel there is a need to split the patch into 
smaller ones, we can further discuss on that.

Thanks,
Dely

