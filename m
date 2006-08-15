Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWHOMCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWHOMCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 08:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWHOMCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 08:02:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:41310 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750803AbWHOMCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 08:02:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C+kYzUwjhq9W8bxn1mRjYxCNEil2daWwZL4VHlv0+E8wWFmkyreQ5FpT6HEQgtEIpDXNfV2xFkD5ct6poiE1v1sUGWXJ77JMeDHT4gfro/ivNv2lBWvwQO003nryjnl+Q90zOM4pHmF3fLf+6Y8KQ+wyriyi1HPQ9Rg5O8ZjmIY=
Message-ID: <9a8748490608150502g30c2e566g7301ca5cc50778ce@mail.gmail.com>
Date: Tue, 15 Aug 2006 14:02:50 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: locks_insert_block: removing duplicated lock (pid=2711 0-9223372036854775807 type=1)
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       "Trond Myklebust" <Trond.Myklebust@netapp.com>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <9a8748490608150458t53da165cvca0f6bf71c25ed63@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490608100502wd9a097cwab80c662300020e8@mail.gmail.com>
	 <9a8748490608150458t53da165cvca0f6bf71c25ed63@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 10/08/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > I've got a server running 2.6.11.11 that just reported the following in dmesg :
> >
> > locks_insert_block: removing duplicated lock (pid=2711
> > 0-9223372036854775807 type=1)
> >
> Still getting lots of these :
>
> Aug 15 13:53:01 server kernel: locks_insert_block: removing duplicated
> lock (pid=3 0-9223372036854775807 type=1)
> Aug 12 22:46:31 server kernel: locks_insert_block: removing duplicated
> lock (pid=1036 0-9223372036854775807 type=1)
> Aug 12 00:21:28 server kernel: locks_insert_block: removing duplicated
> lock (pid=1020 0-9223372036854775807 type=1)
>
> What's the exact meaning of this?
> > Should I worry?
> > Any info I can provide that would be useful?
>

I guess I should add a few people who might know something to Cc:
instead of only sending to LKML ;-)

The server that generates these log messages is serving up a few
terrabytes of data via NFS to some tens of clients - in case that's
relevant.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
