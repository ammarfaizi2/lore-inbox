Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264146AbRFFU4w>; Wed, 6 Jun 2001 16:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264145AbRFFU4m>; Wed, 6 Jun 2001 16:56:42 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:30737 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264146AbRFFU4a>; Wed, 6 Jun 2001 16:56:30 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: How to know HZ from userspace?
Date: 6 Jun 2001 13:55:53 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9fm5cp$431$1@penguin.transmeta.com>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010530203725.H27719@corellia.laforge.distro.conectiva>,
Harald Welte  <laforge@gnumonks.org> wrote:
>
>Is there any way to read out the compile-time HZ value of the kernel?

In 2.4.x, you'll get it on the stack as one of the ELF auxilliary
entries (AT_CLKTCK). 

Strictly speaking that's the "frequency at which 'times()' counts", ie
the kernel CLOCKS_PER_SEC, not HZ. But from a user perspective the two
should hopefully always be the same (if any of the /proc fields etc
should really use CLOCKS_PER_SEC, not HZ).

		Linus
