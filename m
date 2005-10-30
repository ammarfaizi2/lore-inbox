Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVJ3Moe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVJ3Moe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 07:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVJ3Moe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 07:44:34 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:65472
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932168AbVJ3Mod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 07:44:33 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git patches] 2.6.x libata updates
Date: Sun, 30 Oct 2005 06:44:19 -0600
User-Agent: KMail/1.8
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20051029182228.GA14495@havoc.gtf.org> <4363CB60.2000201@pobox.com> <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510300644.20225.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 October 2005 14:37, Linus Torvalds wrote:
> Now, I've gotten several positive comments on how easy "git bisect" is to
> use, and I've used it myself, but this is the first time that patch users
> _really_ become very much second-class citizens, and you can't necessarily
> always do useful things with just the tar-trees and patches. That's sad,
> and possibly a really big downside.
>
> Don't get me wrong - I personally think that the new merge policy is a
> clear improvement, but it does have this downside.

One possible solution:

Rather than making the patch a simple diff of the trees, make the patch a cat 
of the individual patches/commits (preferably with descriptions) that got 
applied, in the order they got applied.

This makes the patch bigger, but it also means that bisect can be done with 
vi, simply by truncating the file at the last interesting patch and applying 
the truncated version to a clean tree.  Since patch applies hunks in order 
and sifts out hunks from description already...

Is this a viable option?

Rob
