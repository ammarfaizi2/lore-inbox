Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTIFST6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 14:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbTIFST6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 14:19:58 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:4728 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S261271AbTIFST5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 14:19:57 -0400
Date: Sat, 6 Sep 2003 19:21:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jamie Lokier <jamie@shareable.org>
cc: Linus Torvalds <torvalds@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: today's futex changes
In-Reply-To: <20030906174615.GA10987@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309061916530.1177-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Sep 2003, Jamie Lokier wrote:
> > And save a few bytes and improve debuggability
> > by uninlining the top-level futex_wake, futex_requeue, futex_wait.
> 
> Fair point about about debuggability, but does it really save bytes to
> uninline these called-once functions?

It saved about 50 with whatever 2.96 I'm using on this machine, but I
didn't try other gccs; it's probably added about that back in kallsyms...

Hugh

