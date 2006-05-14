Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWENKmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWENKmZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 06:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWENKmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 06:42:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:35256 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932419AbWENKmZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 06:42:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LSp9OihtvgojUvBnvlYKDBy1T9ZNt/wrlSJ/92ZPrT88VfdZnHgzGubtJ1IFhYdKGMf/Eu9XBo4xggApRDwO2M4rg6weQ5cpa+TwRxX6m4x+JsU+em1Mq6nPvOJ2rF6uf8bts00gBdT8WCjP2HOUM/7d3dtEWSHNMg+Q7cDQ0P4=
Message-ID: <9a8748490605140342t7fc9acb7n77dbccb2a96e09e4@mail.gmail.com>
Date: Sun, 14 May 2006 12:42:24 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH][resend] fix resource leak in pnp card_probe()
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com
In-Reply-To: <20060514023833.649fde1d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605132235.42338.jesper.juhl@gmail.com>
	 <20060514023833.649fde1d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/06, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > (resend of patch already send once on 23/03-2006
> >   - still applies cleanly to latest -git)
> >
> >
> > We can leak `clink' in drivers/pnp/card.c::card_probe()
> >
[snip]
>
> If !drv->probe then there's not much point in doing the kmalloc and then
> immediately freeing it again.
>
True. It was simply the simplest and least intrusive fix I could make.

> Like this?
>
Looks good to me, thanks.

[snip neater version of fix]


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
