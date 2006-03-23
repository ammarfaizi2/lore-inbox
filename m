Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWCWVpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWCWVpM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWCWVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:45:12 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:5989 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422701AbWCWVpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:45:10 -0500
Date: Thu, 23 Mar 2006 23:45:07 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@us.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] x86-64: Calgary IOMMU - Calgary specific bits
Message-ID: <20060323214507.GE25830@rhun.haifa.ibm.com>
References: <20060320084848.GA21729@granada.merseine.nu> <200603231731.34097.ak@suse.de> <20060323175345.GB2598@granada.merseine.nu> <200603231902.04043.ak@suse.de> <20060323190334.GD25830@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323190334.GD25830@rhun.haifa.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 09:03:34PM +0200, Muli Ben-Yehuda wrote:

> > > X works :-) 
> > 
> > So it's behind a bridge that doesn't have an IOMMU?
> 
> No, it's behind a bridge that does have an IOMMU and is running with
> translation enabled (it's on PHB 0 on this machine). I guess you are
> concerned with userspace access to the graphics controller directly,
> without a kernel driver having set up mapping previously? I will look
> into it but emprirically X works so either userspace is not triggering
> DMAs or the mappings have been set up by a driver.

Turns out that X does work on my machine (SLES 9SP2) but dies with a
bad translation error on Jon's machine, which is otherwise identical
except it runs gentoo. We are thinking how to best address this (add
IOMMU aware drivers to X? *shudder*), but will disable translation by
default on PHB 0 in the mean time for a friendlier user
experience.

Thanks,
Muli
