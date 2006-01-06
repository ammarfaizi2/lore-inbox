Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752572AbWAFWhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbWAFWhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbWAFWhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:37:10 -0500
Received: from lists.us.dell.com ([143.166.224.162]:43199 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S1752572AbWAFWhE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:37:04 -0500
Date: Fri, 6 Jan 2006 16:36:52 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Message-ID: <20060106223652.GA9230@lists.us.dell.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C081899@fmsmsx406.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C081899@fmsmsx406.amr.corp.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 11:03:17AM -0800, Tolentino, Matthew E wrote:
> Matt Domsch <> wrote:
> > Enable DMI table parsing on ia64.
> ...
> > +#ifndef CONFIG_EFI
> > +void __init dmi_scan_machine(void)
> > +{
> >  	char __iomem *p, *q;
> > +	int rc;
> 
> Hi Matt,
> 
> You could potentially consolidate the two dmi_scan_machine functions
> and lose the ifdef (and duplication) by checking efi_enabled instead.  
> 'efi_enabled' is already ifdef'd in the EFI header (defined to 1 for 
> ia64) specifically for this situation.  

Good idea, patch to follow.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
