Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318161AbSIOSdl>; Sun, 15 Sep 2002 14:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSIOSdl>; Sun, 15 Sep 2002 14:33:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33799 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318161AbSIOSdk>; Sun, 15 Sep 2002 14:33:40 -0400
Date: Sun, 15 Sep 2002 11:38:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-exec-2.5.34-B1, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209152041310.9731-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209151137490.10830-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Sep 2002, Ingo Molnar wrote:
> 
> i dont like those semantics either - will verify whether thread-specific
> exec() works via a helper thread (or vfork) - it really should.

As long as it works with something sane (and vfork() is sane), I'm happy 
with the posix behaviour by default. After all, the execve() really _does_ 
need to "de-thread" anyway, and if we need to make that explicit (with the 
vfork()) then that's fine.

		Linus

