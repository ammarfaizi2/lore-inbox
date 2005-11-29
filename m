Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVK2IJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVK2IJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 03:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVK2IJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 03:09:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39133 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750800AbVK2IJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 03:09:26 -0500
Date: Tue, 29 Nov 2005 00:09:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Grzegorz Nosek <grzegorz.nosek@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] race condition in procfs
Message-Id: <20051129000916.6306da8b.akpm@osdl.org>
In-Reply-To: <121a28810511282317j47a90f6t@mail.gmail.com>
References: <121a28810511282317j47a90f6t@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Nosek <grzegorz.nosek@gmail.com> wrote:
>
> Hello,
> 
> I found a race condition in procfs on SMP systems. The result is an
> oops in processes like pidof. Apparently ->proc_read() gets passed a
> potentially NULL pointer.

Do you know what the race is?

How does one reproduce it?

> The following micro-patch seems to fix it.

It might be right, or it might be a workaround..

