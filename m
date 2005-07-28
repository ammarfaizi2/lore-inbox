Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVG1SQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVG1SQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVG1SOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:14:08 -0400
Received: from serv01.siteground.net ([70.85.91.68]:62948 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261889AbVG1SOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:14:01 -0400
Date: Thu, 28 Jul 2005 11:14:21 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, shai@scalex86.org
Subject: Re: [patch] mm: Ensure proper alignment for node_remap_start_pfn
Message-ID: <20050728181421.GA3842@localhost.localdomain>
References: <20050728004241.GA16073@localhost.localdomain> <20050727181724.36bd28ed.akpm@osdl.org> <20050728013134.GB23923@localhost.localdomain> <1122571226.23386.44.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122571226.23386.44.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 10:20:26AM -0700, Dave Hansen wrote:
> On Wed, 2005-07-27 at 18:31 -0700, Ravikiran G Thirumalai wrote:
> > On Wed, Jul 27, 2005 at 06:17:24PM -0700, Andrew Morton wrote:
> > > Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > > >
> > Yes, it does cause a crash.
> 
> I don't know of any NUMA x86 sub-arches that have nodes which are
> aligned on any less than 2MB.  Is this an architecture that's supported
> in the tree, today?

SRAT need not guarantee any alignment at all in the memory affinity 
structure (the address in 64-bit byte address).   And yes, there are x86-numa
machines that run the latest kernel tree and face this problem.

Thanks,
Kiran
