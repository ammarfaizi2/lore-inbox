Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTIWKQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 06:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbTIWKQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 06:16:35 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:50437 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263339AbTIWKQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 06:16:34 -0400
Date: Tue, 23 Sep 2003 11:16:32 +0100
From: John Levon <levon@movementarian.org>
To: "Villacis, Juan" <juan.villacis@intel.com>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.x] additional kernel event notifications
Message-ID: <20030923101632.GA85283@compsoc.man.ac.uk>
References: <7F740D512C7C1046AB53446D372001732DEC9E@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D372001732DEC9E@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A1kDg-00059U-MV*5z/1gJPJUOg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 06:16:14PM -0700, Villacis, Juan wrote:

> There are several languages and tools besides Java which can jit code.
> Perl6 (using interpreters like Parrot) and Python (using interpreters
> like Psycho) are examples of this and it is not yet clear what
> interfaces they will provide to allow for JVMPI like functionality.  We

First, "we might need it" is not generally considered a good enough
rationale for extra code by the kernel  people.

Second, if there is no help from a runtime for tracking JITted code
memory -> source lines, I do not see how your hooks could possibly help.
Either way you need help from the VM of the target program (be it
Parrot, Python or whatever).

> would still like to be able to provide something useful to the users of

What would "something useful" be in particular ?

> From what we can see in the Oprofile driver code, if there is no dcookie
> for a corresponding EIP, the EIP information is discarded and the

Correct.

But we're talking about making oprofile useful for your purposes - that
can and will involve changes. In particular it's trivial to add an
option to oprofile to output the raw EIP is no dentry could be matched.

> As long as there exists a userspace API similar to the JVMPI for a
> particular DGC generator, and as long as the profiling tool is using
> that API, then yes, it seems like this method would work.  But this
> isn't the case we are worried about.

I hate to be a pain, but I'm still missing a concrete explanation of an
*actual* case you are worried about. It's rather difficult to discuss
this stuff in the abstract.

regards
john
-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
