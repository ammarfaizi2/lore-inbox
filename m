Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVD2Ryu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVD2Ryu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 13:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVD2Ryu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 13:54:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:52179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262859AbVD2Ryj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 13:54:39 -0400
Date: Fri, 29 Apr 2005 10:56:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tom Lord <lord@emf.net>
cc: mpm@selenic.com, seanlkml@sympatico.ca, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
In-Reply-To: <200504291734.KAA25263@emf.net>
Message-ID: <Pine.LNX.4.58.0504291051460.18901@ppc970.osdl.org>
References: <200504291734.KAA25263@emf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Apr 2005, Tom Lord wrote:
>
> 	1) the ancestry of their modified tree
> 
> 	2) the complete contents of their modified tree
> 
> 	3) input data for a patching program (let's call it "PATCH")
> 	   which, at the very least, satisfies the equation:
> 
> 		MOD_TREE = PATCH (this_diff, ORIG_TREE)
> 
> On the other hand, signing documents which represent a {(1),(3)} pair
> with robust accuracy is, in most cases, much much less expensive than
> signing {(1),(2)} pairs with robust accuracy. 

Not so.

It may be less expensive in your world, but that's the whole point of git: 
it's _not_ less expensive in the git world. 

In the git world, 1 and 2 aren't even separate things. They go together. 
And you just sign it. End of story. It's so cheap to sign that it's not 
even funny.

More importantly, signing 3 is meaningless. 3 only makes sense with a 
known starting point. You should never sign a patch without also saying 
what you're patching. 

And once you do that, 1+2 and 1+3 are _exactly_ the same thing.

And since git always works on the 1+2 level, it would be inexcusably
stupid to sign anything but that. 3 doesn't even exist per se, although 
it's obviously fully defined by 1+2.

So I don't see your point. You complain about git signing, but you 
complain on grounds that do not _exist_ in git, and then your alternative 
(1+3) which is senseless in a git world doesn't actually end up being 
anything really different - just more expensive.

		Linus
