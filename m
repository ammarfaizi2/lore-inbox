Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWAKWtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWAKWtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWAKWtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:49:23 -0500
Received: from smtp3.brturbo.com.br ([200.199.201.164]:23173 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932488AbWAKWtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:49:22 -0500
Subject: Re: 2.6.15-mm3, current -git: drivers/media/video/ compile errors
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Adrian Bunk <bunk@stusta.de>
Cc: Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Giacomo A. Catenazzi" <cate@debian.org>,
       "David S. Miller" <davem@davemloft.net>, video4linux-list@redhat.com
In-Reply-To: <20060111222202.GG29663@stusta.de>
References: <20060111042135.24faf878.akpm@osdl.org>
	 <200601111721.23598.dominik.karall@gmx.net>
	 <20060111222202.GG29663@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 11 Jan 2006 20:48:58 -0200
Message-Id: <1137019739.24771.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

	Sorry for that. It is already fixed on v4l-dvb.git tree (branch new).
I'm just testing make allyesconfig right now.

Cheers
Mauro

Em Qua, 2006-01-11 às 23:22 +0100, Adrian Bunk escreveu:
> On Wed, Jan 11, 2006 at 05:21:23PM +0100, Dominik Karall wrote:
> > 
> > hi!
> > it doesn't compile here.
> > 
> >   CC      drivers/media/video/tveeprom.o
> >   LD      drivers/media/video/built-in.o
> > drivers/media/video/tuner.o:(.bss+0x0): multiple definition of `debug'
> > drivers/media/video/msp3400.o:(.bss+0xc): first defined here
> > make[3]: *** [drivers/media/video/built-in.o] Fehler 1
> >...
> 
> I'm getting even one more error:
> 
> <--  snip  -->
> 
> ...
> drivers/media/video/tuner.o:(.bss+0x0): multiple definition of `debug'
> drivers/media/video/msp3400.o:(.bss+0xc): first defined here
> drivers/media/video/cx25840/built-in.o:(.bss+0x0): multiple definition of `debug'
> drivers/media/video/msp3400.o:(.bss+0xc): first defined here
> make[3]: *** [drivers/media/video/built-in.o] Error 1
> 
> <--  snip  -->
> 
> There's sometime a need for variables being global being visible in 
> all objects of a module.
> 
> That's OK.
> 
> But they should never have generic names like "debug" or "once" (the 
> latter and some similar ones don't seem to cause compile errors since 
> they are currently used only once, but they are equally wrong.
> 
> > greets,
> > dominik
> 
> cu
> Adrian
> 
Cheers, 
Mauro.

