Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbTDVPEd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTDVPEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:04:33 -0400
Received: from mail-5.tiscali.it ([195.130.225.151]:36304 "EHLO
	mail-5.tiscali.it") by vger.kernel.org with ESMTP id S263200AbTDVPEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:04:32 -0400
Date: Tue, 22 Apr 2003 17:16:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@digeo.com>,
       mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030422151621.GJ23320@dualathlon.random>
References: <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com> <170570000.1051021741@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170570000.1051021741@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 07:29:02AM -0700, Martin J. Bligh wrote:
> overhead itself. I think we're optimising for the wrong case here - isn't
> the 100x100 mappings case exactly what we have sys_remap_file_pages for?

yes IMHO.

> We can make the O(?) stuff look as fancy as we like. However, in reality,
> that makes the constants suck, and I'm not at all sure it's a good plan.

correct, it depends on what we care to run fast.

> It seems ironic that the solution to space consumption is do double the
> amount of space taken ;-) I see what you're trying to do (shove things up

Agreed.

> I think the holes in objrmap are quite small - and are already addressed by
> your sys_remap_file_pages mechanism.

Yep.

Andrea
