Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbUCOWrZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbUCOWoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:44:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62983
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262839AbUCOWoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:44:09 -0500
Date: Mon, 15 Mar 2004 23:44:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
Message-ID: <20040315224450.GN30940@dualathlon.random>
References: <Pine.LNX.4.44.0403150822040.12895-100000@chimarrao.boston.redhat.com> <4055BF90.5030806@cyberone.com.au> <20040315145020.GC30940@dualathlon.random> <405628AC.4030609@cyberone.com.au> <20040315222419.GM30940@dualathlon.random> <40563114.5040204@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40563114.5040204@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 09:41:24AM +1100, Nick Piggin wrote:
> 
> 
> Andrea Arcangeli wrote:
> 
> >
> >Either that or you can choose to do some overwork and to shrink from all
> >the zones removing this break:
> >
> >		if (ret >= nr_pages)
> >			break;
> >
> >but as far as I can tell, the 50% waste of cache in a 2G box can happen
> >in 2.6.4 and it won't happen in 2.4.x.
> >
> >
> 
> Yeah you are right. Some patches have since gone into 2.6-bk and
> this is one of the things fixed up.

sounds great, thanks!
