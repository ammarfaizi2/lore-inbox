Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUGVTWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUGVTWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266921AbUGVTWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:22:20 -0400
Received: from cfcafwp.sgi.com ([192.48.179.6]:20531 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267180AbUGVTVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:21:48 -0400
Date: Thu, 22 Jul 2004 14:20:03 -0500
From: Robin Holt <holt@sgi.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: Altix I/O code re-org
Message-ID: <20040722192003.GA617@lnx-holt.americas.sgi.com>
References: <200407221514.i6MFEVag084696@fsgi900.americas.sgi.com> <200407221357.53404.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407221357.53404.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 01:57:53PM -0400, Jesse Barnes wrote:
> On Thursday, July 22, 2004 11:14 am, Pat Gefre wrote:
> > We have redone the I/O layer in the Altix code.
> >
> > We are posting this code for review before submitting for
> > inclusion in the 2.5 tree.
> >
> > The code can be seen at:
> > ftp://oss.sgi.com/projects/sn2/sn2-update/
> >
> > The general changes are:
> > o added new hardware support
> > o ran all code thru Lindent
> > o code cleanup (typedefs, include files, etc.)
> > o simplified the directory structure (all files under arch/ia64/sn/io/
> >   are deleted, new files are under arch/ia64/sn/ioif/)
> > o code size reduced by >50%
> > o major reorg of the code itself
> > o copyright updates
> 
> One of the most important changes this patch makes is to rip out all of the 
> SGI PCI probing code.  Our PROM now probes for I/O devices and tells the 
> kernel where they are (similar to the ACPI model, which we may get to 
> eventually).  The result is much more readable code with less duplication.  
> Please take a look and let us know if you have any feedback, since we'd like 
> to get this in as soon as we release a PROM that supports probing.

I am in the process of making this into four patches that will leave me with
a bootable system.  I need to test out the bte error handling code anyway.

The first patch will handle renaming the files, second and third are the
diffs_common* and then the fourth replaces the is the big patch.  I realize
this doesn't satisfy Christoph's request, but it is a first step.

Thanks,
Robin
