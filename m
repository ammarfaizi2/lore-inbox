Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVKCIM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVKCIM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 03:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVKCIM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 03:12:56 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:56353 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S932113AbVKCIMz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 03:12:55 -0500
Date: Thu, 3 Nov 2005 10:12:14 +0200
From: Gleb Natapov <gleb@minantech.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051103081213.GC22185@minantech.com>
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au> <4368139A.30701@vc.cvut.cz> <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com> <1130965454.20136.50.camel@gaston> <Pine.LNX.4.61.0511022112530.18174@goblin.wat.veritas.com> <1130967936.20136.65.camel@gaston> <Pine.LNX.4.61.0511022157130.18559@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511022157130.18559@goblin.wat.veritas.com>
X-OriginalArrivalTime: 03 Nov 2005 08:12:54.0373 (UTC) FILETIME=[643D3150:01C5E04E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 10:02:49PM +0000, Hugh Dickins wrote:
> On Thu, 3 Nov 2005, Benjamin Herrenschmidt wrote:
> > On Wed, 2005-11-02 at 21:41 +0000, Hugh Dickins wrote:
> > 
> > > The only extant problem here is if the pages are private, and you
> > > fork while this is going on, and the parent user process writes to the
> > > area before completion: then COW leaves the child with the page being
> > > DMAed into, giving the parent a copied page which may be incomplete.
> > 
> > Won't happen, and if it does, it's a user error to rely on that working,
> > so it doesn't matter.
> 
> I wish everyone else would see it that way!  (But some people do
> have valid scenarios where it can't just be ruled out completely.)
> 
I am one of those people :)

Last discussion about this issue ended without resolution, but I remember
you mentioned the possibility to leave ptes writable in parent during fork 
for private pages mapped for DMA. Is this approach acceptable?

--
			Gleb.
