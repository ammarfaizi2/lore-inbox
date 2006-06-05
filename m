Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751412AbWFEURn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWFEURn (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWFEURn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:17:43 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27797 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751412AbWFEURl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:17:41 -0400
Date: Mon, 5 Jun 2006 13:16:10 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Bligh <mbligh@google.com>
cc: Andy Whitcroft <apw@shadowen.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
        Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        ak@suse.de, Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <44849075.5070802@google.com>
Message-ID: <Pine.LNX.4.64.0606051315350.18717@schroedinger.engr.sgi.com>
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org> <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
 <44848DD2.7010506@shadowen.org> <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
 <44848F45.1070205@shadowen.org> <44849075.5070802@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006, Martin Bligh wrote:

> > > > Adding 32k swap on swapfile31.  Priority:-34 extents:1 across:32k
> > > > Adding 32k swap on swapfile32.  Priority:-35 extents:1 across:32k
> > > 
> > > That should not work at all. It should bomb out at 30 swap files with page
> > > migration on.
> > 
> > The implication here is that there can only be 32 entries in-toto ... it
> > feels like we have at least 33/34 as the machine has swap by default ...
> > more to look at!
> 
> Either way, random panics are not the appropriate response ;-)

Seems that the check for too many swapfiles is busted somehow. It should 
never go beyond 32 without page migration. Looking into it.

