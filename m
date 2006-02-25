Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbWBYMcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWBYMcU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 07:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbWBYMcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 07:32:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932690AbWBYMcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 07:32:19 -0500
Date: Sat, 25 Feb 2006 04:31:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, info-linux@geode.amd.com
Subject: Re: 2.6.16-rc4-mm2
Message-Id: <20060225043102.73d1a7d8.akpm@osdl.org>
In-Reply-To: <9a8748490602250425m6d99cd54la451795648c31c42@mail.gmail.com>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
	<9a8748490602250359w7880d820lae65ceb50bf6e08e@mail.gmail.com>
	<20060225041703.6d771f10.akpm@osdl.org>
	<9a8748490602250425m6d99cd54la451795648c31c42@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> On 2/25/06, Andrew Morton <akpm@osdl.org> wrote:
>  > "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>  > >
>  > >  On 2/24/06, Andrew Morton <akpm@osdl.org> wrote:
>  > >  >
>  > >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/
>  > >  >
>  > >
>  > >  Geode video breaks the build :
>  > >
>  > >    LD      init/built-in.o
>  > >    LD      .tmp_vmlinux1
>  > >  drivers/built-in.o(.text+0x133f6): In function `gxfb_set_par':
>  > >  : undefined reference to `fb_dealloc_cmap'
>  > >  drivers/built-in.o(.text+0x13432): In function `gxfb_set_par':
>  > >  : undefined reference to `fb_alloc_cmap'
>  >
>  > How'd you manage that?  Those things are dragged in via CONFIG_FB.
>  >
>  with "make randconfig" - the config it generated for me (and which
>  broke) is attached.

CONFIG_FB=m, CONFIG_FB_GEODE_GX=y.   An easy mistake, that.
