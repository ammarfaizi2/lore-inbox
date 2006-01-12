Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030450AbWALP2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbWALP2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbWALP2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:28:54 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62336 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030450AbWALP2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:28:53 -0500
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
From: Dave Hansen <haveblue@us.ibm.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <43C66D12.5090503@us.ibm.com>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>
	 <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com>
	 <43C5B59C.8050908@us.ibm.com>
	 <1137057022.5397.7.camel@localhost.localdomain>
	 <43C66D12.5090503@us.ibm.com>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 07:28:43 -0800
Message-Id: <1137079724.5397.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 09:52 -0500, Mike D. Day wrote:
> Dave Hansen wrote:
> > On Wed, 2006-01-11 at 20:49 -0500, Mike D. Day wrote:
> >>Can the domain be migrated to another physical host?
> >>What scheduler is Xen using (xen has plug-in 
> >>schedulers)? All the actual information resides within the xen 
> >>hypervisor, not the linux kernel.
> > 
> > Other than debugging and curiosity, why are these things needed?
> 
> Debugging is always a good reason :) but I'm specifically thinking of 
> systems management tools, deployment of virtual machines, and migration. 
> All of these attributes are important for tools that manage, deploy, or 
> migrate.

-ETOOMANYBUZZWORDS :)

One concern I have with this approach is that it is for things for which
a need is _anticipated_, instead of things that are actually needed.  It
is awesome that this is being done in advance, but you have to be
careful not to throw the kitchen sink at the problem from the beginning.

Would a potential workload manager contact the individual Xen partitions
in order to get an overview of the entire machine?  Why would it not
simply contact the controlling partition?

-- Dave

