Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUFHKKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUFHKKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 06:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbUFHKKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 06:10:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:56723 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262361AbUFHKK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 06:10:29 -0400
Date: Tue, 8 Jun 2004 03:09:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, vince@kyllikki.org
Subject: Re: [VGA16FB] Fix bogus mem_start value
Message-Id: <20040608030906.0dd7d99f.akpm@osdl.org>
In-Reply-To: <20040608100530.GA26292@gondor.apana.org.au>
References: <20040608100530.GA26292@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> The recent change to vga16fb's memory mapping that you partially
>  reverted is still broken.  In particular, it's setting fix.mem_start
>  to a virtual address on i386.  The value of fix.mem_start is meant
>  to be physical.

Sigh.  Fiasco.

>  We could simply apply virt_to_phys to it, but somehow I doubt that
>  is what it's meant to do on arm.  So until we hear from someone who
>  knows how it works on arm, let's just revert this change.

Is this tested?
