Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUEWPx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUEWPx5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUEWPx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:53:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:47081 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263107AbUEWPxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:53:54 -0400
Date: Sun, 23 May 2004 08:53:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <1085299337.2781.5.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0405230840520.25502@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
 <1085299337.2781.5.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 May 2004, Arjan van de Ven wrote:
> 
> Can we make this somewhat less cumbersome even by say, allowing
> developers to file a gpg key and sign a certificate saying "all patches
> that I sign with that key are hereby under this regime". I know you hate
> it but the FSF copyright assignment stuff at least has such "do it once
> for forever" mechanism making the pain optionally only once.

One reason that I'd prefer not to is simply the question of "who maintains 
the certificates?"

I certainly don't want to maintain any stateful paperwork with lots of
people. This is why I personally would prefer it all to be totally
state-less.

Also, there is a _fundamental_ problem with signing a patch in a global 
setting: the patches _do_ get modified as they move through the system 
(maybe just bug-fixes, maybe addign a missing piece, maybe removing a 
controversial part). So the signature ends up being valid only on your 
part of the communication, and then after that it needs something else. 

And what I do _not_ want to see is a system where if somebody makes a 
trivial change, it then has to go back to you to be re-signed. That just 
would be horrible.

With those (pretty basic) caveats in mind, I don't see any fundamental
problem in a PGP key approach, if it's a "local" thing between developers.  
In fact, I think PGP-signed patches are something we may want to look at
from a "trust the email" standpoint, but I think it should be a _local_
trust. And part of that "local" trust might be a private agreement between
ddevelopers that "it's ok to add the sign-off line for Arjan when the
patch has come with that PGP signature" when the patch is passed on.

So to me, the sign-off procedure is really about documenting the path, and 
if a PGP key is there in certain parts of the path, then that would be a 
good thing, but I think it's a separate thing from what I'm looking for.

		Linus
