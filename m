Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbTEFUkD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbTEFUkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:40:03 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:28934 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261849AbTEFUjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:39:18 -0400
Date: Tue, 6 May 2003 21:51:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH[[2.5][6-11] add a new dvb frontend driver
Message-ID: <20030506215150.B18262@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <3EB7DF1A.4030906@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EB7DF1A.4030906@convergence.de>; from hunold@convergence.de on Tue, May 06, 2003 at 06:13:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 06:13:14PM +0200, Michael Hunold wrote:
> +#include <asm/errno.h>

always use linux/errno.h, not asm/errno.h

> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +
> +#include "dvb_frontend.h"
> +#include "dvb_functions.h"
> +
> +static int debug = 0;

This is in .bss, no need to initialize.

> +#define dprintk	if (debug) printk

Every heard of do { foo } while (0) ;)

> +static
> +struct dvb_frontend_info cx24110_info = {
> +	name: "Conexant CX24110 with CX24108 tuner, aka HM1221/HM1811",
> +	type: FE_QPSK,

Please use C99 initializers, also the static is positioned very strange..

