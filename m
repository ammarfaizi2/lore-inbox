Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265781AbUGDVgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265781AbUGDVgo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 17:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265787AbUGDVgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 17:36:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:31900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265781AbUGDVgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 17:36:32 -0400
Date: Sun, 4 Jul 2004 14:35:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: andrea@cpushare.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Message-Id: <20040704143526.62d00790.akpm@osdl.org>
In-Reply-To: <20040704173903.GE7281@dualathlon.random>
References: <20040704173903.GE7281@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrea@cpushare.com wrote:
>
> I need this new kernel feature for a reseach spare time project I'm
>  developing in the weekends.  The fast path cost is basically only the
>  s/testb/testw/ change in entry.S. (and even that might be removed with a
>  more signficant effort but I don't think anybody could worry about that
>  change).
> 
>  This might be better off for 2.7 but I would like if people could have a
>  look, and it's simple enough that it might be included in 2.6 too later
>  on. (it just need to be ported to the other archs, only x86 is
>  implemented here, but that's easy)
> 
>  Especially I would like to know if anybody can see an hole in this. This
>  is an order of magnitude more secure of chroot and of capabilities and
>  much simpler and it doesn't require root privilegies to activate. I
>  wasn't forced to take secure computing down into kernel space but I
>  believe it's the simplest and most secure and most efficient approch. An
>  userspace alternative would been to elaborate this below bytecode
>  userspace approch but besides being an order of magnitude slower it also
>  is a lot more complicated and less secure, and it keeps into the
>  equation the virtual machine that executes the code later on:
> 
>  	http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/286134

I'm not sure what to say about this, really.

Of course, yes, the patch is sufficiently safe and simple for it to be
mergeable in 2.6, if this is the way we want to do secure computing.  I'd
wonder whether the API should be syscall-based rather than /proc-based, and
whether there should be a config option for it.

But the wider questions are stuff like "where is all this coming from",
"where will it all end up" and "what are the alternatives".

