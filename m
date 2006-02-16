Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWBPFOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWBPFOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 00:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWBPFOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 00:14:07 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:28106 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932476AbWBPFOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 00:14:05 -0500
Date: Thu, 16 Feb 2006 10:48:45 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Message-ID: <20060216051845.GA2968@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20060205163618.GB21972@in.ibm.com> <20060215054620.GA2966@in.ibm.com> <20060215103813.GD2966@in.ibm.com> <200602151221.53730.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602151221.53730.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 12:21:53PM +0100, Andi Kleen wrote:
> On Wednesday 15 February 2006 11:38, Bharata B Rao wrote:
> 
> > 
> > Even with this, mbind still needs to be fixed. Even though it
> > can't get a conforming zone in the node (MPOL_BIND case),
> 
> It should just use lower zones then (e.g. if no ZONE_NORMAL
> use ZONE_DMA32). yes that needs to be fixed.
> 
> How about the appended patch? Does it fix the problem for you?
> 

Yes, this fixes the problem. The kernel and the application
don't crash now with this patch.

Regards,
Bharata.
