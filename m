Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbULPROX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbULPROX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbULPRLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:11:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34725 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261946AbULPRE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:04:59 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] add legacy I/O port & memory APIs to /proc/bus/pci
Date: Thu, 16 Dec 2004 09:04:46 -0800
User-Agent: KMail/1.7.1
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, willy@debian.org
References: <200412160850.20223.jbarnes@engr.sgi.com> <20041216165602.GA10560@infradead.org>
In-Reply-To: <20041216165602.GA10560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412160904.46665.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 16, 2004 8:56 am, Christoph Hellwig wrote:
> On Thu, Dec 16, 2004 at 08:50:19AM -0800, Jesse Barnes wrote:
> > This patch documents the /proc/bus/pci interface and adds some optional
> > architecture specific APIs for accessing legacy I/O port and memory
> > space. This is necessary on platforms where legacy I/O port space doesn't
> > 'soft fail' like it does on PCs, and is useful for systems that can route
> > legacy space to different PCI busses.
>
> Please don't add more interfaces to procfs.  And ioctl() on procfs is even
> more evil.

Oh come on, there's already an API there, and now it's documented even!  The 
additions are straightforward and there's no where else to put them...  /sys 
doesn't seem like a good place either, would you prefer a device driver?

I really don't see what the problem is though.  /proc/bus/pci is a commonly 
used API and I don't see it going away.  These extensions just make it a 
little more usable on platforms like sn2 and ppc.

Jesse
