Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTJFMu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 08:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTJFMu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 08:50:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:42626 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261969AbTJFMuz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 08:50:55 -0400
Date: Mon, 6 Oct 2003 08:52:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Hans-Georg Thien <1682-600@onlinehome.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: getting timestamp of last interrupt?
In-Reply-To: <3F7E46AB.3030709@onlinehome.de>
Message-ID: <Pine.LNX.4.53.0310060843500.8593@chaos>
References: <fa.fj0euih.s2sbop@ifi.uio.no> <fa.fvjdidn.13ni70f@ifi.uio.no>
 <3F7E46AB.3030709@onlinehome.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Oct 2003, Hans-Georg Thien wrote:

> Richard B. Johnson wrote:
> > On Thu, 2 Oct 2003, Hans-Georg Thien wrote:
> >
> >
> >>I am looking for a possibility to read out the last timestamp when an
> >>interrupt has occured.
> >>
> >>e.g.: the user presses a key on the keyboard. Where can I read out the
> >>timestamp of this event?
> >
> >
> > You can get A SIGIO signal for every keyboard, (or other input) event.
> > What you do with it is entirely up to you. Linux/Unix doesn't have
> > "callbacks", instead it has signals. It also has select() and poll(),
> > all useful for handling such events. If you want a time-stamp, you
> > call gettimeofday() in your signal handler.
> >
> Thanks a lot Richard,
>
> ... but ... can I use signals in kernel mode?

Well you talked about the user pressing a key and getting
a time-stamp as a result. If you need time-stamps
inside the kernel, i.e, a module, then you can call
the kernel's do_gettimeofday() function.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


