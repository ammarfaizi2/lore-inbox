Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269080AbUINAc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269080AbUINAc0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 20:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269075AbUINAc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 20:32:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:9164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269080AbUINA2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 20:28:39 -0400
Date: Mon, 13 Sep 2004 17:26:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: fix posix-timers leak and pending signal loss
Message-Id: <20040913172630.249a7aac.akpm@osdl.org>
In-Reply-To: <200409140021.i8E0LKcB030581@magilla.sf.frob.com>
References: <20040913162645.448e6131.akpm@osdl.org>
	<200409140021.i8E0LKcB030581@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
>  Frankly, I think the old code is much more prone to unforeseen problems
>  than the new.  

It's a question of testing coverage, and historical fragility of that part
of the code.  I'm uncomfortable making changes in there unless we're early
in the release cycle.

>  > Had you not rolled three distinct patches into one (hint) I'd have
>  > forwarded along the leak fix and sat on the rest for post-2.6.9.
> 
>  I don't like being an enabler of bad code.  So I didn't do a separate fix
>  inside something that I already knew needed to be ripped out.  If you want
>  an untested minimal fix for just the leak potential, leaving the semantics
>  frotzed in multiple ways

As long as "frotzed" != "goes oops mysteriously two days after we release
2.6.9" I'm happy.

> you can try the following.

I shall, thanks.
