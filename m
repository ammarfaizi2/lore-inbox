Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317390AbSFMBTR>; Wed, 12 Jun 2002 21:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317391AbSFMBTQ>; Wed, 12 Jun 2002 21:19:16 -0400
Received: from [209.237.59.50] ([209.237.59.50]:16474 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317390AbSFMBTQ>; Wed, 12 Jun 2002 21:19:16 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, david-b@pacbell.net, oliver@neukum.name,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 add __dma_buffer alignment macro
In-Reply-To: <52zny049r7.fsf@topspin.com> <3D079D44.4000701@pacbell.net>
	<52wut42fig.fsf_-_@topspin.com>
	<20020612.180725.18975907.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 12 Jun 2002 18:19:12 -0700
Message-ID: <52k7p42cxb.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

    David> Just use asm/dma.h, no need to make a new file.

I could do that, however my thinking was that if I added it to an
existing file then it would add to the existing nested include bloat.
For example <asm/dma.h> for i386 has 10 inline functions and includes
<linux/config.h>, <linux/spinlock.h>, <asm/io.h> and <linux/delay.h>.
Seems kind of excessive just to get one macro that ends up being the
empty string, and I would prefer not to force people to include all
that just to declare a structure.

Best,
  Roland
