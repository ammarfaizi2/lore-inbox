Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbWB1UsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWB1UsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWB1UsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:48:15 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:11379 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932579AbWB1UsN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:48:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nzm/yw/2Sede1DcANIuvZK2vanNIT5cGGR/oU14zGccx3qkNFyxQERo5F07TRdms4dUvzKlUxqz5z5hZkGXY/siBujOUqYXdjVquK6jbdR28b4IRW2zO/nNqCKBQd5oYwOCbD3q5G9aPCh/9/rHSUAYFGY3bhj1/EVQooJJ7fiI=
Message-ID: <9a8748490602281248p6877478sa17f25dafe019d4e@mail.gmail.com>
Date: Tue, 28 Feb 2006 21:48:12 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: Christian <christiand59@web.de>
Subject: Re: Odd sched behaviour; It takes 5 threads or more to load 2 CPU cores during kernel build
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200602282121.11863.christiand59@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490602281159u58df3397g1b6b268787146448@mail.gmail.com>
	 <200602282121.11863.christiand59@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/06, Christian <christiand59@web.de> wrote:
> Am Dienstag, 28. Februar 2006 20:59 schrieb Jesper Juhl:
[snip]
> >
> > Do we have a scheduler problem?
> > An io-scheduler problem?
>
> I'm not really into this, but what happens if you simply start 5 different
> kernel-builds in parallel? I think if it makes a difference then this would
> mean that there's something wrong with make and you could eliminate the first
> two possibilities?!
>

Well, no need for 5 kernel builds in that case.
If I clone my source tree and then simply run
 $ make distclean ; make allnoconfig ; nice make
in each directory in two different shells at the same time, then both
cores get fully loaded.


> > Is it "make" that's being difficult?
> > Is it something in the kernels Makefile that causes the build to
> > behave this way?
> > Could it be a bottleneck in my system somewhere?
> >
> > Anyone got a clue?
> >


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
