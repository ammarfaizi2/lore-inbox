Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWHAXoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWHAXoW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWHAXoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:44:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55979 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750739AbWHAXoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:44:22 -0400
Date: Tue, 1 Aug 2006 16:44:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: axboe@suse.de (Jens Axboe), linux-kernel@vger.kernel.org
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Message-Id: <20060801164408.bd0305f3.akpm@osdl.org>
In-Reply-To: <E1G83hL-00035h-00@gondolin.me.apana.org.au>
References: <20060801072315.GH31908@suse.de>
	<E1G83hL-00035h-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2006 09:30:51 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Jens Axboe <axboe@suse.de> wrote:
> >
> > That looks really dangerous, I'd prefer that to be a BUG_ON() as well to
> > prevent nastiness further down.
> 
> OK, I used a WARN_ON mainly because ext3 has been doing this for years
> without killing anyone until now :)

I can't apply either of these patches, because we _know_ it'll trigger.

Once the JBD fix is in hand, we can go with a WARN_ON_ONCE and if that is
all clear, then we can make it a BUG_ON().

