Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293175AbSCJTQg>; Sun, 10 Mar 2002 14:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293184AbSCJTQ0>; Sun, 10 Mar 2002 14:16:26 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:2064 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S293175AbSCJTQQ>; Sun, 10 Mar 2002 14:16:16 -0500
Date: Sun, 10 Mar 2002 19:15:59 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.6: JFS vs gcc 2.95.4
In-Reply-To: <3C8BA70A.206C0EFE@zip.com.au>
Message-ID: <Pine.LNX.4.33.0203101914170.3037-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2002, Andrew Morton wrote:

> This worked for me:

Builds for me, too.  Are you sure that constraint
isn't useful?

Matthew.

> --- linux-2.5.6/include/asm-i386/rwsem.h	Tue Feb 19 18:11:01 2002
> +++ 25/include/asm-i386/rwsem.h	Sat Mar  9 14:37:35 2002
> @@ -164,7 +164,7 @@ LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n
>  		"  jmp       1b\n"
>  		LOCK_SECTION_END
>  		"# ending __up_read\n"
> -		: "+m"(sem->count), "+d"(tmp)
> +		: /*"+m"(sem->count),*/ "+d"(tmp)
>  		: "a"(sem)
>  		: "memory", "cc");
>  }

