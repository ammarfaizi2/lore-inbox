Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTJJPAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbTJJPAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:00:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:18137 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262865AbTJJPAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:00:01 -0400
Date: Fri, 10 Oct 2003 07:59:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <20031010122755.GC22908@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0310100756510.20420-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Oct 2003, Joel Becker wrote:
> 
> 	User space has to know about frsize for O_DIRECT alignment.

Have you ever noticed that O_DIRECT is a piece of crap?

The interface is fundamentally flawed, it has nasty security issues, it 
lacks any kind of sane synchronization, and it exposes stuff that 
shouldn't be exposed to user space.

I hope disk-based databases die off quickly. Yeah, I see where you are
working, but where I'm coming from, I see all the _crap_ that Oracle tries
to push down to the kernel, and most of the time I go "huh - that's a
f**king bad design".

		Linus

