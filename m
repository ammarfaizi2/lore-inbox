Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318976AbSHSSrz>; Mon, 19 Aug 2002 14:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318982AbSHSSrz>; Mon, 19 Aug 2002 14:47:55 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:14471 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318976AbSHSSry>; Mon, 19 Aug 2002 14:47:54 -0400
Date: Mon, 19 Aug 2002 13:51:42 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
Message-ID: <65670000.1029783102@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0208192034260.30906-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208192034260.30906-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, August 19, 2002 08:36:24 PM +0200 Ingo Molnar <mingo@elte.hu>
wrote:

> well, this means that we'd still have to iterate through both lists in
> wait4(), and we'd have to maintain the ptrace list(s) in all the relevant
> codepaths - does this buy us anything relative to -B4?

The lists would constitute the tasks that wait4() should consider, at
least.    And maintaining the list wouldn't be any more work than the
current reparenting. I do admit that I don't see a significant win,
codewise, other than aesthetics.

In looking at the code I was wondering something.  What happens to the real
parent of a ptraced task when it calls wait4()?  If that's its only child,
won't it return ECHILD?

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

