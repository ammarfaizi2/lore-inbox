Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWALJK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWALJK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWALJK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:10:27 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:21226 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964973AbWALJKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:10:25 -0500
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
From: Dave Hansen <haveblue@us.ibm.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       xen-devel@lists.xensource.com
In-Reply-To: <43C5B59C.8050908@us.ibm.com>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>
	 <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com>
	 <43C5B59C.8050908@us.ibm.com>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 01:10:22 -0800
Message-Id: <1137057022.5397.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 20:49 -0500, Mike D. Day wrote:
> Greg KH wrote:
> >>/sys/xen/version may not be the best example for this discussion. What
> >>is important is that this attribute is obtained from Xen using a
> >>hypercall. Sysfs works great to prove the xen version and other
> >>similar xen attributes to userspace.
> > 
> > 
> > Like what?  Specifics please.
> 
> What privileges are granted to the kernel by xen - can the kernel 
> control real devices or just virtual ones.

Why wouldn't this simply be transparent from what devices Linux detects?
If Linux doesn't detect any raw PCI devices, then it obviously doesn't
have access to any.

Why don't any other hypervisors need this?

> How many other domains 
> (virtual machines) are being hosted by xen? How much memory is available 
> for ballooning (increasing the memory used by kernels through the 
> remapping of pages inside the hypervisor).

There are definitely things that are exceedingly helpful.  However,
there are at least two other hypervisor-ish things that I can think of
which do the exact same kinds of things.  Perhaps it would be helpful to
collaborate with them and produce a common interface. (uml, s390, maybe
some of the powerpc hypervisors)

> Can the domain be migrated to another physical host?
> What scheduler is Xen using (xen has plug-in 
> schedulers)? All the actual information resides within the xen 
> hypervisor, not the linux kernel.

Other than debugging and curiosity, why are these things needed?

-- Dave

