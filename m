Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbUKGKzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUKGKzB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 05:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUKGKzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 05:55:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8723 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261575AbUKGKy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 05:54:58 -0500
Date: Sun, 7 Nov 2004 10:54:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.10-rc1-bk] shrink struct device a bit
Message-ID: <20041107105447.A27505@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Greg KH <greg@kroah.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200411041937.31077.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200411041937.31077.david-b@pacbell.net>; from david-b@pacbell.net on Thu, Nov 04, 2004 at 08:37:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 08:37:31PM -0700, David Brownell wrote:
> Two fields were duplicates of ones in the PM struct,
> and weren't much used in any case.

> +#else	/* !CONFIG_PM */
> +#define sa1111_resume	0
> +#define sa1111_suspend	0
...
> +#else
> +#define	neponset_suspend	0
> +#define	neponset_resume	0
> +#endif

I think sparse will complain at being given '0' instead of 'NULL' for
pointers.  Please use NULL instead.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
