Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVCKSbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVCKSbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVCKS3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:29:08 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:3668 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261242AbVCKSNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:13:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hJcIwy2kGG2QIWVT9V9SuI1mNdDQ8jFzSLzzB07KmquGBLLfoAfXURIgx09/N0uvowY2nOQzch4mx+RJjgCeudoN4asS8ZRjsX3hPADxeuiENr2VChY6SXpsxF1MXhQQBI2j/IIR6NCTM12OzU6qhuzpIGz/h7oTWLOMHLY75AY=
Message-ID: <9e473391050311101356536667@mail.gmail.com>
Date: Fri, 11 Mar 2005 13:13:37 -0500
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
In-Reply-To: <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050308015731.GA26249@spock.one.pl>
	 <200503091301.15832.adaplas@hotpop.com>
	 <9e473391050308220218cc26a3@mail.gmail.com>
	 <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be>
	 <1110392212.3116.215.camel@localhost.localdomain>
	 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org>
	 <1110408049.9942.275.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>
	 <20050310145419.GD632@openzaurus.ucw.cz>
	 <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005 18:03:20 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> > > > Thats why moving the eye candy console into user space is such a good
> > > > idea. You don't have to run it 8) It also means that the console
> > > > development is accessible to all the crazy rasterman types.
> > >
> > > Yep. The basic console we already have. Everyone who wants eye candy can switch
> > > from basic console to user space console in early userspace.
> > >
> >
> > Heh, I'm afraid it does not work like that. Anyone who wants eye-candy
> > simply applies broken patch to their kernel... unless their distribution applied one
> > already.
> >
> > Situation where we have one working eye-candy patch would certainly
> > be an improvement.
> 
> Why do we need patches in the kernel. Just set you config to
> CONFIG_DUMMY_CONSOLE, CONFIG_FB, CONFIG_INPUT and don't set fbcon or
> vgacon. Then have a userspace app using /dev/fb and /dev/input create a
> userland console. There is no need to do special hacks in the kernel.

/dev/fb is not accelerated, if you want full acceleration use
/dev/dri. Using /dev/dri you can write a fully composited console that
displays dengavi in realtime. This is also a path to getting multiuser
working without a lot of kernel patches.

-- 
Jon Smirl
jonsmirl@gmail.com
