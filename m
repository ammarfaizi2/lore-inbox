Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270671AbRHJW4C>; Fri, 10 Aug 2001 18:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270672AbRHJWzu>; Fri, 10 Aug 2001 18:55:50 -0400
Received: from zero.aec.at ([195.3.98.22]:18699 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S270671AbRHJWzf>;
	Fri, 10 Aug 2001 18:55:35 -0400
To: herbert@gondor.apana.org.au (Herbert Xu)
cc: linux-kernel@vger.kernel.org
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
In-Reply-To: <200108102159.f7ALxb908284@penguin.transmeta.com> <E15VL6x-0007Jm-00@gondolin.me.apana.org.au>
From: Andi Kleen <ak@muc.de>
Date: 11 Aug 2001 00:55:46 +0200
In-Reply-To: herbert@gondor.apana.org.au's message of "Fri, 10 Aug 2001 22:52:04 +0000 (UTC)"
Message-ID: <k2y9orcyod.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15VL6x-0007Jm-00@gondolin.me.apana.org.au>,
herbert@gondor.apana.org.au (Herbert Xu) writes:
> Linus Torvalds <torvalds@transmeta.com> wrote:
>> In article <20010810231906.A21435@bonzo.nirvana> you write:

>> You have to use the reboot() system call directly as root, with the
>> proper arguments to make it avoid doing even any sync. See

>> man 2 reboot

> How do you do this when the process in the D state is holding the BKL?

A process in D state sleeps and the BKL is always automatically dropped
when a process sleeps.

Bigger problems are other semaphores like inode sems, especially
when they belong to important shared libraries or directories.


-Andi
