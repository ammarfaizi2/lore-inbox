Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130671AbQKVVYW>; Wed, 22 Nov 2000 16:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131006AbQKVVYL>; Wed, 22 Nov 2000 16:24:11 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:11282 "HELO
        dfmail.f-secure.com") by vger.kernel.org with SMTP
        id <S130671AbQKVVYG>; Wed, 22 Nov 2000 16:24:06 -0500
Date: Wed, 22 Nov 2000 22:05:02 +0100 (MET)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] Reserved root VM + OOM killer
In-Reply-To: <Pine.LNX.4.21.0011221839160.12459-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0011222158260.14122-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Nov 2000, Rik van Riel wrote:

> On Wed, 22 Nov 2000, Szabolcs Szakacsits wrote:
>
> >    - OOM killing takes place only in do_page_fault() [no two places in
> >         the kernel for process killing]
>
> ... disable OOM killing for non-x86 architectures.
> This doesn't seem like a smart move ;)
>
> > diff -urw linux-2.2.18pre21/arch/i386/mm/Makefile linux/arch/i386/mm/Makefile
> > --- linux-2.2.18pre21/arch/i386/mm/Makefile	Fri Nov  1 04:56:43 1996
                          ^^^^^^^^^
As I wrote, the OOM killer changes are x86 only at present. Other
arch's still use the default OOM killing defined in arch/*/mm/fault.c.

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
