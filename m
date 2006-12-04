Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937108AbWLDQgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937108AbWLDQgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937096AbWLDQgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:36:23 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36740 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937108AbWLDQgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:36:22 -0500
Date: Mon, 4 Dec 2006 08:36:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow 32-bit and 64-bit hashes
In-Reply-To: <20061204161435.GG3013@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0612040832580.3476@woody.osdl.org>
References: <20061204104749.GC3013@parisc-linux.org>
 <Pine.LNX.4.64.0612040746170.3476@woody.osdl.org> <20061204161435.GG3013@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2006, Matthew Wilcox wrote:
> 
> You're right.  It hasn't actually caused any problems, presumably due to
> linux/types.h being included absolutely everywhere already, but it's
> clearly the Right Thing To Do.  Updated patch:

I'm still not happy.

The return value of "hash_u64()" had better be  u64, not "unsigned long".

Same goes (to a smaller degree) for hash_u32().

I can trivially just edit the patch and fix these things, but with two 
bugs found by just inspection of the patch, I'm going to ask you to look 
it over one more time and re-send me a "guaranteed correct" version, ok? 

Because I'm a very religious man, and my religion basically boils down to 

  "If somebody else can do it for me, they should. I'm lazy, and I like it 
   that way. Besides, next time maybe they'll double-check on their own".

Thanks. And please spread the Good Word.

		Linus
