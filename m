Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVB1NCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVB1NCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVB1NCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:02:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49928 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261582AbVB1NCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:02:35 -0500
Date: Mon, 28 Feb 2005 13:02:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: colbuse@ensisun.imag.fr
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
Message-ID: <20050228130228.B12441@flint.arm.linux.org.uk>
Mail-Followup-To: colbuse@ensisun.imag.fr, linux-kernel@vger.kernel.org,
	akpm@zip.com.au
References: <1109595479.422315570842d@webmail.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1109595479.422315570842d@webmail.imag.fr>; from colbuse@ensisun.imag.fr on Mon, Feb 28, 2005 at 01:57:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 01:57:59PM +0100, colbuse@ensisun.imag.fr wrote:
> Please _don't_ apply this, but tell me what you think about it.

It's broken. 8)

> --- old/drivers/char/vt.c       2004-12-24 22:35:25.000000000 +0100
> +++ new/drivers/char/vt.c       2005-02-28 12:53:57.933256631 +0100
> @@ -1655,9 +1655,9 @@
>                         vc_state = ESnormal;
>                 return;
>         case ESsquare:
> -               for(npar = 0 ; npar < NPAR ; npar++)
> +               for(npar = NPAR-1; npar < NPAR; npar--)

How many times do you want this for loop to run?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
