Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267533AbSKQRzf>; Sun, 17 Nov 2002 12:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267535AbSKQRzf>; Sun, 17 Nov 2002 12:55:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63185 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267533AbSKQRze>;
	Sun, 17 Nov 2002 12:55:34 -0500
Date: Sun, 17 Nov 2002 20:19:03 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Luca Barbieri <ldb@ldb.ods.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <Pine.LNX.4.44.0211170922020.4425-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211172015070.11151-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Linus Torvalds wrote:

> Why not do it the _sane_ way, with a system call in crt0.S instead to
> set up the user_tid if you want it?

the patch adds a syscall, which will indeed be used in the exec() case.  
The patch does not add any magic execve() thing. Plus the patch changes
the TID interfaces of sys_clone() to work not only for pthread_create()
but also in the case of fork().

	Ingo


