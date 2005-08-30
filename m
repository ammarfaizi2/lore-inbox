Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVH3V0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVH3V0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 17:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVH3V0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 17:26:53 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:15258 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932480AbVH3V0v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 17:26:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EwJhWVO//E0qs7odY0PYmeKKahoqcErwNILlUnR0BtlikxtSvaBKzb+hp1wMdYiHGHUPRHTFGqkcKDuPQFKiwViPU0sapjgPuS7yEEGDiuq8rANptEJ6QJd+llw3WpqB2f23fq9TsRIuscj+FHEgRi54Sds6bmYDi6Im2aEMjdA=
Message-ID: <9a87484905083014267caba221@mail.gmail.com>
Date: Tue, 30 Aug 2005 23:26:50 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Sridhar Samudrala <sri@us.ibm.com>
Subject: Re: [PATCH] crypto_free_tfm callers do not need to check for NULL
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@mail.ru>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       "David S. Miller" <davem@davemloft.net>,
       Benjamin Reed <breed@users.sourceforge.net>,
       Andy Adamson <andros@citi.umich.edu>, netdev@vger.kernel.org,
       lksctp developers <lksctp-developers@lists.sourceforge.net>,
       Bruce Fields <bfields@umich.edu>, Andy Adamson <andros@umich.edu>,
       linux-net@vger.kernel.org, linux-crypto@vger.kernel.org
In-Reply-To: <1125436415.3952.11.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508302245.55392.jesper.juhl@gmail.com>
	 <1125436415.3952.11.camel@w-sridhar2.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Sridhar Samudrala <sri@us.ibm.com> wrote:
> On Tue, 2005-08-30 at 22:45 +0200, Jesper Juhl wrote:
> > Since the patch to add a NULL short-circuit to crypto_free_tfm() went in,
> > there's no longer any need for callers of that function to check for NULL.
> > This patch removes the redundant NULL checks and also a few similar checks
> > for NULL before calls to kfree() that I ran into while doing the
> > crypto_free_tfm bits.
> >
> > I've posted similar patches in the past, but was asked to first until the
> > short-circuit patch moved from -mm to mainline - and since it is now
> > firmly there in 2.6.13 I assume there's no problem there anymore.
> > I was also asked previously to make the patch against mainline and not -mm,
> > so this patch is against 2.6.13.
> >
> > Feedback, ACK, NACK, etc welcome.
> 
> sctp change looks fine.
> A similar check in sctp_endpoint_destroy() can also be removed.
> 
Thanks, I'll remember that and either update the patch or send a small
incremental one later.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
