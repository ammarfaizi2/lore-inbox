Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286895AbRLWOU3>; Sun, 23 Dec 2001 09:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282523AbRLWOUR>; Sun, 23 Dec 2001 09:20:17 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:56580 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S282483AbRLWOUF>; Sun, 23 Dec 2001 09:20:05 -0500
Message-ID: <3C25D07D.BB3B7939@linux-m68k.org>
Date: Sun, 23 Dec 2001 13:39:25 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Cornelis <fcorneli@elis.rug.ac.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: earlyclobber
In-Reply-To: <Pine.LNX.4.33.0112221752150.6586-100000@trappist.elis.rug.ac.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Frank Cornelis wrote:

> I think that in the file include/asm-i386/uaccess.h in some macro's the
> ecx register should be marked as an "earlyclobber" operand since it is
> one. Patch follows.
> 
> Frank.
> 
> @@ -337,7 +337,7 @@
>                         "       .align 4\n"                     \
>                         "       .long 0b,2b\n"                  \
>                         ".previous"                             \
> -                       : "=c"(size), "=&S" (__d0), "=&D" (__d1)\
> +                       : "=&c"(size), "=&S" (__d0), "=&D" (__d1)\
>                         : "1"(from), "2"(to), "0"(size/4)       \
>                         : "memory");                            \
>                 break;                                          \

This isn't needed, as there is no input operand to which it could be
assigned to.

bye, Roman


