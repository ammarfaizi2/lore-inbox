Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVHRLqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVHRLqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 07:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVHRLqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 07:46:10 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:48953 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932206AbVHRLqG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 07:46:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e7ahHDQp4m5VQY0e/vXNyx3fF59N6EODL9i836MtMpVIDcl0MgBmKo419pqwQTi8OFgN8QXhPS8IoCyEJPi7fcvpVJx9uoYXaOEuX260orUVDNpgq2EjmVT1Gue/9rktINQFqpY22xFPTZzQLzVutYon87Fs8wnudRoq8rrTI7M=
Message-ID: <9a87484905081804464a8e24b7@mail.gmail.com>
Date: Thu, 18 Aug 2005 13:46:05 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/7] rename locking functions - convert sema_init users
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050818031039.545dd53e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508180204.33470.jesper.juhl@gmail.com>
	 <20050818031039.545dd53e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/05, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > --- linux-2.6.13-rc6-git9-orig/fs/xfs/linux-2.6/sema.h        2005-06-17 21:48:29.000000000 +0200
> >  +++ linux-2.6.13-rc6-git9/fs/xfs/linux-2.6/sema.h    2005-08-18 00:46:41.000000000 +0200
> >  @@ -43,9 +43,9 @@
> >
> >   typedef struct semaphore sema_t;
> >
> >  -#define init_sema(sp, val, c, d)    sema_init(sp, val)
> >  -#define initsema(sp, val)           sema_init(sp, val)
> >  -#define initnsema(sp, val, name)    sema_init(sp, val)
> >  +#define init_sema(sp, val, c, d)    init_sema(sp, val)
> >  +#define initsema(sp, val)           init_sema(sp, val)
> >  +#define initnsema(sp, val, name)    init_sema(sp, val)
> 
> Well that's pretty nonsensical.  I'll drop the patches - please don't send
> things which haven't been compiled.
> 

I did build a kernel for my own box with all the patches applied, but
it must obviously have not included this bit. Sorry about that. I'll
be more thorough next time.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
