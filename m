Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVHKICf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVHKICf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 04:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVHKICf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 04:02:35 -0400
Received: from Volter-FW.ser.netvision.net.il ([212.143.107.30]:58569 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1030197AbVHKICe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 04:02:34 -0400
Date: Thu, 11 Aug 2005 11:02:05 +0300
To: Hugh Dickins <hugh@veritas.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
Message-ID: <20050811080205.GR16361@minantech.com>
References: <20050719165542.GB16028@mellanox.co.il> <20050725171928.GC12206@mellanox.co.il> <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com> <20050726133553.GA22276@mellanox.co.il> <Pine.LNX.4.61.0508091759050.14886@goblin.wat.veritas.com> <20050810083943.GM16361@minantech.com> <Pine.LNX.4.61.0508101412530.3153@goblin.wat.veritas.com> <20050810132611.GP16361@minantech.com> <Pine.LNX.4.61.0508101623480.4525@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508101623480.4525@goblin.wat.veritas.com>
From: glebn@voltaire.com (Gleb Natapov)
X-OriginalArrivalTime: 11 Aug 2005 08:02:30.0075 (UTC) FILETIME=[056DE0B0:01C59E4B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 04:27:31PM +0100, Hugh Dickins wrote:
> On Wed, 10 Aug 2005, Gleb Natapov wrote:
> > On Wed, Aug 10, 2005 at 02:22:40PM +0100, Hugh Dickins wrote:
> > > 
> > > Your stack example is a good one: if we end up setting VM_DONTCOPY on
> > > the user stack, then I don't think fork's child will get very far without
> > > hitting a SIGSEGV.
> > 
> > I know, but I prefer child SIGSEGV than silent data corruption.
> 
> Most people will share your preference, but neither is satisfactory.
> 
What about the idea that was floating around about new VM flag that will
instruct kernel to copy pages belonging to the vma on fork instead of mark
them as cow?

> > In most cases child will exec immediately after fork so no problem
> > in this case.
> 
> In most(?) cases it won't even be able to exec before the SIGSEGV.
> 
If the top of the stack belongs to not copied page then yes.

--
			Gleb.
