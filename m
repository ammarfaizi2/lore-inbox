Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbVJaFGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVJaFGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 00:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbVJaFGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 00:06:24 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:65415
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751366AbVJaFGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 00:06:24 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Andi Kleen <ak@suse.de>
Subject: Re: New (now current development process)
Date: Sun, 30 Oct 2005 23:05:43 -0600
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       torvalds@osdl.org, tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <20051030111241.74c5b1a6.akpm@osdl.org> <200510310148.57021.ak@suse.de>
In-Reply-To: <200510310148.57021.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510302305.46532.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 18:48, Andi Kleen wrote:
> The problem is that you usually cannot do proper bug fixing because
> the release might be just around the corner, so you typically
> chose the ugly workaround or revert, or just reject changes for bugs that a
> are too risky or the impact too low because there is not enough time to
> properly test anymore.
>
> It might work better if we were told when the releases would actually
> happen and you don't need to fear that this not quite tested everywhere
> bugfix you're about to submit might make it into the gold kernel, breaking
> the world for some subset of users.

Hence the -mm tree, which takes stuff that may still need to be debugged.  
Except that it has this nasty habit of taking stuff which still needs to be 
debugged from people _other_than_you_, which screws you up.  You seem to want 
a tree where the only stuff likely to break is your stuff, which is another 
popular option: maintaining your own developer tree.  Getting people to _use_ 
such a tree takes a bit of work, but that's not news to anybody.

Think about what you're asking for here.  Imagine that other people _also_ get 
what you're asking for, at the same time.  Is it still what you want?

Right now patches go from developer tree, to -mm tree, to -linus tree, with a 
larger audience each time.  The _reason_ linus's tree has a larger audience 
is exactly _because_ the patches in it have had more testing so it's less 
likely to break.  And the releases have a way larger audience than Linus's 
-rc releases, and the distro kernels have a larger audience than that...

> -Andi

Rob
