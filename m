Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTFYDKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 23:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTFYDKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 23:10:41 -0400
Received: from dp.samba.org ([66.70.73.150]:16581 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263631AbTFYDKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 23:10:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: torvalds@transmeta.com, akpm@zip.com.au, davem@redhat.com,
       linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH 3/3] Allow arbitrary number of init funcs in modules 
In-reply-to: Your message of "Tue, 24 Jun 2003 19:01:25 +0200."
             <Pine.LNX.4.44.0306241851550.11817-100000@serv> 
Date: Wed, 25 Jun 2003 13:10:53 +1000
Message-Id: <20030625032450.406202C086@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0306241851550.11817-100000@serv> you write:
> Hi,
> 
> On Mon, 23 Jun 2003, Rusty Russell wrote:
> 
> > D: One longstanding complaint is that modules can only have one
> > D: module_init, and one module_exit (builtin code can have multiple
> > D: __initcall however).  This means, for example, that it is not
> > D: possible to write a "module_proc_entry(name, readfn)" function
> > D: which can be used like so:
> > D: 
> > D:   module_init(myinitfn);
> > D:   module_cleanup(myinitfn);
> > D:   module_proc_entry("some/path/foo", read_foo);
> 
> What happens if a module is compiled into the kernel and one of the init 
> functions fails?

We ignore the failure, as we do with initcalls at the moment.  I
wasn't really intending to deprecate the existing mechanisms: this is
simple at least 8)

Hmm, were you thinking of grouping by KBUILD_BASENAME?  Can you think
of a case where that would be nicer to use?

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
