Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129470AbQKVVKs>; Wed, 22 Nov 2000 16:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130647AbQKVVKj>; Wed, 22 Nov 2000 16:10:39 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:25846 "EHLO
        brutus.conectiva.com.br") by vger.kernel.org with ESMTP
        id <S129470AbQKVVKZ>; Wed, 22 Nov 2000 16:10:25 -0500
Date: Wed, 22 Nov 2000 18:40:07 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Reserved root VM + OOM killer
In-Reply-To: <Pine.LNX.4.30.0011221736000.14122-100000@fs129-190.f-secure.com>
Message-ID: <Pine.LNX.4.21.0011221839160.12459-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000, Szabolcs Szakacsits wrote:

>    - OOM killing takes place only in do_page_fault() [no two places in
>         the kernel for process killing]

... disable OOM killing for non-x86 architectures.
This doesn't seem like a smart move ;)

> diff -urw linux-2.2.18pre21/arch/i386/mm/Makefile linux/arch/i386/mm/Makefile
> --- linux-2.2.18pre21/arch/i386/mm/Makefile	Fri Nov  1 04:56:43 1996
> +++ linux/arch/i386/mm/Makefile	Tue Nov 21 03:03:15 2000
> @@ -8,6 +8,6 @@
>  # Note 2! The CFLAGS definition is now in the main makefile...
> 
>  O_TARGET := mm.o
> -O_OBJS	 := init.o fault.o ioremap.o extable.o
> +O_OBJS	 := init.o fault.o ioremap.o extable.o ../../../mm/oom_kill.o
> 
>  include $(TOPDIR)/Rules.make

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
