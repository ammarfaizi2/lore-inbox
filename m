Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWAEMjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWAEMjz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWAEMjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:39:55 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:17200 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751297AbWAEMjy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:39:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MjscWpCZ/TKUyAEkQlsEnP0AWBzWdvmBvlr4F45a1bWBUnvgJBC3MTHiydyYTmm0QjnW3dozy9XRy/SqWOU818d13vdO1AVcMrit6kH5+aXmMon7DeC5t7tVl8nxd1/eHu7IMSnKH8p9J/evPzMyMKryFXsLRToF9TR2GHDANCM=
Message-ID: <df33fe7c0601050439o7d2ae3b3k@mail.gmail.com>
Date: Thu, 5 Jan 2006 13:39:43 +0100
From: Takis <panagiotis.issaris@gmail.com>
Reply-To: takis@issaris.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] drivers/media: Conversions from kmalloc+memset to kzalloc.
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <84144f020601050423j19b73446l143162a9ef6067b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105104332.3E5CC6ADE@localhost.localdomain>
	 <84144f020601050423j19b73446l143162a9ef6067b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2006/1/5, Pekka Enberg <penberg@cs.helsinki.fi>:
> On 1/5/06, Panagiotis Issaris <takis@issaris.org> wrote:
> > 993e5ce2979baa3df3d8dd238d74ea3b607e4693
> > diff --git a/drivers/media/common/saa7146_core.c b/drivers/media/common/saa7146_core.c
> > index 2899d34..38982a7 100644
> > --- a/drivers/media/common/saa7146_core.c
> > +++ b/drivers/media/common/saa7146_core.c
> > @@ -109,10 +109,9 @@ static struct scatterlist* vmalloc_to_sg
> >         struct page *pg;
> >         int i;
> >
> > -       sglist = kmalloc(sizeof(struct scatterlist)*nr_pages, GFP_KERNEL);
> > +       sglist = kzalloc(sizeof(struct scatterlist)*nr_pages, GFP_KERNEL);
>
> Hmm, these should be converted to kcalloc().
Oops... you're right. I'll send an updated patch later this evening.

With friendly regards,
Takis
