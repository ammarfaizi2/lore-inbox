Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262307AbRE0VVa>; Sun, 27 May 2001 17:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262300AbRE0VVK>; Sun, 27 May 2001 17:21:10 -0400
Received: from chiara.elte.hu ([157.181.150.200]:53512 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S262299AbRE0VVE>;
	Sun, 27 May 2001 17:21:04 -0400
Date: Sun, 27 May 2001 23:19:20 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] softirq-2.4.5-B0
In-Reply-To: <oup4ru6bifp.fsf@pigdrop.muc.suse.de>
Message-ID: <Pine.LNX.4.33.0105272316210.7159-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 May 2001, Andi Kleen wrote:

> I think the right way to fix it is to do a final atomic check for
> softirqs when the kernel is exited. To be atomic this check neededs to
> be done with interrupts off until the kernel exited. [...]

check out my first softirq patch, it does exactly this. (but has the wrong
explanation.)

> [...] The same atomic check is needed for race free check of
> need_schedule (which is still racy on plain i386).

right, this need_resched race is fixed in the lowlatency patchset.

	Ingo

