Return-Path: <linux-kernel-owner+w=401wt.eu-S1422751AbWLUGN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWLUGN1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 01:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWLUGN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 01:13:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41489 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422751AbWLUGN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 01:13:26 -0500
Date: Wed, 20 Dec 2006 22:12:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Message-Id: <20061220221252.732f4e97.akpm@osdl.org>
In-Reply-To: <200612201312.36616.david-b@pacbell.net>
References: <200611111541.34699.david-b@pacbell.net>
	<200612201304.03912.david-b@pacbell.net>
	<200612201312.36616.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 13:12:35 -0800
David Brownell <david-b@pacbell.net> wrote:

> +/* REVISIT these macros are correct, but suffer code explosion
> + * for non-constant parameters.  Provide out-line versions too.
> + */
> +#define gpio_get_value(gpio) \
> +	(GPLR(gpio) & GPIO_bit(gpio))
> +
> +#define gpio_set_value(gpio,value) \
> +	((value) ? (GPSR(gpio) = GPIO_bit(gpio)):(GPCR(gpio) = GPIO_bit(gpio)))

Why not implement them as inline functions?

Or non-inline functions, come to that.

Either way, programming in C is preferable to this ;)
