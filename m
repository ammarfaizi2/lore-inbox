Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbTGCQao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265073AbTGCQ23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:28:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7947 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265062AbTGCQ1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:27:41 -0400
Date: Thu, 3 Jul 2003 17:42:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.74] correct gcc bug comment in <linux/spinlock.h>
Message-ID: <20030703174204.D20336@flint.arm.linux.org.uk>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <200307031608.h63G8B1r006911@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307031608.h63G8B1r006911@harpo.it.uu.se>; from mikpe@csd.uu.se on Thu, Jul 03, 2003 at 06:08:11PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 06:08:11PM +0200, Mikael Pettersson wrote:
> Linus,
> 
> This patch updates include/linux/spinlock.h's comment regarding gcc
> bugs for empty struct initializers, to correctly state that the bug
> is present also in 2.95.x and at least early versions of 2.96 (as
> reported by one Mandrake user).
> 
> /Mikael
> 
> --- linux-2.5.74/include/linux/spinlock.h.~1~	2003-07-03 12:32:46.000000000 +0200
> +++ linux-2.5.74/include/linux/spinlock.h	2003-07-03 16:07:59.772534704 +0200
> @@ -144,7 +144,7 @@
>  	} while (0)
>  #else
>  /*
> - * gcc versions before ~2.95 have a nasty bug with empty initializers.
> + * gcc versions up to 2.95, and early versions of 2.96, have a nasty bug with empty initializers.
>   */
>  #if (__GNUC__ > 2)
>    typedef struct { } spinlock_t;

This also isn't that clear (does it mean up to 2.95.0 but not including
2.95.1 etc.)  Also, we don't build with gcc < 2.95 anyway, so there's
no need to mention anything older.  This removes the doubt:

"All gcc 2.95 versions and early versions of gcc 2.96 have a nasty bug with
 empty initializers."

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

