Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289858AbSBEXSx>; Tue, 5 Feb 2002 18:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289859AbSBEXSe>; Tue, 5 Feb 2002 18:18:34 -0500
Received: from zero.tech9.net ([209.61.188.187]:23053 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289858AbSBEXSY>;
	Tue, 5 Feb 2002 18:18:24 -0500
Subject: Re: Continuing /dev/random problems with 2.4
From: Robert Love <rml@tech9.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Roland Dreier <roland@topspincom.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020205175725.3562A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020205175725.3562A-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 05 Feb 2002 18:17:26 -0500
Message-Id: <1012951046.1064.123.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-05 at 18:02, Bill Davidsen wrote:

> You seem to equate root space with user space, which is a kernel way of
> looking at things, particularly if you haven't been noting all the various
> hacker attacks lately. Just because it is possible to run in user space
> doesn't mean it's desirable to do so, and many sites don't really want
> things running as root so they can feed other things to the kernel.
> 
> The assumption that power users will know how to fix it and other users
> won't notice they have no entropy isn't all that appealing to me, I want
> Linux to be as easy to do right as the competition.

It is certainly desirable to run as much as feasibly possible in
userspace.  The only exception of things that could be handled in
userspace but are allowed to live in kernel space would be performance
critical and stable items (say, TCP/IP).

No one said the rngd has to run as root.  For example, run it as nobody
in a random group and give /dev/random write privileges to the random
group.

If userspace equates to insecure, and we stick things in the kernel for
that reason, we are beyond help ...

	Robert Love

