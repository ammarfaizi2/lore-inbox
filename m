Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262799AbSJRCVJ>; Thu, 17 Oct 2002 22:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262788AbSJRCTm>; Thu, 17 Oct 2002 22:19:42 -0400
Received: from dp.samba.org ([66.70.73.150]:6891 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262793AbSJRCTG>;
	Thu, 17 Oct 2002 22:19:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module loader preparation 
In-reply-to: Your message of "Thu, 17 Oct 2002 14:33:08 +0100."
             <20021017143308.A24271@infradead.org> 
Date: Fri, 18 Oct 2002 11:39:04 +1000
Message-Id: <20021018022503.2B1A22C24E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021017143308.A24271@infradead.org> you write:
> I don't think requiring a init func is a good idea.  Please fix
> your module loader to generate a stub if no module_init() is
> present instead.

But where do you generate the module name (a module now knows its own
name, in the .modulename section)?  We could do an extra step in the
module build where we generate this and link it in, bit given that
we're talking about a handful of trivial modules, I don't think it's
worth it.

> init_module() sounds like a good idea to me, though.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
