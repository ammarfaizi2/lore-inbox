Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270640AbRHOFdW>; Wed, 15 Aug 2001 01:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271027AbRHOFdM>; Wed, 15 Aug 2001 01:33:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52489 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270640AbRHOFdB>; Wed, 15 Aug 2001 01:33:01 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 14 Aug 2001 22:32:16 -0700
Message-Id: <200108150532.f7F5WGq01653@penguin.transmeta.com>
To: mag@fbab.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8 Resource leaks + limits
Newsgroups: linux.dev.kernel
In-Reply-To: <3ce801c12548$b7971750$020a0a0a@totalmef>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3ce801c12548$b7971750$020a0a0a@totalmef> you write:
>
>Question: why isn't there a limit for global memory usage per user?

Answer: because traditionally Linux (or UNIX) hasn't had a good and
efficient way to have per-user statistics. 

This is why you mainly find per-process stuff in all the limits. 

Linux has had (for a while now) a "struct user" that is actually quickly
accessible through a direct pointer off every process that is associated
with that user, and we could (and _will_) start adding these kinds of
limits. However, part of the problem is that because the limits haven't
historically existed, there is also no accepted and nice way of setting
the limits.

Oh, well.

		Linus
