Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSHAUoY>; Thu, 1 Aug 2002 16:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSHAUoY>; Thu, 1 Aug 2002 16:44:24 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:20487 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317091AbSHAUoX>; Thu, 1 Aug 2002 16:44:23 -0400
Date: Thu, 1 Aug 2002 22:47:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers 
In-Reply-To: <Pine.LNX.4.33.0208011315220.12103-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208012241390.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Aug 2002, Linus Torvalds wrote:

> Easy reason: there are tons of code sequences that _cannot_ take signals.
> The only way to make a signal go away is to actually deliver it, and there
> are documented interfaces that are guaranteed to complete without
> delivering a signal. The trivial case is a disk read: real applications
> break if you return partial results in order to handle signals in the
> middle.
>
> In short, this is not something that can be discussed. It's a cold fact, a
> law of UNIX if you will.

Any program setting up signal handlers should expext interrupted i/o,
otherwise it's buggy. If a program doesn't have any signal handlers, there
is no signal to deliver, so simple programs don't need to worry.

bye, Roman


