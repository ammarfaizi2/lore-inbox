Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWEAOVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWEAOVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 10:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWEAOVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 10:21:41 -0400
Received: from wproxy.gmail.com ([64.233.184.233]:3937 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932107AbWEAOVk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 10:21:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GJxvIn2S8/WwjAifmVN/X8g5gwtPyzc8LErmN/eFityN8uBaC79wMZrOHDl9PJa7dKfPgnpo7AvOIF6HsWOs4qxJHzKAtCwNlwdimhJt2ISzC8JzeGTBWv29XkkDKuuQW5t3KLCt2R7+zw3DNG09A1rRnKNNxnxEYlEUSvvQnTI=
Message-ID: <9a8748490605010721t6d41ca01k8a715eaeef5fd948@mail.gmail.com>
Date: Mon, 1 May 2006 16:21:35 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Willy Tarreau" <willy@w.ods.org>
Subject: Re: [PATCH/RFC] Requested changelog for minix filesystem update to V3
Cc: "=?ISO-8859-1?Q?Daniel_Aragon=E9s?=" <danarag@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Pekka Enberg" <penberg@cs.helsinki.fi>,
       "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060501134338.GA11191@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4455D3F1.7000102@gmail.com>
	 <9a8748490605010606j70a25cdcqe23b1c0684a1f710@mail.gmail.com>
	 <20060501134338.GA11191@w.ods.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/06, Willy Tarreau <willy@w.ods.org> wrote:
> Hi Jesper,
>
> just a comment below :
>
> On Mon, May 01, 2006 at 03:06:49PM +0200, Jesper Juhl wrote:
> > On 5/1/06, Daniel Aragonés <danarag@gmail.com> wrote:
> [snip]
>
> > >-       i = ((numbits-(numblocks-1)*BLOCK_SIZE*8)/16)*2;
> > >+       i = ((numbits-(numblocks-1)*bh->b_size*8)/16)*2;
> >
> > A few more spaces please :
> >
> >  i = ((numbits-(numblocks-1) * bh->b_size * 8) / 16) * 2;
>
> This spacing is still wrong, because I first read it like this :
>
>   i = (((numbits-(numblocks-1)) * bh->b_size * 8) / 16) * 2;
>
> While in fact it's :
>
>   i = ((numbits-((numblocks-1) * bh->b_size * 8)) / 16) * 2;
>
> Strictly speaking, this should be written this way :
>
>   i = ((numbits - (numblocks - 1) * bh->b_size * 8) / 16) * 2;
>

You are right, I botched that one.


> Or at least :
>
>   i = ((numbits - (numblocks-1) * bh->b_size * 8) / 16) * 2;
>
> Anyway, it's a good sign when only spaces are being discussed on a piece
> of code ;-)
>
> Cheers,
> Willy
>
>

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
