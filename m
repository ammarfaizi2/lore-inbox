Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVCOTIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVCOTIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVCOTGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:06:16 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:56636 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261697AbVCOTEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:04:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UqeLkVY8UrDR59R+phykOuIr4LrVwE8/v89KHJROJ/+5RAIWHwMc4D4f70tTB7u32taUyVo+pSWtLwdiUyZc+qHaj02abRw8Zvot7ekAQagudAkjJ0Y5p8/dxKrMD2Ac+HnLl4/xLHBdyN5LYAYO7gpv70ypluCW1NxiXTdm+WE=
Message-ID: <9e4733910503151103b8a9c8f@mail.gmail.com>
Date: Tue, 15 Mar 2005 14:03:50 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer Splash
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
In-Reply-To: <Pine.LNX.4.56.0503151855430.5506@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050308015731.GA26249@spock.one.pl>
	 <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
	 <1110392212.3116.215.camel@localhost.localdomain>
	 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
	 <1110408049.9942.275.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>
	 <20050310145419.GD632@openzaurus.ucw.cz>
	 <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
	 <9e473391050311101356536667@mail.gmail.com>
	 <Pine.LNX.4.56.0503151855430.5506@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 18:58:08 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> 
> > > Why do we need patches in the kernel. Just set you config to
> > > CONFIG_DUMMY_CONSOLE, CONFIG_FB, CONFIG_INPUT and don't set fbcon or
> > > vgacon. Then have a userspace app using /dev/fb and /dev/input create a
> > > userland console. There is no need to do special hacks in the kernel.
> >
> > /dev/fb is not accelerated, if you want full acceleration use
> > /dev/dri. Using /dev/dri you can write a fully composited console that
> > displays dengavi in realtime. This is also a path to getting multiuser
> > working without a lot of kernel patches.
> 
> Not every device has a 3D core!!! DRM is not the answer for the entire graphics
> world. Its only for 3D functionality. If you want eye candy without 3D on small
> devices use fbdev.

DRM doesn't know a thing about 3D. All it does is DMA, memory
management and queue things up for the GPU to work on. You don't even
have to have a GPU processor you could use the CPU to execute the
commands.

It's the code up in mesa that knows about 3D and builds the commands
to be sent to DRM.


-- 
Jon Smirl
jonsmirl@gmail.com
