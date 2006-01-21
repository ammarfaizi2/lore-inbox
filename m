Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWAUSmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWAUSmX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 13:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWAUSmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 13:42:23 -0500
Received: from mail.shareable.org ([81.29.64.88]:43964 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S932238AbWAUSmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 13:42:23 -0500
Date: Sat, 21 Jan 2006 18:42:19 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060121184219.GA1306@mail.shareable.org>
References: <200601212108.41269.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601212108.41269.a1426z@gawab.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Apps are executed inplace, as if already loaded.
> Physical RAM is used to cache slower storage RAM, much the same as the CPU 
> cache RAM caches slower physical RAM.

Linux and most other OSes have done that since.. oh, 20 years at least?

It's called "demand paging".  The RAM is simply a cache of the
executable file on disk.  The complicated-looking page fault mechanism
that you see is simply the cache management logic.  In what way is
your vision different from demand paging?

> my memory is equal to total disk-capacity.  What's more, there is no
> more swap.  [...]  Physical RAM is used to cache slower storage RAM,
> much the same as the CPU cache RAM caches slower physical RAM.

Windows has had that since, oh, Windows 95?

It's called "on-demand swap space", or making all the disk's free
space be usable for paging.  The physical RAM is simply a cache of the
virtual "storage RAM".  In what way is your vision different from
on-demand swap?

> Sadly, the current way of dealing with memory can at best only be described 
> as schizophrenic.  Again the reason being, that we are still running in the 
> last-century mode.
>
> Wouldn't it be nice to take advantage of todays 64bit archs and TB drives, 
> and run a more modern way of life w/o this memory/storage split personality?

In what way does your vision _behave_ any differently than what we have?

In my mind, "physical RAM is used to cache slower storage RAM" behaves
the same as demand paging, even if the terminology is different.  The
code I guess you're referring to in the kernel, to handle paging to
storage, is simply one kernel's method of implementing that kind of cache.

It's not clear from anything you said how the computer in your dream
would behave any differently to the ones we've got now.

Can you describe that difference, if there is one?

Is it just an implementation idea, where the kernel does less of the
page caching logic and some bit of hardware does more of it
automatically?  Given how little time is taken in kernel to do that,
and how complex the logic has to be for efficient caching decisions
between RAM and storage, it seems likely that any simple hardware
solution would behave the same, but slower.

-- Jamie
