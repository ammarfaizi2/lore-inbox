Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVD2P53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVD2P53 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVD2P5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:57:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:23720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262254AbVD2P4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:56:46 -0400
Date: Fri, 29 Apr 2005 08:58:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tom Lord <lord@emf.net>
cc: mpm@selenic.com, seanlkml@sympatico.ca, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
In-Reply-To: <200504291544.IAA23584@emf.net>
Message-ID: <Pine.LNX.4.58.0504290854270.18901@ppc970.osdl.org>
References: <200504291544.IAA23584@emf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Apr 2005, Tom Lord wrote:
> 
> On the other hand, you're asking people to sign whole trees and not just at
> first-import time but also for every change.

I don't agree.

Sure, the commit determins the whole tree end result, but if you want to 
sign the _tree_, you can do so: just tag the actual _tree_ object as "this 
tree has been verified to be bug-free and non-baby-seal-clubbing".

But that's not what people do with tags. They sign a _commit_ object. And
yes, the commit object points to the tree, but it also points to the whole
history of other commit objects (and thus all historical trees etc), and 
together with just common sense it is very obvious that what you're really 
signing is that "point in time".

If you want to clarify it, you can always just say so in the tag. Instead 
of saying "I tag this as something I have verified every byte of", you can 
say "this was what I released as xxx", or "this commit contains my change" 
or something.

> If I've changed five files, I should be signing a statement of:
> 
> 	1) my belief about the identity of the immediate ancestor tree
> 	2) a robust summary of my changes, sufficient to recreate my
> 	   new tree given a faithful copy of the ancestor

So _do_ exactly that. You can say that in the tag you're signing.

			Linus
