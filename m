Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbTETP3p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 11:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTETP3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 11:29:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23047 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263818AbTETP3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 11:29:44 -0400
Date: Tue, 20 May 2003 08:41:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
In-Reply-To: <20030520075627.A28002@infradead.org>
Message-ID: <Pine.LNX.4.44.0305200836400.3164-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 May 2003, Christoph Hellwig wrote:
> 
> Actually it should go away before 2.6.0.  sys_futex never was part of a
> released stable kernel so having the old_ version around is silly.

That's not a valid argument. That's an _excuse_.

Guys, binary compatibility is important. It's important enough that if 
something got extensively used on development kernels, it's _still_ a hell 
of a lot more important than most other things around. The _only_ things 
that trump binary compatibility are

 - developer sanity (ie it has to be truly mindbogglingly hard to support 
   the old interface)
 - stability (ie if the old interface was so badly designed that it can't 
   be done right - mmap on /proc/<pid>/mem was one of these).
 - it's been deprecated over at least one full stable release.

Something like "it's only been in the development kernels" is simply not
an issue. The only thing that matters is whether it is used by various
binaries or not. And I think futexes are used a lot by glibc..

		Linus

