Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbWBYMlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWBYMlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 07:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWBYMlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 07:41:15 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:10954 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932695AbWBYMlP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 07:41:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oIQiJp4/LlWsWZgEqZ8zKf/WWb/CGw0nYk+UiWDm0XyYit12ikZJ/qdPyobbE2gJU/COg/zPEJM4BRJHjHws/s1bUslUoYcP400zlLyCOZ3fvR4+3G3DuiQYnQodEP5PnBkD/qRL8o0FjduGRWlTYd/QftqlQaH9oPvK5IXkznA=
Message-ID: <9a8748490602250441h710fd194u420ffbac58d7a18d@mail.gmail.com>
Date: Sat, 25 Feb 2006 13:41:12 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.16-rc4-mm2
Cc: linux-kernel@vger.kernel.org, info-linux@geode.amd.com
In-Reply-To: <20060225043102.73d1a7d8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060224031002.0f7ff92a.akpm@osdl.org>
	 <9a8748490602250359w7880d820lae65ceb50bf6e08e@mail.gmail.com>
	 <20060225041703.6d771f10.akpm@osdl.org>
	 <9a8748490602250425m6d99cd54la451795648c31c42@mail.gmail.com>
	 <20060225043102.73d1a7d8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, Andrew Morton <akpm@osdl.org> wrote:
> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> >
> > On 2/25/06, Andrew Morton <akpm@osdl.org> wrote:
> >  > "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> >  > >
> >  > >  On 2/24/06, Andrew Morton <akpm@osdl.org> wrote:
> >  > >  >
> >  > >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/
> >  > >  >
> >  > >
> >  > >  Geode video breaks the build :
> >  > >
> >  > >    LD      init/built-in.o
> >  > >    LD      .tmp_vmlinux1
> >  > >  drivers/built-in.o(.text+0x133f6): In function `gxfb_set_par':
> >  > >  : undefined reference to `fb_dealloc_cmap'
> >  > >  drivers/built-in.o(.text+0x13432): In function `gxfb_set_par':
> >  > >  : undefined reference to `fb_alloc_cmap'
> >  >
> >  > How'd you manage that?  Those things are dragged in via CONFIG_FB.
> >  >
> >  with "make randconfig" - the config it generated for me (and which
> >  broke) is attached.
>
> CONFIG_FB=m, CONFIG_FB_GEODE_GX=y.   An easy mistake, that.
>

Does it even make sense to build CONFIG_FB modular?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
