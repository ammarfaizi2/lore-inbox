Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTISUAq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 16:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTISUAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 16:00:46 -0400
Received: from fmr09.intel.com ([192.52.57.35]:252 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261728AbTISUAe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 16:00:34 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH 2.6.x] additional kernel event notifications
Date: Fri, 19 Sep 2003 13:00:28 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AF81@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.x] additional kernel event notifications
Thread-Index: AcN+3nZTCSX3T3aTQWag4ZjXL/tw+AABU6IQAABsIbA=
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Villacis, Juan" <juan.villacis@intel.com>,
       "Andrew Morton" <akpm@osdl.org>, "Jesse Barnes" <jbarnes@sgi.com>
Cc: <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 19 Sep 2003 20:00:29.0380 (UTC) FILETIME=[ACD72840:01C37EE8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Juan simply wants to remove the ugly hack that hooks
sys_call_table.
Constituting a GPL bypass is not his purpose of adding the hooks.
Several similar hooks are already there.

Probably what's missing is value of adding those hooks in the kernel.org
tree. I guess there is a user-level command available that runs on Linux
(other than GUI-based), to analyze user/kernel performance in a detailed
fashion.

Thanks,
Jun

> -----Original Message-----
> From: Villacis, Juan
> Sent: Friday, September 19, 2003 12:32 PM
> To: Andrew Morton; Jesse Barnes
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 2.6.x] additional kernel event notifications
> 
> Hi,
> 
> Our sampling driver kernel module which uses these hooks is GPL
> and could be included in the kernel.org tree.
> 
> The current version of the driver (also GPL, but which hooks the
> sys_call_table for 2.4.x-based kernels) is posted at,
> 
>   http://www.intel.com/software/products/opensource/vdk/
> 
> We plan to post our new driver for kernel 2.6.0-test5 (with the
> event notification patch applied) on both IA-32 and IA-64 to the
> above site early next week.
> 
> -juan
> 
> 
> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org]
> Sent: Friday, September 19, 2003 11:28 AM
> To: Jesse Barnes
> Cc: Villacis, Juan; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2.6.x] additional kernel event notifications
> 
> jbarnes@sgi.com (Jesse Barnes) wrote:
> >
> > Any chance of this getting into 2.6?  I for one would like to see it
> so
> > that the performance monitoring tools can work properly without
having
> > to resort to syscall table patching.
> 
> If the code which uses these hooks is included in the kernel.org tree,
> yes.
> 
> If the code which needs the hooks is not in the kernel.org tree then
> people
> can patch the core kernel at the same time as adding the performance
> analysis patch.
> 
> If the code which needs these hooks is not appropriately licensed then
> these hooks basically constitute a GPL bypass and that is not a
> direction
> we wish to be heading in.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
