Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSJIOFQ>; Wed, 9 Oct 2002 10:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261743AbSJIOFQ>; Wed, 9 Oct 2002 10:05:16 -0400
Received: from Morgoth.ESIWAY.NET ([193.194.16.157]:62732 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S261742AbSJIOFM>; Wed, 9 Oct 2002 10:05:12 -0400
Date: Wed, 9 Oct 2002 16:10:30 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org, <akpm@digeo.com>, <riel@conectiva.com.br>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
In-Reply-To: <1034044736.29463.318.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0210091606000.26363-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Oct 2002, Robert Love wrote:

> Attached patch implements an O_STREAMING file I/O flag which enables
> manual drop-behind of pages.

[...]
> diff -urN linux-2.4.20-pre9/include/asm-i386/fcntl.h linux/include/asm-i386/fcntl.h
> --- linux-2.4.20-pre9/include/asm-i386/fcntl.h	2002-10-06 14:57:21.000000000 -0400
> +++ linux/include/asm-i386/fcntl.h	2002-10-07 18:45:51.000000000 -0400
> @@ -20,6 +20,7 @@
>  #define O_LARGEFILE	0100000
>  #define O_DIRECTORY	0200000	/* must be a directory */
>  #define O_NOFOLLOW	0400000 /* don't follow links */
> +#define O_STREAMING    04000000	/* streaming access */
			^^^^^^^^^^^^^
>  
>  #define F_DUPFD		0	/* dup */
>  #define F_GETFD		1	/* get close_on_exec */
> diff -urN linux-2.4.20-pre9/include/asm-mips/fcntl.h linux/include/asm-mips/fcntl.h
> --- linux-2.4.20-pre9/include/asm-mips/fcntl.h	2002-10-06 14:57:21.000000000 -0400
> +++ linux/include/asm-mips/fcntl.h	2002-10-07 18:45:51.000000000 -0400
> @@ -26,6 +26,7 @@
>  #define O_DIRECT	0x8000	/* direct disk access hint */
>  #define O_DIRECTORY	0x10000	/* must be a directory */
>  #define O_NOFOLLOW	0x20000	/* don't follow links */
> +#define O_STREAMING    0x400000	/* streaming access */
			^^^^^^^^^^^^^
>  
>  #define O_NDELAY	O_NONBLOCK


04000000 != 0x400000

or am I missing something?
(do different archs dream of different O_STREAMING values?)

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

