Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268081AbUHaV4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268081AbUHaV4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUHaVxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:53:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:12707 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267932AbUHaVxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:53:08 -0400
Date: Tue, 31 Aug 2004 14:56:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@ximian.com>
Cc: greg@kroah.com, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-Id: <20040831145643.08fdf612.akpm@osdl.org>
In-Reply-To: <1093988576.4815.43.camel@betsy.boston.ximian.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@ximian.com> wrote:
>
> +	len = strlen(object) + 1 + strlen(signal);
> +
> +	skb = alloc_skb(len, gfp_mask);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	buffer = skb_put(skb, len);
> +
> +	sprintf(buffer, "%s\n%s", object, signal);

Buffer overrun, methinks.
