Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSIPGGj>; Mon, 16 Sep 2002 02:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSIPGGj>; Mon, 16 Sep 2002 02:06:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22484 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S293680AbSIPGGj>;
	Mon, 16 Sep 2002 02:06:39 -0400
Date: Mon, 16 Sep 2002 08:18:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] thread-exec-2.5.34-B1, BK-curr
In-Reply-To: <1032140276.27001.27.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209160813530.16470-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Sep 2002, Alan Cox wrote:

> There is code that depends on clone()/exec() not killing other threads
> in the group - some threaded web servers for example.

all the new 'thread group' semantics (group exit, group-broadcast and
group-balanced signals, group exec(), soon-to-come group coredump) are
connected to the CLONE_THREAD property which is a relatively new clone
bit. All the other thread properties (such as CLONE_VM, CLONE_SIGHAND) are
not affected by all the recent threading related changes. [well, they got
significantly faster, but no behavioral change.]

	Ingo

