Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVINA25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVINA25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 20:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVINA25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 20:28:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964941AbVINA24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 20:28:56 -0400
Date: Tue, 13 Sep 2005 17:28:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Separate tainted code from panic code
Message-Id: <20050913172816.35835b66.akpm@osdl.org>
In-Reply-To: <20050913230718.GA14867@mipter.zuzino.mipt.ru>
References: <20050913230718.GA14867@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> * Create kernel/tainted.c and include/linux/tainted.h
>  * Move all tainted-related stuff from kernel/panic.c and
>    include/linux/kernel.h there.
>  * #include <linux/tainted.h> where needed.
>  * Switch #include <linux/kernel.h> to #include <linux/tainted.h> in
>    kernel/module.c and mm/page_alloc.c . Said includes were added during
>    add_taint() propagation and tainted stuff was in kernel.h back then.

Why?  What reason is there for making these changes?

