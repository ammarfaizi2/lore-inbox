Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWCTIBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWCTIBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWCTIBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:01:42 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:15573 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750733AbWCTIBm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:01:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D+CxX/0RC8oY0dCKdHuhuwOKkvssjMRxWcDBooJLLCwU3OHGV7vdO4gQ89guwejNoZGu1rT9qZ2D1lFxfhEKcsgNYIuf/wdbrpa9YmE9UQRQpzNl8v/ypUerX9TZNVZJK0RcfCUWQWSaTnrSnE8kPa4C0XPvBbEDRsNVO4fhw+I=
Message-ID: <9a8748490603200001m6fcfda52q9be3b8839d78fcd7@mail.gmail.com>
Date: Mon, 20 Mar 2006 09:01:41 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] fix potential null pointer deref in quota
Cc: linux-kernel@vger.kernel.org, jack@suse.cz
In-Reply-To: <20060319232327.005c91e4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603182308.05050.jesper.juhl@gmail.com>
	 <20060319232327.005c91e4.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/06, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > The coverity checker noticed that we may pass a NULL super_block to
> >  do_quotactl() that dereferences it.
> >  Dereferencing NULL pointers is bad medicine, better check and fail
> >  gracefully.
> >
[snip]
>
> I'd have thought that check_quotactl_valid() would be the appropriate place
> for this check.  Jan, can you please sort out what we need to do here?
>

You may well be right. I openly admit that this is the first time I've
ever stuck my head in the quota code. I picked the location I did
simply because I thought making the function resistant to being passed
invalid data was the sane thing to do, but there may well be a more
logical place to fix it.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
