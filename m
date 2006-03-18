Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWCRJv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWCRJv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 04:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWCRJv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 04:51:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45454 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932361AbWCRJv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 04:51:56 -0500
Date: Sat, 18 Mar 2006 01:49:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: sivanich@sgi.com, torvalds@osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, clameter@sgi.com,
       jes@sgi.com
Subject: Re: [PATCH] Add SA_PERCPU_IRQ flag support
Message-Id: <20060318014900.65889f69.akpm@osdl.org>
In-Reply-To: <20060317152645.52112021.akpm@osdl.org>
References: <20060317003114.GA1735@sgi.com>
	<20060317152645.52112021.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> +#ifdef ARCH_HAS_IRQ_PER_CPU
>  +	if (new->flags & SA_PERCPU_IRQ)
>  +		desc->status |= IRQ_PER_CPU;
>  +#endif

OK, five architectures define ARCH_HAS_IRQ_PER_CPU but only one of them
defines SA_PERCPU_IRQ.    Giving up.
