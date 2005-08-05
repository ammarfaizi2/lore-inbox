Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263132AbVHEVl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbVHEVl2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbVHEVjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:39:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:64467 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261912AbVHEVfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:35:53 -0400
Date: Fri, 5 Aug 2005 23:35:45 +0200
From: Andi Kleen <ak@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Adam Litke'" <agl@us.ibm.com>, linux-kernel@vger.kernel.org, ak@suse.de,
       christoph@lameter.com, dwg@au1.ibm.com
Subject: Re: [RFC] Demand faulting for large pages
Message-ID: <20050805213545.GB8266@wotan.suse.de>
References: <1123255298.3121.46.camel@localhost.localdomain> <200508052105.j75L5jg31470@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508052105.j75L5jg31470@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 02:05:42PM -0700, Chen, Kenneth W wrote:
> Adam Litke wrote on Friday, August 05, 2005 8:22 AM
> > Below is a patch to implement demand faulting for huge pages.  The main
> > motivation for changing from prefaulting to demand faulting is so that
> > huge page allocations can follow the NUMA API.  Currently, huge pages
> > are allocated round-robin from all NUMA nodes.   
> 
> Do users of hugetlb going to accept the fact that now app will SIGBUS
> when there aren't enough free hugetlb pages present at the time of fault?
> It's not very nice though, but is that the general consensus?

Probably not. But the simple minded overcommit check at mapping that was in the
earlier SLES codebase seemed to work for people (or at least I've never
heard a complaint about that). Adding that should be pretty easy. 

-Andi
