Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQKJNpc>; Fri, 10 Nov 2000 08:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130295AbQKJNpW>; Fri, 10 Nov 2000 08:45:22 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:8668 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129464AbQKJNpS>;
	Fri, 10 Nov 2000 08:45:18 -0500
Date: Fri, 10 Nov 2000 08:45:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: richardj_moore@uk.ibm.com
cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <80256993.00470452.00@d06mta06.portsmouth.uk.ibm.com>
Message-ID: <Pine.GSO.4.21.0011100831210.12920-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Nov 2000 richardj_moore@uk.ibm.com wrote:

> 
> 
> 
> > The problem with the hooks et.al. is very simple - they promote every
> > bloody implementation detail to exposed API. ....
> 
> Surely not, having the kernel source does that. The alternative to the hook
> is embed a patch in the kernel source.  What proveds greater exposure to
> internals: hooks of source?

Sorry. You don't "embed" the patch. You either get it accepted or not.
Or you fork the tree and then it's officially None Of My Problems(tm).
If your private patch breaks because of the kernel changes - too fscking
bad, it's still None Of My Problems(tm). With hooks you have a published
API.

Alternative to hook is not a random patch. It's finding a way to use public
APIs (possibly at the cost of redesigning your code) or finding good arguments
for changing said APIs (ditto). And they'ld better be really good. "I don't
know how to do that without rethinking my code" doesn't cut it. Deal. There
is _no_ warranty that anything other than public APIs will not change at any
random moment. Period. You play with layering violations - you _will_ shoot
yourself in foot. It's not "if", it's "when".

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
