Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTKSBl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 20:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTKSBl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 20:41:58 -0500
Received: from dp.samba.org ([66.70.73.150]:52947 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263796AbTKSBl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 20:41:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: lib.a causing modules not to load 
In-reply-to: Your message of "18 Nov 2003 10:25:16 MDT."
             <1069172719.1835.30.camel@mulgrave> 
Date: Wed, 19 Nov 2003 11:06:09 +1100
Message-Id: <20031119014155.50D362C0C7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1069172719.1835.30.camel@mulgrave> you write:
> On Sun, 2003-11-16 at 20:47, Rusty Russell wrote:
> > I think lib.a should be linked as is if !CONFIG_MODULES, and done as a
> > ..o if CONFIG_MODULES.  Other alternatives are possible, but make it
> > tricky if someone adds a module later which wants something in lib.a.
> 
> I tried this and it is getting to be a whole nasty mess can of worms:
> 
> You can't link the lib objects all in, because they can be overridden by
> the arch dependent lib.a (we rely on link order to permit this).  For
> instance on x86, dump_stack and bust_spinlocks give duplicate symbols.

Ewww.... Weak symbols?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
