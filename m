Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275882AbSIUEfi>; Sat, 21 Sep 2002 00:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275883AbSIUEfi>; Sat, 21 Sep 2002 00:35:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60893 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S275882AbSIUEfh>;
	Sat, 21 Sep 2002 00:35:37 -0400
Date: Sat, 21 Sep 2002 06:48:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020920215029.GB1527@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44.0209210643210.2441-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Sep 2002, Bill Huey wrote:

> The JVM with incremental GC is being targetted for media oriented tasks
> using the new NIO, 3d library, etc... slowness in safepoints would
> cripple it for these tasks. It's a critical item and not easily address
> by the current 1:1 model.

actually, in the previous mail i've outlined a sensible way to help
safepoints in the kernel, for the case of the 1:1 model. I'd not call that
'not easily addressed' :-)

there's an even more advanced way to expose preempted user contexts in the
1:1 model: by putting most of the the register info (which is now dumped
into the kernel stack) into a page that is also mapped into user-space.
This too introduces (constant) syscall entry/exit overhead, but can be
done if justified.

	Ingo


