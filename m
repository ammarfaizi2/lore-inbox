Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVH3QiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVH3QiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVH3QiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:38:25 -0400
Received: from ns2.suse.de ([195.135.220.15]:20203 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932208AbVH3QiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:38:24 -0400
Date: Tue, 30 Aug 2005 18:38:19 +0200
From: Olaf Hering <olh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20050830163819.GA32201@suse.de>
References: <20050830145444.GC3708@stusta.de> <20050830161814.GA31940@suse.de> <20050830162944.GB7071@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050830162944.GB7071@stusta.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Aug 30, Adrian Bunk wrote:

> On Tue, Aug 30, 2005 at 06:18:14PM +0200, Olaf Hering wrote:
> >  On Tue, Aug 30, Adrian Bunk wrote:
> > 
> > > Currently, using an undeclared function gives a compile warning, but it 
> > > can lead to a link or even a runtime error.
> > > 
> > > With -Werror-implicit-function-declaration, we are getting an immediate 
> > > compile error instead.
> > 
> > You have to fix CONFIG_SWAP=n as well.
> > 
> > http://lkml.org/lkml/2005/8/6/72
> 
> I don't see any such warning in the 2.6.13 sparc build at Jan's 
> crosscompile page [1], and all my patch does is to turn a warning into 
> an error.

page_cache_release and release_pages will be undefined when compiling
arch/ppc/configs/common_defconfig, but not arch/i386/defconfig, with
CONFIG_SWAP=n
