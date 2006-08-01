Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWHAEE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWHAEE0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWHAEE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:04:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33921 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751565AbWHAEEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:04:25 -0400
Date: Mon, 31 Jul 2006 21:04:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Message-Id: <20060731210418.084f9f5d.akpm@osdl.org>
In-Reply-To: <20060801030443.GA2221@gondor.apana.org.au>
References: <20060801030443.GA2221@gondor.apana.org.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 13:04:43 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> 
> There is a bug in jbd with slab debugging enabled where it was submitting
> a bh obtained via jbd_rep_kmalloc which crossed a page boundary.  A lot
> of time was spent on tracking this down because the symptoms were far off
> from where the problem was.
> 
> This patch adds a sanity check to submit_bh so we can immediately spot
> anyone doing similar things in future.

Seems sane.

> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> While you're at it, could you fix that jbd bug for us :)

Could we have a more detailed description?
