Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVJ3Wgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVJ3Wgt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 17:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVJ3Wgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 17:36:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13764 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932374AbVJ3Wgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 17:36:48 -0500
Date: Sun, 30 Oct 2005 14:36:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rob Landley <rob@landley.net>
cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
In-Reply-To: <200510300644.20225.rob@landley.net>
Message-ID: <Pine.LNX.4.64.0510301435520.27915@g5.osdl.org>
References: <20051029182228.GA14495@havoc.gtf.org> <4363CB60.2000201@pobox.com>
 <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org> <200510300644.20225.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Oct 2005, Rob Landley wrote:
> 
> Rather than making the patch a simple diff of the trees, make the patch a cat 
> of the individual patches/commits (preferably with descriptions) that got 
> applied, in the order they got applied.
> 
> This makes the patch bigger, but it also means that bisect can be done with 
> vi, simply by truncating the file at the last interesting patch and applying 
> the truncated version to a clean tree.  Since patch applies hunks in order 
> and sifts out hunks from description already...
> 
> Is this a viable option?

No.

There is no "ordering" in a distributed environment. We have things 
happening in parallel, adn you can't really linearize the patches.

The closest you can get is "git bisect", which does the right thing.

		Linus
