Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWHYRlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWHYRlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 13:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWHYRli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 13:41:38 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4621 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750724AbWHYRli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 13:41:38 -0400
Date: Fri, 25 Aug 2006 18:41:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: New serial speed handling: First implementation
Message-ID: <20060825174131.GA725@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1156518953.3007.247.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156518953.3007.247.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 04:15:53PM +0100, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/include/asm-i386/ioctls.h linux-2.6.18-rc4-mm2/include/asm-i386/ioctls.h
> --- linux.vanilla-2.6.18-rc4-mm2/include/asm-i386/ioctls.h	2006-08-21 14:17:52.000000000 +0100
> +++ linux-2.6.18-rc4-mm2/include/asm-i386/ioctls.h	2006-08-25 11:23:20.000000000 +0100
> @@ -47,6 +47,12 @@
>  #define TIOCSBRK	0x5427  /* BSD compatibility */
>  #define TIOCCBRK	0x5428  /* BSD compatibility */
>  #define TIOCGSID	0x5429  /* Return the session ID of FD */
> +
> +#define TCGETS2		0x542A
> +#define TCSETS2		0x542B
> +#define TCSETSW2	0x542C
> +#define TCSETSF2	0x542D
> +

Wouldn't it be better to use the _IO* macros to define these new ioctls?
Ditto for other architectures.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
