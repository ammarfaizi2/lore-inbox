Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWEANoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWEANoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWEANoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:44:08 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:47889 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932099AbWEANoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:44:07 -0400
Date: Mon, 1 May 2006 15:43:38 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Daniel =?iso-8859-1?Q?Aragon=E9s?= <danarag@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Requested changelog for minix filesystem update to V3
Message-ID: <20060501134338.GA11191@w.ods.org>
References: <4455D3F1.7000102@gmail.com> <9a8748490605010606j70a25cdcqe23b1c0684a1f710@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a8748490605010606j70a25cdcqe23b1c0684a1f710@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper,

just a comment below :

On Mon, May 01, 2006 at 03:06:49PM +0200, Jesper Juhl wrote:
> On 5/1/06, Daniel Aragonés <danarag@gmail.com> wrote:
[snip]

> >-       i = ((numbits-(numblocks-1)*BLOCK_SIZE*8)/16)*2;
> >+       i = ((numbits-(numblocks-1)*bh->b_size*8)/16)*2;
> 
> A few more spaces please :
> 
>  i = ((numbits-(numblocks-1) * bh->b_size * 8) / 16) * 2;

This spacing is still wrong, because I first read it like this :

  i = (((numbits-(numblocks-1)) * bh->b_size * 8) / 16) * 2;

While in fact it's :

  i = ((numbits-((numblocks-1) * bh->b_size * 8)) / 16) * 2;

Strictly speaking, this should be written this way :

  i = ((numbits - (numblocks - 1) * bh->b_size * 8) / 16) * 2;

Or at least :

  i = ((numbits - (numblocks-1) * bh->b_size * 8) / 16) * 2;

Anyway, it's a good sign when only spaces are being discussed on a piece
of code ;-)

Cheers,
Willy

