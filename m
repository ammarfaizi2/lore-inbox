Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262999AbVCQE6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbVCQE6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 23:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVCQE6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 23:58:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53397 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262999AbVCQE6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 23:58:30 -0500
Date: Wed, 16 Mar 2005 23:58:10 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christoph Hellwig <hch@infradead.org>
cc: Jesse Barnes <jbarnes@engr.sgi.com>, Paul Mackerras <paulus@samba.org>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
In-Reply-To: <20050317044234.GA4415@infradead.org>
Message-ID: <Pine.LNX.4.61.0503162357410.23084@chimarrao.boston.redhat.com>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <16952.41973.751326.592933@cargo.ozlabs.ibm.com>
 <200503161406.01788.jbarnes@engr.sgi.com> <Pine.LNX.4.61.0503161853380.23084@chimarrao.boston.redhat.com>
 <20050317044234.GA4415@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005, Christoph Hellwig wrote:
> On Wed, Mar 16, 2005 at 06:55:13PM -0500, Rik van Riel wrote:
> > Thing is, the rest of the kernel uses virt_to_phys for
> > two different things.  Only one of them has to do with
> > the real physical address, the other is about getting
> > the page frame number.
> 
> The latter usage has been converted to page_to_pfn(virt_to_page(v))
> in the places I checked.

Nice.  Maybe then virt_to_phys can do the right thing (for AGP)
in Xen without other stuff breaking ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
