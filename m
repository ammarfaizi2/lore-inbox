Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbUCZJjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 04:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263991AbUCZJjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 04:39:25 -0500
Received: from gprs214-219.eurotel.cz ([160.218.214.219]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264117AbUCZJjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 04:39:23 -0500
Date: Fri, 26 Mar 2004 01:18:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2][RFC] add detailed error values to block layer
Message-ID: <20040326001808.GA5110@elf.ucw.cz>
References: <4059AC04.3060109@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4059AC04.3060109@cs.wisc.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +enum {
> +	BLK_SUCCESS,
> +	BLK_ERR,		/* Generic error like -EIO */
> +	BLK_FATAL_DEV,		/* Fatal driver error */

	perhaps this should be fatal *device* error?

> +	BLK_FATAL_TRNSPT,	/* Fatal transport error */
> +	BLK_FATAL_DRV,		/* Fatal driver error */
> +	BLK_RETRY_DEV,		/* Device error, I/O may be retried */
> +	BLK_RETRY_TRNSPT,	/* Transport error, I/O may retried */
> +	BLK_RETRY_DRV,		/* Driver error, I/O may be retried */
> +};
> +
> +/*
>   * end_request() and friends. Must be called with the request queue spinlock
>   * acquired. All functions called within end_request() _must_be_ atomic.
>   *


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
