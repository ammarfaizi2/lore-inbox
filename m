Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbUCVPUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUCVPUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:20:36 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38071
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262046AbUCVPUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:20:34 -0500
Date: Mon, 22 Mar 2004 16:21:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-aa1
Message-ID: <20040322152126.GB3649@dualathlon.random>
References: <20040322145019.GZ3649@dualathlon.random> <Pine.LNX.4.44.0403221007300.20045-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403221007300.20045-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 10:09:06AM -0500, Rik van Riel wrote:
> On Mon, 22 Mar 2004, Andrea Arcangeli wrote:
> 
> > >  * This is kept modular because we may want to experiment
> > >  * with object-based reverse mapping schemes.
> > 
> > obviously I read that comment, but I definitely hope he meant people
> > adding objrmap.c w/o necessairly deleting rmap.c too like me and you did
> 
> On the contrary.  I started out by looking at object based
> rmap, but Ben and Dave told me about the worst case scenarios.
> Only after that I started working on a pte based rmap scheme.
> 
> Now that the big problems with object based rmap are solved,
> I'd really like to see the pte chain code go away...

me too, that's why I deleted mm/rmap.c and I use objrmap.c instead. rmap
has always been used for years to mean your current implementation
of pte based reverse mappings in 2.6-mainline and 2.4-rmap, that's
blatantly too obvious to even make further jokes about that. If you now
me to believe that that is not true and that every single time you said
"rmap" it was a strict english abbreviation for the generic word
"reverse mappings" without any remote relation to the current
2.6-mainline and 2.4-rmap implementation of the reverse mapping methods,
then maybe you want to write some PR don't waste your time trying to
convince me. 
