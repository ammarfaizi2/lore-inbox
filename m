Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318560AbSHPRmY>; Fri, 16 Aug 2002 13:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318652AbSHPRmY>; Fri, 16 Aug 2002 13:42:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18847 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318560AbSHPRmX>;
	Fri, 16 Aug 2002 13:42:23 -0400
Date: Fri, 16 Aug 2002 19:47:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: CLONE_DETACHED and exit notification (was user-vm-unlock-2.5.31-A2)
In-Reply-To: <Pine.LNX.4.44.0208161033090.3193-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208161944520.23414-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the only (small) overhead is associated to truly detached
(PTHREAD_CREATE_DETACHED) threads, but the more important usage is when a
thread is created and joined, with some status code passed along. And even
in the PTHREAD_CREATE_DETACHED case, most usages just never terminate the
thread. So the high-frequency thread creation/destruction always happens
via some sort of joining method.

	Ingo

