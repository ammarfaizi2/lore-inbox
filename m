Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSGUS4m>; Sun, 21 Jul 2002 14:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSGUS4m>; Sun, 21 Jul 2002 14:56:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14352 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312558AbSGUS4l>; Sun, 21 Jul 2002 14:56:41 -0400
Date: Sun, 21 Jul 2002 12:00:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A1
In-Reply-To: <Pine.LNX.4.44.0207212038350.23450-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207211156580.872-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Jul 2002, Ingo Molnar wrote:
>
>   http://redhat.com/~mingo/remove-irqlock-patches/config

This seems to have tons of stuff which makes it compile, but which is just
broken. Randomly changing "cli()" to "__cli()" apparently just to make it
compile, with no warning that its now buggy.

It's doubly wrong by virtue of the fact that you apparently left
"save_flags()" and "restore_flags()" alone, and changed their semantics
rather drastically.

Ugh. That should not happen. Either it compiles and is expected to work,
or it shouldn't compile (very limited config is fine, of course).

Robert, willing to take a look too?

		Linus

