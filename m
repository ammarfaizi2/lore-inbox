Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWFSLIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWFSLIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 07:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWFSLIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 07:08:38 -0400
Received: from witte.sonytel.be ([80.88.33.193]:10986 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932371AbWFSLIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 07:08:37 -0400
Date: Mon, 19 Jun 2006 13:08:30 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Vivek Goyal <vgoyal@in.ibm.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 16/16] 64bit Resource: finally enable 64bit resource
 sizes
In-Reply-To: <Pine.LNX.4.64.0606191214320.12900@scrub.home>
Message-ID: <Pine.LNX.4.62.0606191308110.10350@pademelon.sonytel.be>
References: <11501587303683-git-send-email-greg@kroah.com>
 <11501587343689-git-send-email-greg@kroah.com>
 <Pine.LNX.4.62.0606141417430.1886@pademelon.sonytel.be> <20060614233507.GA23629@kroah.com>
 <20060615042806.GC8587@in.ibm.com> <Pine.LNX.4.62.0606151345420.21517@pademelon.sonytel.be>
 <20060615155643.GB8706@in.ibm.com> <20060616013543.GB2566@kroah.com>
 <20060616201605.GA27462@in.ibm.com> <Pine.LNX.4.62.0606171633190.24519@pademelon.sonytel.be>
 <20060618180547.GA14049@in.ibm.com> <Pine.LNX.4.62.0606191003230.6499@pademelon.sonytel.be>
 <Pine.LNX.4.64.0606191214320.12900@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Roman Zippel wrote:
> On Mon, 19 Jun 2006, Geert Uytterhoeven wrote:
> 
> > > --- linux-2.6.17-rc6-1M/mm/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
> > > +++ linux-2.6.17-rc6-1M-vivek/mm/Kconfig	2006-06-18 13:35:13.000000000 -0400
> > > @@ -145,3 +145,12 @@ config MIGRATION
> > >  	  while the virtual addresses are not changed. This is useful for
> > >  	  example on NUMA systems to put pages nearer to the processors accessing
> > >  	  the page.
> > > +
> > > +config RESOURCES_64BIT
> > > +	bool "64 bit Memory and IO resources (EXPERIMENTAL)"
> > > +	depends on (EXPERIMENTAL && !64BIT) || 64BIT
> > > +	default y if 64BIT
> > 
> > it defaults to y if 64BIT. Roman?
> 
> This should do it:
> 
> config RESOURCES_64BIT
> 	bool "64 bit Memory and IO resources (EXPERIMENTAL)" if !64BIT && EXPERIMENTAL
> 	default 64BIT
               ^
Missing `y if'?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
