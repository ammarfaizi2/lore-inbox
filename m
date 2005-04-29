Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbVD2SIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbVD2SIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 14:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbVD2SIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 14:08:45 -0400
Received: from emf.emf.net ([205.149.0.19]:34057 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S262866AbVD2SIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 14:08:32 -0400
Date: Fri, 29 Apr 2005 11:08:28 -0700 (PDT)
From: Tom Lord <lord@emf.net>
Message-Id: <200504291808.LAA25870@emf.net>
To: torvalds@osdl.org
CC: mpm@selenic.com, seanlkml@sympatico.ca, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
In-reply-to: <Pine.LNX.4.58.0504291051460.18901@ppc970.osdl.org> (message from Linus Torvalds on Fri, 29 Apr 2005 10:56:30 -0700 (PDT))
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   From: Linus Torvalds <torvalds@osdl.org>

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

The confusion here is that you are talking about computational complexity
while I am talking about complexity measured in hours of labor.

You are assuming that the programmer generating the signature blindly 
trusts the tool to generate the signed document accurately.   I am 
saying that it should be tractable for human beings to read the documents
they are going to sign.


   More importantly, signing 3 is meaningless. 3 only makes sense with a 
   known starting point. You should never sign a patch without also saying 
   what you're patching. 

I advocated signing a {(1),(3)} pair, not simply (3).

   And once you do that, 1+2 and 1+3 are _exactly_ the same thing.

I already spoke to that.

   And since git always works on the 1+2 level, it would be inexcusably
   stupid to sign anything but that. 3 doesn't even exist per se, although 
   it's obviously fully defined by 1+2.

   So I don't see your point. You complain about git signing, but you 
   complain on grounds that do not _exist_ in git, and then your alternative 
   (1+3) which is senseless in a git world doesn't actually end up being 
   anything really different - just more expensive.

I'm not sure what to suggest other than go back and read more carefully.

-t

