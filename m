Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWIXAGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWIXAGe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 20:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbWIXAGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 20:06:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751703AbWIXAGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 20:06:32 -0400
Date: Sat, 23 Sep 2006 17:06:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT] Linux client patches against Linux 2.6.18
In-Reply-To: <1158982165.5493.12.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0609231700210.4388@g5.osdl.org>
References: <1158982165.5493.12.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Sep 2006, Trond Myklebust wrote:
> 
>    git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git

I'm not entirely happy with this.

Why were the generic VFS layer patches wrapped up in this big thing, 
instead of being sent separately with the proper people looking at them?

I'm not seeing a sign-off or ack for the dentry stuff from Al, for 
example. Was it passed by him? You moved the dentry rehash function inside 
the dcache_lock, and if that was a bug-fix, it should have been marked as 
so and done separately etc.

In other words, this was _not_ the right way to merge these things. I'm a 
bit grumpy.

		Linus
