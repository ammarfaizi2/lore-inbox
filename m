Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTFPGhM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 02:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTFPGhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 02:37:12 -0400
Received: from dp.samba.org ([66.70.73.150]:14272 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263459AbTFPGhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 02:37:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       ak@muc.de, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Fix undefined/miscompiled construct in kernel parameters 
In-reply-to: Your message of "Sun, 15 Jun 2003 17:49:57 MST."
             <20030616004957.GA15350@twiddle.net> 
Date: Mon, 16 Jun 2003 13:55:22 +1000
Message-Id: <20030616065058.EF7592C0D3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030616004957.GA15350@twiddle.net> you write:
> On Mon, Jun 16, 2003 at 10:23:41AM +1000, Rusty Russell wrote:
> > Since Andi reports that even that doesn't work for x86-64, I'd say
> > apply this patch based on his: it's an arbitrary change anyway.
> 
> No, Andi located the *real* problem.  The compiler was over-aligning
> these objects, which added padding, which broke the array semantics
> you were looking for.  The solution is to add an attribute aligned;
> he's sent a patch to Linus already.

Thanks for the explanation.  Sorry I missed it.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
