Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262422AbSJKIRb>; Fri, 11 Oct 2002 04:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262428AbSJKIRb>; Fri, 11 Oct 2002 04:17:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51215 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262422AbSJKIRa>; Fri, 11 Oct 2002 04:17:30 -0400
Date: Fri, 11 Oct 2002 09:23:14 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH][2.5] serial8250_init premature release
Message-ID: <20021011092314.A3062@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0210110034170.13310-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210110034170.13310-100000@montezuma.mastecende.com>; from zwane@linuxpower.ca on Fri, Oct 11, 2002 at 12:35:41AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 12:35:41AM -0400, Zwane Mwaikambo wrote:
> --- linux-2.5.41-mm/drivers/serial/8250.c.orig	2002-10-11 00:33:09.000000000 -0400
> +++ linux-2.5.41-mm/drivers/serial/8250.c	2002-10-11 00:33:11.000000000 -0400
> @@ -2051,7 +2051,7 @@
>  }
>  #endif
>  
> -int __init serial8250_init(void)
> +int serial8250_init(void)
>  {
>  	int ret, i;
>  	static int didit = 0;
> 

This doesn't apply to my tree.  serial8250_init should not be called at
any other time than initialisation.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

