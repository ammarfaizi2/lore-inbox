Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWARSCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWARSCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWARSCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:02:41 -0500
Received: from palrel10.hp.com ([156.153.255.245]:10694 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S964776AbWARSCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:02:40 -0500
Date: Wed, 18 Jan 2006 10:02:43 -0800
From: Grant Grundler <iod00d@hp.com>
To: Sean Hefty <mshefty@ichips.intel.com>
Cc: Grant Grundler <iod00d@hp.com>, Sean Hefty <sean.hefty@intel.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] RE: [PATCH 2/5] [RFC] Infiniband: connection abstraction
Message-ID: <20060118180243.GD6818@esmail.cup.hp.com>
References: <ORSMSX401FRaqbC8wSA0000003e@orsmsx401.amr.corp.intel.com> <ORSMSX401FRaqbC8wSA00000040@orsmsx401.amr.corp.intel.com> <20060118020342.GB3740@esmail.cup.hp.com> <43CE7EDB.7030201@ichips.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CE7EDB.7030201@ichips.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 09:46:03AM -0800, Sean Hefty wrote:
> Grant Grundler wrote:
> >>+static void cm_mask_compare_data(u8 *dst, u8 *src, u8 *mask)
...
> >Is this code going to get invoked very often?
> 
> In practice, it would be invoked when matching any listen requests 
> originating from the CMA (RDMA connection abstraction).

hrm..I'm not sure how to translate your answer into a workload.
e.g. which netperf or netpipe test would excercise this alot?
Or would it take something like MPI or specweb/ttcp?

> >If so, can the mask operation use a "native" size since
> >IB_CM_PRIVATE_DATA_COMPARE_SIZE is hard coded to 64 byte?
> >
> >e.g something like:
> >	for (i = 0; i < IB_CM_PRIVATE_DATA_COMPARE_SIZE/sizeof(unsigned 
> >	long);
> >									i++)
> >		((unsigned long *)dst)[i] = ((unsigned long *)src)[i] 
> >						& ((unsigned long *)mask)[i];
> 
> Yes - something like this should work.  Thanks.

Do you need a patch?
I can submit one but it will be untested.

thanks,
grant
