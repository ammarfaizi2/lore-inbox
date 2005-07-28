Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVG1RXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVG1RXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVG1RVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:21:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:64189 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261462AbVG1RUk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:20:40 -0400
Subject: Re: [patch] mm: Ensure proper alignment for node_remap_start_pfn
From: Dave Hansen <haveblue@us.ibm.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, shai@scalex86.org
In-Reply-To: <20050728013134.GB23923@localhost.localdomain>
References: <20050728004241.GA16073@localhost.localdomain>
	 <20050727181724.36bd28ed.akpm@osdl.org>
	 <20050728013134.GB23923@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 10:20:26 -0700
Message-Id: <1122571226.23386.44.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 18:31 -0700, Ravikiran G Thirumalai wrote:
> On Wed, Jul 27, 2005 at 06:17:24PM -0700, Andrew Morton wrote:
> > Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > >
> > > While reserving KVA for lmem_maps of node, we have to make sure that
> > > node_remap_start_pfn[] is aligned to a proper pmd boundary.
> > > (node_remap_start_pfn[] gets its value from node_end_pfn[])
> > > 
> > 
> > What are the effects of not having this patch applied?  Does someone's
> > computer crash, or what?
> 
> Yes, it does cause a crash.

I don't know of any NUMA x86 sub-arches that have nodes which are
aligned on any less than 2MB.  Is this an architecture that's supported
in the tree, today?

-- Dave

