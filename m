Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVLIXqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVLIXqX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 18:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVLIXqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 18:46:23 -0500
Received: from serv01.siteground.net ([70.85.91.68]:491 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964898AbVLIXqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 18:46:23 -0500
Date: Fri, 9 Dec 2005 15:46:12 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Rohit Seth <rohit.seth@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, zach@vmware.com,
       shai@scalex86.org, nippung@calsoftinc.com
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page boundary
Message-ID: <20051209234612.GB3676@localhost.localdomain>
References: <20051208215514.GE3776@localhost.localdomain> <1134083357.7131.21.camel@akash.sc.intel.com> <20051208231141.GX11190@wotan.suse.de> <1134084367.7131.32.camel@akash.sc.intel.com> <20051208232610.GY11190@wotan.suse.de> <1134085511.7131.53.camel@akash.sc.intel.com> <20051208234320.GB11190@wotan.suse.de> <20051209221922.GA3676@localhost.localdomain> <1134169287.21462.7.camel@akash.sc.intel.com> <20051209225921.GO11190@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209225921.GO11190@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 11:59:21PM +0100, Andi Kleen wrote:
> On Fri, Dec 09, 2005 at 03:01:27PM -0800, Rohit Seth wrote:
> > > > For the BP case it's ok as 
> > > > long as the beginning is correctly aligned and the rest 
> > > > is read-only.
> > > 
> > > Just that any writes on the bp GDT will invalidate the idt_table cacheline,
> > > which is read mostly (as Nippun pointed out).  So could we keep the padding
> > > as it is for the BP too? 
> > > 
> > 
> > Do you write into GDT often for this to be an issue.  The reason I'm
> 
> The context switch writes into the GDT to switch around the TLS segments

Yup.

> 
> > asking this because the per-cpu IDTs that Andi refered in the future.
> > If we are really not using too many bytes in GDT then rest of the page
> > can be used for IDT and such mostly RO data.
> 
> Once I implement that it can be shared with that page.

Yes, that will be nice.

Thanks,
Kiran
