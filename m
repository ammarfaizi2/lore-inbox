Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUA3GTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 01:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266552AbUA3GTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 01:19:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:5348 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266555AbUA3GSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 01:18:51 -0500
Date: Thu, 29 Jan 2004 22:18:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rui Saraiva <rmps@joel.ist.utl.pt>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where is sparse?
In-Reply-To: <Pine.LNX.4.58.0401300531490.32759@joel.ist.utl.pt>
Message-ID: <Pine.LNX.4.58.0401292216110.689@home.osdl.org>
References: <Pine.LNX.4.58.0401300531490.32759@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Jan 2004, Rui Saraiva wrote:
> 
> Where is the sparse source? (AKA TSCT - The Silly C Tokenizer) There was
> the BK repository at bk://kernel.bkbits.net/torvalds/sparse, now
> unavailable and the ml owner-linux-sparse@vger.kernel.org seems dead.

The old repostitory got killed when bkbits.net went away. There's a new
repo at

	http://sparse.bkbits.net/sparse

but I don't know why the mailing list would have gone.

> There is other BK rep at bk://linux-dj.bkbits.net/sparse but it is an old
> version.

It may well be up-to-date: without anybody interested enough to do a 
back-end, I had very little incentive to improve the front-end further. 
Right now all the warning messages for the kernel should be largely valid, 
but the networking code re-uses some structures for both user pointers and 
kernel pointers (which Davem agreed was bad and fixable, but wasn't done 
in time for 2.6.x), so we can't get rid of the user pointer accesses 
there..

		Linus
