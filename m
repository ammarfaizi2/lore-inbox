Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbTFWH4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTFWH41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:56:27 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4507
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264759AbTFWH4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:56:22 -0400
Date: Mon, 23 Jun 2003 10:10:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: paulmck@us.ibm.com, dmccr@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-ID: <20030623081016.GI19940@dualathlon.random>
References: <20030612134946.450e0f77.akpm@digeo.com> <20030612140014.32b7244d.akpm@digeo.com> <150040000.1055452098@baldur.austin.ibm.com> <20030612144418.49f75066.akpm@digeo.com> <184910000.1055458610@baldur.austin.ibm.com> <20030620001743.GI18317@dualathlon.random> <20030623032842.GA1167@us.ibm.com> <20030622233235.0924364d.akpm@digeo.com> <20030623074353.GE19940@dualathlon.random> <20030623005623.5fe1ab30.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623005623.5fe1ab30.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 12:56:23AM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > that will finally close the race
> 
> Could someone please convince me that we really _need_ to close it?
> 
> The VM handles the whacky pages OK (on slowpaths), and when this first came
> up two years ago it was argued that the application was racy/buggy
> anyway.  So as long as we're secure and stable, we don't care.  Certainly
> not to the point of adding more atomic ops on the fastpath.
> 
> So...   what bug are we actually fixing here?

we're fixing userspace data corruption with an app trapping SIGBUS.

> 
> 
> (I'd also like to see a clearer description of the distributed fs problem,
> and how this fixes it).

I certainly would like discussions about it too.

Andrea
