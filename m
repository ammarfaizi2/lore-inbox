Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTJTJZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 05:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbTJTJZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 05:25:41 -0400
Received: from [65.172.181.6] ([65.172.181.6]:35495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262461AbTJTJZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 05:25:40 -0400
Date: Mon, 20 Oct 2003 02:25:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Noah J. Misch" <noah@caltech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Missing include in swap.h for some architectures
Message-Id: <20031020022536.796531c4.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0310171453450.13905@blinky>
References: <Pine.GSO.4.58.0310171453450.13905@blinky>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Noah J. Misch" <noah@caltech.edu> wrote:
>
> # The linux/swap.h header uses the page_cache_release and release_pages
>  # functions declared in linux/pagemap.h when CONFIG_SWAP is disabled.  Add
>  # an include of linux/pagemap.h so swap.h finds those declarations on
>  # architectures that don't include pagemap.h indirectly.

This carries a small risk of breaking things.  I think I'd prefer that the
offending .c files just include pagemap.h please.

