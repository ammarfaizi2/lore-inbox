Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268288AbUGXFNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268288AbUGXFNH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 01:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUGXFNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 01:13:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:54479 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268288AbUGXFNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 01:13:04 -0400
Date: Sat, 24 Jul 2004 01:11:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@ximian.com>
Cc: kaos@ocs.com.au, da-x@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-Id: <20040724011129.54971669.akpm@osdl.org>
In-Reply-To: <1090645238.2296.37.camel@localhost>
References: <4956.1090644161@ocs3.ocs.com.au>
	<1090645238.2296.37.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@ximian.com> wrote:
>
> +	buffer = (char *) get_zeroed_page(gfp_mask);

Why zeroed?

> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	snprintf(buffer, PAGE_SIZE, "From: %s\n", object);
> +	len = strlen(buffer);
> +	snprintf(buffer + len, PAGE_SIZE - len, "Signal: %s\n", signal);
> +	len = strlen(buffer);

A single snprintf here would suit.
