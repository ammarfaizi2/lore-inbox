Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265130AbUFASxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUFASxN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 14:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUFASxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 14:53:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:1474 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265130AbUFASxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 14:53:07 -0400
Subject: Re: I would like to see ReiserFS V3 enter a feature freeze
	real	soon.
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Vladimir Saveliev <vs@namesys.com>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Andrew Morton <akpm@osdl.org>, Alexander Zarochentcev <zam@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>
In-Reply-To: <40BCB6BC.8020901@namesys.com>
References: <20040528122854.GA23491@clipper.ens.fr>
	 <1085748363.22636.3102.camel@watt.suse.com>
	 <1085750828.1914.385.camel@tribesman.namesys.com>
	 <1085751695.22636.3163.camel@watt.suse.com> <40BB61C0.5020902@namesys.com>
	 <1086089827.22636.3391.camel@watt.suse.com> <40BCB6BC.8020901@namesys.com>
Content-Type: text/plain
Message-Id: <1086116003.22636.3445.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 01 Jun 2004 14:53:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-01 at 13:02, Hans Reiser wrote:

> > I can't promise that I'll never making another
> >change in there, but my goal is to keep them to a minimum.
> >
> >  
> >
> >>Also, I would like to see some serious benchmarks of the bitmap 
> >>algorithm changes before they go in.  They seem nice in theory, and some 
> >>users liked them for their uses, but that does not make a serious 
> >>scientific study.  Such a study has a high chance of making them even 
> >>better.;-)
> >>
> >>    
> >>
> >
> >Some benchmarks have been posted on reiserfs-list, but I'd love to
> >coordinate with you on getting some mongo numbers. 
> >
> Ok.

> >A good start would be to just rebenchmark against v4.
> >  
> >
> V4 performance is not at a stable point at the moment I think, I have 
> not been monitoring things closely due to trying to earn bucks 
> consulting, and performance did not get tested every week, but there 
> have been reports of performance decreasing and no reports of anyone 
> investigating it, so I need to....
> 

Sure, since v4 is being done again -mm right now (right?) you can just
benchmark against a few of the new options.  mount -o alloc=skip_busy
will give you the old allocator.

> Elena, please compose a URL consisting of past benchmarks of various V4 
> snapshots and send it to me.  (I did not read the last one you sent, 
> sorry about that, so include the contents of that one also).
> 
> If the objective is to determine if the algorithm is good, then we 
> should test it with only the algorithm in question changed.
> 
> I would be quite happy to add the algorithm to V4 (or Chris and Jeff can 
> do that) and test it on vs. off.

The algorithm has a few key components, but v4 doesn't need most of it. 
The part to inherit packing localities down the chain would be most
interesting in v4.

The rest approximates things v4 should already be good at, like grouping
some of the metadata near the data blocks.

-chris


