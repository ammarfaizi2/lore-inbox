Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbTIJHr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 03:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbTIJHr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 03:47:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:21426 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264942AbTIJHr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 03:47:26 -0400
Date: Wed, 10 Sep 2003 00:49:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, rjwalsh@durables.org
Subject: Re: [PATCH 1/3] netpoll api
Message-Id: <20030910004907.67b90bd1.akpm@osdl.org>
In-Reply-To: <20030910074030.GC4489@waste.org>
References: <20030910074030.GC4489@waste.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> +	spin_lock_irq(&irq_desc[ndev->irq].lock);
>  +	for(a=irq_desc[ndev->irq].action; a; a=a->next) {

Lots of architectures do not use irq_desc[].   You'll need abstracted
per-arch primitives for functions such as this.

