Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278504AbRJPCgd>; Mon, 15 Oct 2001 22:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278507AbRJPCgX>; Mon, 15 Oct 2001 22:36:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13828 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278504AbRJPCgI>; Mon, 15 Oct 2001 22:36:08 -0400
Date: Mon, 15 Oct 2001 19:36:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4.13-pre3 arm/i386/mips/mips64/s390/s390x/sh die()
 deadlock
In-Reply-To: <18579.1003198988@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0110151934060.4179-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Oct 2001, Keith Owens wrote:
>
> Any die() routine that uses die_lock to avoid multiple cpu reentrancy
> will deadlock on recursive die() errors.

Well, I have to say that I personally have always considered the "die"
lock to not be about multiple CPU re-entrancy, but _exactly_ to stop
infinite oops reports if an oops itself oopses.

I much prefer a dead machine with a partially visible oops over a oops
where the original oops has scrolled away due to recursive faults.

Quite frankly, I consider the ia64 case to be a ia64 bug, nothing more.

		Linus

