Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288484AbSA0TrP>; Sun, 27 Jan 2002 14:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288485AbSA0TrD>; Sun, 27 Jan 2002 14:47:03 -0500
Received: from colorfullife.com ([216.156.138.34]:61189 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S288484AbSA0Tqu>;
	Sun, 27 Jan 2002 14:46:50 -0500
Message-ID: <002801c1a76b$623033f0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Hartmut Holz" <hartmut.holz@arcor.de>,
        "Rik van Riel" <riel@conectiva.com.br>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201261935330.32617-100000@imladris.surriel.com> <3C54546C.0@arcor.de>
Subject: Re: Uptime again?
Date: Sun, 27 Jan 2002 20:46:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Hartmut Holz" <hartmut.holz@arcor.de>
> Rik van Riel wrote:
> >
> > The fact that lavrec crashes the machine while Xawtv works
> > suggests a device driver may be corrupting memory somewhere.
> >
>
> I got a debug patch from Manfred Spraul to debug slab.c.

poisoning of fields of 'struct page', slab poisoning, even of objects with constructors.
Same patch as:
http://groups.google.com/groups?selm=linux.kernel.3C3B6F65.F9226437%40colorfullife.com&rnum=1

> With this patch
> the machine ran for about 3 hours. No problem. I looked into slab.c and had an
> idea. What about just one CPU. So I built a new Kernel with just one CPU.
> Result: 1 CPU 1 Minute - 2 CPU 20 Minutes. I aspected a different result.
> In my opinion the whole thing has something to do with slab, SMP and threads.
>
Not with slab itself, probably with a slab user. Someone uses a stale pointer.

What do you means with one cpu? Did you boot a SMP kernel with "nosmp" on the command line, or did you make a kernel without
CONFIG_SMP?

--
    Manfred

