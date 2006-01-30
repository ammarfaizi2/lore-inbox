Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWA3TKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWA3TKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWA3TKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:10:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33481 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964884AbWA3TKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:10:03 -0500
Date: Mon, 30 Jan 2006 13:09:37 -0600
From: Mark Maule <maule@sgi.com>
To: Greg KH <greg@kroah.com>
Cc: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>
Subject: Re: FW: MSI-X on 2.6.15
Message-ID: <20060130190937.GB31945@sgi.com>
References: <D4CFB69C345C394284E4B78B876C1CF10B8AC113@cceexc23.americas.cpqcorp.net> <20060130173852.GA16259@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130173852.GA16259@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Ashok Raj has already responded, there was support for APIC-based MSI[-X]
on ia64 before my patches.  I personally do not know if it worked or not, my
suspicion is that it didn't get much airtime due to MSI being off by default
until somewhat recently.

I believe MSI was working on zx1 after my patch, so I suspect it worked there
before my patch as well.  I can't speak to MSI-X.

Mike, is your driver capable of MSI (vs. MSI-X)?  As a datapoint, could you
try that?

Mark

On Mon, Jan 30, 2006 at 09:38:52AM -0800, Greg KH wrote:
> On Mon, Jan 30, 2006 at 10:33:50AM -0600, Miller, Mike (OS Dev) wrote:
> > Greg KH,
> > We have the same results on 2.6.15, the MSI-X table is all zeroes. See
> > below. Any ideas of what to do do next? The driver works on x86_64. Is
> > there any thing extra I need to do on ia64?
> 
> ia64 didn't really have msi support before the latest -mm kernel, right
> Mark?
> 
> > Andrew, can you try 2.6.16-rc1 and/or the rc1-git4 kernels?
> 
> How about the -mm kernel?
> 
> thanks,
> 
> greg k-h
