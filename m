Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262910AbTCQGMi>; Mon, 17 Mar 2003 01:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262911AbTCQGMi>; Mon, 17 Mar 2003 01:12:38 -0500
Received: from mx1.elte.hu ([157.181.1.137]:40389 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262910AbTCQGMh>;
	Mon, 17 Mar 2003 01:12:37 -0500
Date: Mon, 17 Mar 2003 07:22:15 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] O(1) proc_pid_readdir
In-Reply-To: <20030316213516.GM20188@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0303170719410.15476-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Mar 2003, William Lee Irwin III wrote:

> I'm heavily on the side of deterministic bounds here (these things trip
> the NMI oopser, so if the bounds aren't deterministic, neither is
> stability), so I favor manfred's proc_pid_readdir() algorithm.

no, the code in question here is worst-case O(nr_tasks). It is worst-case
quadratic only if the number of syscalls done during a full 'ps' readdir()
sequence is considered as well. This thing will never trigger the NMI
oopser. And in the common-case it has constant overhead.

	Ingo

