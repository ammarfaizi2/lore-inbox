Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262753AbTCPUyt>; Sun, 16 Mar 2003 15:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262754AbTCPUyt>; Sun, 16 Mar 2003 15:54:49 -0500
Received: from mx1.elte.hu ([157.181.1.137]:10901 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262753AbTCPUyt>;
	Sun, 16 Mar 2003 15:54:49 -0500
Date: Sun, 16 Mar 2003 22:05:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] O(1) proc_pid_readdir
In-Reply-To: <Pine.LNX.4.44.0303161645030.27928-100000@dbl.q-ag.de>
Message-ID: <Pine.LNX.4.44.0303162203590.11399-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Mar 2003, Manfred Spraul wrote:

> Below is a proposal to get rid of the quadratic behaviour of
> proc_pid_readir(): Instead of storing the task number in f_pos and
> walking tasks by tasklist order, the pid is stored in f_pos and the
> tasks are walked by (hash-mangled) pid order.

have you seen my "procfs/procps threading performance speedup" patch? It
does something like this.

	Ingo

