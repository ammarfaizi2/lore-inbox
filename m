Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264593AbSIVWtm>; Sun, 22 Sep 2002 18:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264594AbSIVWtm>; Sun, 22 Sep 2002 18:49:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36049 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264593AbSIVWtk>;
	Sun, 22 Sep 2002 18:49:40 -0400
Date: Mon, 23 Sep 2002 01:02:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: bob <bob@watson.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, <okrieg@us.ibm.com>, <trz@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <15758.18582.488305.152950@k42.watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0209230101250.31981-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Sep 2002, bob wrote:

> [...] On a technical note: a cache-line ping-ponging is bad - a global
> spinlock is horrendous. They're different - the lock-less MP scheme gets
> rid of them both.

(on the contrary - a global spinlock is bad for exactly that reason,
because it causes a cacheline ping-pong. So if two CPUs are trying to
write trace events at once, you'll get the same effect as if they were
using a global spinlock.)

	Ingo

