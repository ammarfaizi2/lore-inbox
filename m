Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVAGVnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVAGVnX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVAGVl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:41:27 -0500
Received: from alog0359.analogic.com ([208.224.222.135]:12416 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261625AbVAGVjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:39:45 -0500
Date: Fri, 7 Jan 2005 16:38:36 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 167] Kill unused variables in the net code
In-Reply-To: <200501072111.j07LB4EN011223@anakin.of.borg>
Message-ID: <Pine.LNX.4.61.0501071636160.21727@chaos.analogic.com>
References: <200501072111.j07LB4EN011223@anakin.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005, Geert Uytterhoeven wrote:

> 2.4.28-rc2 introduced a warning in the net code on non-SMP:
>
>    net/core/neighbour.c:1809: warning: unused variable `tbl'
>
> The following patch fixes this.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> --- linux-2.4.29-rc1/include/linux/spinlock.h	2004-04-27 17:22:10.000000000 +0200
> +++ linux-m68k-2.4.29-rc1/include/linux/spinlock.h	2005-01-07 21:51:28.000000000 +0100
> @@ -147,7 +147,7 @@
>
> #define rwlock_init(lock)	do { } while(0)
> #define read_lock(lock)	(void)(lock) /* Not "unused variable". */
> -#define read_unlock(lock)	do { } while(0)
> +#define read_unlock(lock)	(void)(lock) /* Not "unused variable". */
> #define write_lock(lock)	(void)(lock) /* Not "unused variable". */
> #define write_unlock(lock)	do { } while(0)
>
>
> Gr{oetje,eeting}s,
>
> 						Geert


But don't all you need to do is:

#define read_unlock(x)





Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
