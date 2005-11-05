Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVKEGhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVKEGhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 01:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVKEGhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 01:37:25 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:10569 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751265AbVKEGhY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 01:37:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ieMhm/7Avl+wYoY41ugyxEDnJoP2+SlDJL+nn/t5ihU7HaFRC3bFJpOOqJFLQFhTt6s0YHPYDaMwhOasNX6uXgKiPGWPSmyTaNimfq41jFWNh5E2e3KJEK63W3lmOihllq92LEtH/Xe2oiBNYtO0fE2nJL/vGtdAXrPcYgAzNGU=
Message-ID: <21d7e9970511042237p618d6306qb63272a4fa2263ea@mail.gmail.com>
Date: Sat, 5 Nov 2005 17:37:24 +1100
From: Dave Airlie <airlied@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc64: 64K pages support
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <1131151488.29195.46.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1130915220.20136.14.camel@gaston>
	 <1130916198.20136.17.camel@gaston> <20051105003819.GA11505@lst.de>
	 <1131151488.29195.46.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What was the problem with drivers ? On ppc64, it's all hidden in the
> arch code. All the kernel sees is a 64k page size. I extended the PTE to
> contain tracking informations for the 16 sub pages (HPTE bits & hash
> slot index). Sub pages are faulted on demand and flushed all at once,
> but it's all transparent to the generic code.
>

We did that with the VAX port about 5 years ago :-), granted for
different reasons..

The VAX has 512 byte hw pages, we had to make a 4K pagesize for the
kernel by grouping 8 hw pages together and hiding it all in the arch
dir..

granted I don't know if it broke any drivers, we didn't have any...

Dave.
