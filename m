Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbSLXUTZ>; Tue, 24 Dec 2002 15:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbSLXUTZ>; Tue, 24 Dec 2002 15:19:25 -0500
Received: from mx1.elte.hu ([157.181.1.137]:35989 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S265806AbSLXUTY>;
	Tue, 24 Dec 2002 15:19:24 -0500
Date: Tue, 24 Dec 2002 21:31:11 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <hpa@transmeta.com>,
       <terje.eggestad@scali.com>, Matti Aarnio <matti.aarnio@zmailer.org>,
       <hugh@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212241126020.1219-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212242127190.6603-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Dec 2002, Linus Torvalds wrote:

> I realized that there is really no reason to use __KERNEL_DS for this,
> and that as far as the kernel is concerned, the only thing that matters
> is that it's a flat 32-bit segment. So we might as well make the kernel
> always load ES/DS with __USER_DS instead, which has the advantage that
> we can avoid one set of segment loads for the "sysenter/sysexit" case.

this basically hardcodes flat segment layout on x86. If anything (Wine?)
modifies the default segments, it can wrap syscalls by saving/restoring
the modified %ds and %es selectors explicitly.

	Ingo

