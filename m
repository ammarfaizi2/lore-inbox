Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVHaWLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVHaWLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbVHaWLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:11:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29056 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964887AbVHaWLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:11:30 -0400
Date: Thu, 1 Sep 2005 00:10:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
cc: akpm@osdl.org, joe.korty@ccur.com, george@mvista.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: FW: [RFC] A more general timeout specification
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A042B0053@orsmsx407>
Message-ID: <Pine.LNX.4.61.0509010000390.3743@scrub.home>
References: <F989B1573A3A644BAB3920FBECA4D25A042B0053@orsmsx407>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 31 Aug 2005, Perez-Gonzalez, Inaky wrote:

> +	flags = tp->clock_id & TIMEOUT_FLAGS_MASK;
> +	clock_id = tp->clock_id & TIMEOUT_CLOCK_MASK;
> +
> +	result = -EINVAL;
> +	if (flags & ~TIMEOUT_RELATIVE)
> +	    goto out;
> +
> +	/* someday, we should support *all* clocks available to us */
> +	if (clock_id != CLOCK_REALTIME && clock_id != CLOCK_MONOTONIC)
> +		goto out;
> +	if ((unsigned long)tp->ts.tv_nsec >= NSEC_PER_SEC)
> +		goto out;

Why is that needed in a _general_ timeout API? What exactly makes it so 
useful for everyone and not just more complex for everyone?

bye, Roman
