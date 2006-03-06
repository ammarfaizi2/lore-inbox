Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWCFWNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWCFWNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWCFWNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:13:38 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:64373 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932395AbWCFWNh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:13:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o4z12cK8F6JAAHm/AwcipXMeb/YEcFaFdqmj90EjUb85B3QknsqOR/uNl3WNVfl848TQTxJY5W0ajI9bJZir9II9QrcrLGvk9ARq8WNzJwcSr7fa6UM6Nf4OFzItjA+pU216osKn3klkPhEGcsXFB1PzCQieIQEqh3p4wUhbDQE=
Message-ID: <9a8748490603061413s3a27c932qfbf2b89c811ca491@mail.gmail.com>
Date: Mon, 6 Mar 2006 23:13:36 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: initcall at ... returned with error code -19 (Was: Re: 2.6.16-rc5-mm2)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060306140851.4140ae2b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490603061359r64655a45i9a26e1f92009c7bf@mail.gmail.com>
	 <20060306140851.4140ae2b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Andrew Morton <akpm@osdl.org> wrote:
> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> >
> > On 3/3/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/
> > >
> >
> > With this kernel I sometimes get :
> >   initcall at 0xc0432790: rng_init+0x0/0xa0(): returned with error code -19
> > and sometimes :
> >   initcall at 0xc0428240: init_hpet_clocksource+0x0/0x90(): returned
> > with error code -19
> >
> > I haven't paid enough attention to be able to say if some boots had
> > other variations, but at least the two above have been observed.
> >
>
> That's OK - it's -ENODEV.  It's saying "hey, you linked this driver into
> vmlinux but it didn't find any hardware to drive".
>

Hmm, then perhaps we should make the warnings print some slightly less
"bad things happening" looking string...
As it is it looks very much like something bad is going on, so I
predict it will generate a lot of bug reports in the future if left in
its current form.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
