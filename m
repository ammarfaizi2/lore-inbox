Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbTDXUR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbTDXUR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:17:59 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36871 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264344AbTDXUR5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:17:57 -0400
Date: Thu, 24 Apr 2003 16:24:56 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
In-Reply-To: <20030423233652.C9036@redhat.com>
Message-ID: <Pine.LNX.3.96.1030424162101.11351C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Benjamin LaHaise wrote:

> Actually, Ingo's rmap style sounds very similar to what I first implemented 
> in one of my stabs at rmap.  It has a nasty side effect of being worst case 
> for cache organisation -- the sister page tends to map to the exact same 
> cache line in some processors.  Whoops.  That said, I think that the rmap 
> pte-chains can really stand a bit of optimization by means of discarding a 
> couple of bits, as well as merging for adjacent pages, so I don't think 
> the overhead is a lost cause yet.  And nobody has written the clone() patch 
> for bash yet...

I'm not sure the best solution is to try to hack applications doing things
in the way they find best. I suspect that we have to change the kernel so
it handles the requests in a reasonable way.

Of course reasonable way may mean that bash does some things a bit slower,
but given that the whole thing works well in most cases anyway, I think
the kernel handling the situation is preferable.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

