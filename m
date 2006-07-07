Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWGGHvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWGGHvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWGGHvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:51:13 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:31799 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750953AbWGGHvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:51:12 -0400
Date: Fri, 7 Jul 2006 09:49:18 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@stusta.de>, kai@germaschewski.name,
       linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20060707074918.GB9480@osiris.boeblingen.de.ibm.com>
References: <20060706163728.GN26941@stusta.de> <20060707033630.GA15967@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707033630.GA15967@mars.ravnborg.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Currently, using an undeclared function gives a compile warning, but it 
> > can lead to a nasty to debug runtime stack corruptions if the prototype 
> > of the function is different from what gcc guessed.
> > 
> > With -Werror-implicit-function-declaration we are getting an immediate
> > compile error instead.
> This patch broke (-rc1):
> 
> sparc allnoconfig build
> ia64 allnoconfig build
> ppc64 allnoconfig build
> 
> x86_64 succeded an allnoconfig build
> 
> I did not try other architectures. We need to fix the allnoconfig cases
> at least for the popular architectures before applying this patch
> otherwise it will create too much trouble/noise.

s390 builds with defconfig and allnoconfig and a few other variants as well.
