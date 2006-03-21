Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWCUVyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWCUVyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWCUVyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:54:05 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37059
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751456AbWCUVyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:54:03 -0500
Date: Tue, 21 Mar 2006 13:53:59 -0800 (PST)
Message-Id: <20060321.135359.72797865.davem@davemloft.net>
To: maule@sgi.com
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       j-nomura@ce.jp.nec.com, tony.luck@intel.com, gregkh@suse.de
Subject: Re: [PATCH 0/3] msi abstractions and support for altix
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060321143444.9913.48372.11324@lnx-maule.americas.sgi.com>
References: <20060321143444.9913.48372.11324@lnx-maule.americas.sgi.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Maule <maule@sgi.com>
Date: Tue, 21 Mar 2006 08:34:44 -0600 (CST)

> Mark
> 
> 1/3 msi-ops.patch
> 	Add an msi_arch_init() hook which can be used to perform platform
> 	specific setup prior to msi use.
> 
> 	Define a set of msi ops to implement the platform-specific tasks:
> 
> 	    setup - set up plumbing to get a vector directed at a default
> 		cpu, and return the corresponding MSI bus address and data.
> 	    teardown - inverse of msi_setup
> 	    target - retarget a vector to a given cpu
> 
> 	Define the routine msi_register() called from msi_arch_init()
> 	to set the desired ops.
> 
> 	Move a bunch of apic-specific code out of the msi core .h/.c and
> 	into a new msi-apic.c file.

Mark, thanks for doing this work.  The better abstracted out the
so-called generic MSI support code is, the better.  Several platforms
will benefit from this, such as PPC and Sparc64, both of which
cannot take advantage of MSI support in their PCI controllers because
of how x86 centric the current MSI support layer is.

Thanks again.
