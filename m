Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbVJEXlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbVJEXlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbVJEXlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:41:55 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:30033 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030443AbVJEXly convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:41:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jtu2jWJm/6gipbTJA0bQDBWlUnJFxGm0vAOiKSEM9ANlKoJLdsi7X95qSWqQsYCc7qVyC6gyBK8ZgaJT79N74oNyZ8mwGgvqsRdvL5Kfsmw9XGede+XghL4Zl/OeE16opblXddVKrf0TAhvzpoX0Xge0/dZVBEcbh94nH01aAXY=
Message-ID: <9a8748490510051641m11f554efn5ef13e4fdecbc442@mail.gmail.com>
Date: Thu, 6 Oct 2005 01:41:53 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Arthur Othieno <a.othieno@bluewin.ch>
Subject: Re: [PATCH] small cleanup for kernel/printk.c - CodingStyle, Whitespace, printk() loglevels...
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051005220900.GA2559@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510052356.49823.jesper.juhl@gmail.com>
	 <20051005220900.GA2559@mars>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Arthur Othieno <a.othieno@bluewin.ch> wrote:
> On Wed, Oct 05, 2005 at 11:56:49PM +0200, Jesper Juhl wrote:
> > Small CodingStyle cleanup for kernel/printk.c
> >   Removes some trailing whitespace
> >   Breaks long lines and make other small changes to conform to CodingStyle
> >   Add explicit printk loglevels in two places.
> >
> > Linus: Sorry to Cc: you on something as trivial as this, but you /are/ listed as
> > the author of the file and I couldn't find a relevant maintainer (except for
> > perhaps Andrew (so I added him to CC as well)).
> >
> >
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> > ---
> >
> > Patch has been compile tested.
> >
> >  kernel/printk.c |   78 ++++++++++++++++++++++++++++++--------------------------
> >  1 files changed, 42 insertions(+), 36 deletions(-)
> >
> > --- linux-2.6.14-rc3-git5-orig/kernel/printk.c        2005-10-03 21:55:39.000000000 +0200
> > +++ linux-2.6.14-rc3-git5/kernel/printk.c     2005-10-05 23:46:54.000000000 +0200
> > @@ -169,11 +169,11 @@ static int __init log_buf_len_setup(char
> >               size = roundup_pow_of_two(size);
> >       if (size > log_buf_len) {
> >               unsigned long start, dest_idx, offset;
> > -             char * new_log_buf;
> > +             char *new_log_buf;
> >
> >               new_log_buf = alloc_bootmem(size);
> >               if (!new_log_buf) {
> > -                     printk("log_buf_len: allocation failed\n");
> > +                     printk(KERN_WARNING "log_buf_len: allocation failed\n");
>
> Wouldn't KERN_ERR be more appropriate here?

I don't think so. Things will still work.
Personally I consider this a warning condition, and without an
explicit loglevel that's also what it was logged as in the past, so
this changes nothing.
If other people disagree I can modify the patch, sure, but I think
KERN_WARNING is appropriate.

[snip]
> > -        struct console *a,*b;
> > +        struct console *a, *b;
> >       int res = 1;
>
> Beep! :)
>
huh?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
