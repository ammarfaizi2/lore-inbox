Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318630AbSIPCNk>; Sun, 15 Sep 2002 22:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318725AbSIPCNk>; Sun, 15 Sep 2002 22:13:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1799 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318630AbSIPCNj>; Sun, 15 Sep 2002 22:13:39 -0400
Date: Sun, 15 Sep 2002 19:19:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] thread-exec-2.5.34-B1, BK-curr
In-Reply-To: <1032140276.27001.27.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209151917280.2356-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Sep 2002, Alan Cox wrote:
> 
> There is code that depends on clone()/exec() not killing other threads
> in the group - some threaded web servers for example.

The new code _should_ trigger only for stuff that uses the "thread group" 
kind of thing, not normal clones. 

In other words, you can always get the old behaviour by just not asking
for a thread group (ie use just the old CLONE_SIGHAND, not CLONE_THREAD).

		Linus

