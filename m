Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUCBVZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbUCBVZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:25:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:27264 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261807AbUCBVZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:25:35 -0500
Date: Tue, 2 Mar 2004 16:26:26 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Roland Dreier <roland@topspin.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
In-Reply-To: <52vflnq807.fsf@topspin.com>
Message-ID: <Pine.LNX.4.53.0403021624300.2296@chaos>
References: <Pine.LNX.4.53.0403021318580.796@chaos> <527jy3qalg.fsf@topspin.com>
 <Pine.LNX.4.53.0403021510270.1856@chaos> <52vflnq807.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Roland Dreier wrote:

>     Richard> I'm talking about the driver! When a open fd called
>     Richard> poll() or select(), in user-mode code, the driver's
>     Richard> poll() was called, and the driver's poll() would call
>     Richard> poll_wait().  Poll_wait() used to NOT return until the
>     Richard> driver executed wake_up_interruptible() on that
>     Richard> wait-queue. When poll_wait() returned, the driver would
>     Richard> return to the caller with the new poll- status.
>
> I don't think so.  Even in kernel 2.4, poll_wait() just calls
> __pollwait().  I don't see anything in __pollwait() that sleeps.
> Think about it.  How would the kernel handle userspace calling poll()
> with more than one file descriptor if each individual driver slept?
>

Well what to you think they do? Spin?

> I'll repeat my earlier suggestion.  Read the description of "poll and
> select" in LDD:
>      <http://www.xml.com/ldd/chapter/book/ch05.html#t3>
>
> If you refuse to understand the documented interface, I don't think
> anyone can help you.

I am quite familiar with the operation of poll(), thank you.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


