Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbVKCD7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbVKCD7d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbVKCD7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:59:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750804AbVKCD7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:59:32 -0500
Date: Thu, 3 Nov 2005 13:59:10 +1100
From: Andrew Morton <akpm@osdl.org>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH 26/37] dvb: add support for plls used by nxt200x
Message-Id: <20051103135910.3bf893d9.akpm@osdl.org>
In-Reply-To: <4367241A.1060300@m1k.net>
References: <4367241A.1060300@m1k.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
> +struct dvb_pll_desc dvb_pll_tdhu2 = {
>  +	.name = "ALPS TDHU2",
>  +	.min = 54000000,
>  +	.max = 864000000,
>  +	.count = 4,
>  +	.entries = {
>  +		{ 162000000, 44000000, 62500, 0x85, 0x01 },
>  +		{ 426000000, 44000000, 62500, 0x85, 0x02 },
>  +		{ 782000000, 44000000, 62500, 0x85, 0x08 },
>  +		{ 999999999, 44000000, 62500, 0x85, 0x88 },
>  +	}
>  +};
>  +EXPORT_SYMBOL(dvb_pll_tdhu2);

The new driver is to have a GPL license, I assume?

Generally, EXPORT_SYMBOL_GPL seems more appropriate for the DVB subsystem.
