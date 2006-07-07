Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWGGJeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWGGJeB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWGGJeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:34:01 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:4533 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932088AbWGGJeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:34:00 -0400
Date: Fri, 7 Jul 2006 11:33:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>, kai@germaschewski.name,
       linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20060707093331.GA25846@mars.ravnborg.org>
References: <20060706163728.GN26941@stusta.de> <20060707033630.GA15967@mars.ravnborg.org> <20060707074918.GB9480@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707074918.GB9480@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 09:49:18AM +0200, Heiko Carstens wrote:
> > > Currently, using an undeclared function gives a compile warning, but it 
> > > can lead to a nasty to debug runtime stack corruptions if the prototype 
> > > of the function is different from what gcc guessed.
> > > 
> > > With -Werror-implicit-function-declaration we are getting an immediate
> > > compile error instead.
> > This patch broke (-rc1):
> > 
> > sparc allnoconfig build
> > ia64 allnoconfig build
> > ppc64 allnoconfig build
> > 
> > x86_64 succeded an allnoconfig build
> > 
> > I did not try other architectures. We need to fix the allnoconfig cases
> > at least for the popular architectures before applying this patch
> > otherwise it will create too much trouble/noise.
> 
> s390 builds with defconfig and allnoconfig and a few other variants as well.
Thanks for testing.

	Sam
