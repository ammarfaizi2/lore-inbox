Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWBYL7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWBYL7e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 06:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWBYL7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 06:59:34 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:46195 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932186AbWBYL7e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 06:59:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I+KjL6bK3sPA+XpvN5A9SCG5RNvzrVav8NcmgdcdfYrr8pe8ovnYyxgo5zzoSI+hvdiyj2BEr6Qs1r3QhIzFIQb9zK0p0uWAwB5d7WFA/S5fyuGqv0Av62ddDUjKqfsGtmf5qZ0XdfZEphwPbsorEs5kQucuiRokQgNn/j7YxUs=
Message-ID: <9a8748490602250359w7880d820lae65ceb50bf6e08e@mail.gmail.com>
Date: Sat, 25 Feb 2006 12:59:33 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.16-rc4-mm2
Cc: linux-kernel@vger.kernel.org, info-linux@geode.amd.com
In-Reply-To: <20060224031002.0f7ff92a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060224031002.0f7ff92a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/
>

Geode video breaks the build :

  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x133f6): In function `gxfb_set_par':
: undefined reference to `fb_dealloc_cmap'
drivers/built-in.o(.text+0x13432): In function `gxfb_set_par':
: undefined reference to `fb_alloc_cmap'
drivers/built-in.o(.text+0x1359e): In function `gxfb_remove':
: undefined reference to `unregister_framebuffer'
drivers/built-in.o(.text+0x135f5): In function `gxfb_remove':
: undefined reference to `framebuffer_release'
drivers/built-in.o(.init.text+0x168e): In function `gxfb_init_fbinfo':
: undefined reference to `framebuffer_alloc'
drivers/built-in.o(.init.text+0x17b8): In function `gxfb_probe':
: undefined reference to `fb_find_mode'
drivers/built-in.o(.init.text+0x180f): In function `gxfb_probe':
: undefined reference to `register_framebuffer'
drivers/built-in.o(.init.text+0x189e): In function `gxfb_probe':
: undefined reference to `framebuffer_release'
drivers/built-in.o(.init.text+0x192b): In function `gxfb_init':
: undefined reference to `fb_get_options'
make: *** [.tmp_vmlinux1] Error 1


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
