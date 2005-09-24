Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVIXTPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVIXTPj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 15:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVIXTPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 15:15:39 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:62302 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750750AbVIXTPj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 15:15:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oh+qc7841HUE2qnAwfYR7RF7z43daCOf/hPnYoLRkABU/ngRmVYMw02nVE4uZXdm7Wq9nslNZn6QjzmwSmiGo1/Fe/CBz74s2WMegL9VQbcHsGWDdwlxuV4/AKsbOXxXX3PpZfUlE03ov5q/CyfOVW7LgsdNH+rzCXbc8Mt4nWo=
Message-ID: <9a874849050924121513b7a85d@mail.gmail.com>
Date: Sat, 24 Sep 2005 21:15:35 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] Unify sys_tkill() and sys_tgkill()
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050924163818.GA7339@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0509231913550.5348@shell3.speakeasy.net>
	 <9a8748490509240752436ef7b2@mail.gmail.com>
	 <20050924163818.GA7339@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/05, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> On Sat, 24 September 2005 16:52:28 +0200, Jesper Juhl wrote:
> >
> > [snip]
> > > +static int do_tkill(int tgid, int pid, int sig)
> >
> > I would probably have made this
> >
> >   static inline int do_tkill(int tgid, int pid, int sig)
>
> Why?  It would only return the original duplication in binary form and
> save a minimal amount of time for something already slow - a system
> call.  With small caches, the code duplication could even waste more
> performance than the missing function call would gain you.
>
You are right, I didn't think that through properly.
Thank you for catching that.

> Other nits were well-picked.
>
Thanks.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
