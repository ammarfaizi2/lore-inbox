Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277047AbRJQSlD>; Wed, 17 Oct 2001 14:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277046AbRJQSkz>; Wed, 17 Oct 2001 14:40:55 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:25774 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S277047AbRJQSkm> convert rfc822-to-8bit; Wed, 17 Oct 2001 14:40:42 -0400
Date: Wed, 17 Oct 2001 20:35:30 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Tim Hockin <thockin@sun.com>
Cc: <groudier@club-internet.fr>, <alan@redhat.com>, <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] resubmitting sym53c8xx patches
In-Reply-To: <3BCCE721.8A72910E@sun.com>
Message-ID: <20011017201539.E1402-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Oct 2001, Tim Hockin wrote:

> All,
>
> I've submitted this patch a few times, and had it OKed each time, but it
> hasn't made it in.
>
> it does:
> * cleanup timer handling
> * spin lock host list
> * adds a reboot handler
> * remove __init from a function called from a non __init (needed for reboot
> handler)
>
>
> Please apply this for the next 2.4.x.

As long as the kernel does not look trustable to me, I avoid to send
driver changes that are not absolutely needed. Doing so just makes user
suspect the driver for any breakage that occurs after driver changes and
this wastes my time for no valuable reasons.

About your proposal, it has not been NOKed, but it is not the way I would
have implemented it. By the way, I already have cleaned up the module
timer killing ins sym-2.1.15 driver (easily back-portable to sym53c8xx).
You may look at it (ftp.tux.org) if you are interested in knowing how I
would like it to have been done. For example, there are a couple of some
_smart_ #if that allows to preserve kernel 2.2 compatibility with the same
source. People who donnot like cpp should switch to Java in my opinion.
Compiling lot of stuff like inlines that will not in fact be used is false
cosmetic in my opinion.

The reboot handler stuff is useless in my opinion and OTOH last time I
looked in the kernel code related to reboot handler stuff it looks to me
very incomplete. Useless stuff implies additionnal bugs that could have
been avoided.

I am not opposed to your patch and will not complain if it is applied to
kernel 2.4. I just haven't time for submitting another patch quickly nor
have time for following any breakage due to its new interactions with the
kernel.

Regards,
  Gérard.


