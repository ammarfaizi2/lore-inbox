Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318785AbSG0Qxh>; Sat, 27 Jul 2002 12:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318788AbSG0Qxh>; Sat, 27 Jul 2002 12:53:37 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:23044 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318785AbSG0Qxh>; Sat, 27 Jul 2002 12:53:37 -0400
Date: Sat, 27 Jul 2002 13:56:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell Lewis <spamhole-2001-07-16@deming-os.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory? 
In-Reply-To: <16918.1027787098@redhat.com>
Message-ID: <Pine.LNX.4.44L.0207271355040.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2002, David Woodhouse wrote:
> alan@lxorguk.ukuu.org.uk said:
> >  Memory is relatively cheap, and the complexity of such a paging
> > kernel is huge (you have to pin down disk driver and I/O paths for
> > example). Linux prefers to try to keep simple debuggable approaches to
> > things.
>
> You could do it. Start with kmalloc_pageable ...

Funny things are bound to happen when code gets preempted because
of page faults...

> It's debatable what kind of benefit it would give you over and above
> just fixing specific cases like page tables, though.

In all extreme cases you'll find that 90% of kernel memory is
tied up in just a few data structures.

Making a generic infrastructure just to deal with these specific
cases is almost certainly overkill.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

