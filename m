Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbTISTcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbTISTcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:32:14 -0400
Received: from fmr09.intel.com ([192.52.57.35]:38875 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261691AbTISTcM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:32:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH 2.6.x] additional kernel event notifications
Date: Fri, 19 Sep 2003 12:32:08 -0700
Message-ID: <7F740D512C7C1046AB53446D372001732DEC70@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.x] additional kernel event notifications
Thread-Index: AcN+3nZTCSX3T3aTQWag4ZjXL/tw+AABU6IQ
From: "Villacis, Juan" <juan.villacis@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Jesse Barnes" <jbarnes@sgi.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2003 19:32:09.0029 (UTC) FILETIME=[B75A2F50:01C37EE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Our sampling driver kernel module which uses these hooks is GPL
and could be included in the kernel.org tree.

The current version of the driver (also GPL, but which hooks the
sys_call_table for 2.4.x-based kernels) is posted at,

  http://www.intel.com/software/products/opensource/vdk/

We plan to post our new driver for kernel 2.6.0-test5 (with the
event notification patch applied) on both IA-32 and IA-64 to the
above site early next week.

-juan


-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Friday, September 19, 2003 11:28 AM
To: Jesse Barnes
Cc: Villacis, Juan; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.x] additional kernel event notifications

jbarnes@sgi.com (Jesse Barnes) wrote:
>
> Any chance of this getting into 2.6?  I for one would like to see it
so
> that the performance monitoring tools can work properly without having
> to resort to syscall table patching.

If the code which uses these hooks is included in the kernel.org tree,
yes.

If the code which needs the hooks is not in the kernel.org tree then
people
can patch the core kernel at the same time as adding the performance
analysis patch.

If the code which needs these hooks is not appropriately licensed then
these hooks basically constitute a GPL bypass and that is not a
direction
we wish to be heading in.

