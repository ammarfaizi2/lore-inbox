Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVAMAnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVAMAnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVAMAeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 19:34:46 -0500
Received: from ozlabs.org ([203.10.76.45]:59092 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261401AbVAMAcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 19:32:17 -0500
Subject: Re: [PATCH] kill symbol_get & friends
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       adaplas@pol.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dwmw2@redhat.com
In-Reply-To: <20050112203136.GA3150@lst.de>
References: <20050112203136.GA3150@lst.de>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 11:19:33 +1100
Message-Id: <1105575573.12794.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-12 at 21:31 +0100, Christoph Hellwig wrote:
> Rusty introduced symbol_get as a replacement for inter_module_get, but
> it doesn't really solved the underlying problem.

Sorry, Christoph, I must be particularly obtuse today.

If you don't hold a reference, then yes, the module can go away.  This
hasn't been a huge problem for users in the past.

The lack of users is because, firstly, dynamic dependencies are less
common than static ones, and secondly because the remaining inter-module
users (AGP and mtd) have not been converted.  Patches have been sent
several times, but maintainers are distracted, it seems.  I *will* run
out of patience and push those patches which take away intermodule.c one
day (hint, hint!).

For optional module dependencies, weak symbols can be used, but there
seems to be a desire for genuine dynamic dependencies.  If you can get
rid of those, I'll apply your patch in a second!

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

