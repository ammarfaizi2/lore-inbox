Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316215AbSEVP7u>; Wed, 22 May 2002 11:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316221AbSEVP7t>; Wed, 22 May 2002 11:59:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25615 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316215AbSEVP7s>; Wed, 22 May 2002 11:59:48 -0400
Date: Wed, 22 May 2002 08:59:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Martin Dalecki <dalecki@evision-ventures.com>, Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
In-Reply-To: <1022061793.28881.29.camel@nomade>
Message-ID: <Pine.LNX.4.44.0205220857030.7580-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 22 May 2002, Xavier Bestel wrote:
>
> Compressing pages will speed up the process, and doing it on the fly
> will be more IO-bound than CPU-bound. I think trading some CPU power to
> gain HD time isn't so uninteresting.

It's been a long time since disks were so slow that compression speeded
things up.

_uncompression_ is often faster than disk speeds, but that's a
fundamentally easier problem to solve. That means that a mostly read-only
medium tends to work better with compressed contents, but in this case we
have a write-once, read-once thing where compression is likely to lose.

Yes, laptops have slow disks, but they often have slow memory and seldom
have the fastest CPU's available.

		Linus

