Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSFCOzn>; Mon, 3 Jun 2002 10:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSFCOzm>; Mon, 3 Jun 2002 10:55:42 -0400
Received: from dsl-213-023-039-253.arcor-ip.net ([213.23.39.253]:30114 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317385AbSFCOzl>;
	Mon, 3 Jun 2002 10:55:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: If you want kbuild 2.5, tell Linus
Date: Mon, 3 Jun 2002 16:54:41 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3434.1023112731@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17EtEH-0000vY-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 June 2002 15:58, Keith Owens wrote:
> Q07.  Why is [b]zImage part of the config?
> A07.  In the current system, installation is a poor relation of the
>       build system.  Each architecture has their own install targets
>       with their own special rules.  None of the install targets check
>       that what is being installed was built correctly.
> 
>       In kbuild 2.5 the install target is a fully supported part of the
>       build.  Not only is [b]zImage (and all the other targets) part of
>       the config, the config also supports installation to somewhere
>       other than /, plus optional rules for installing the config and
>       System.map at the same time as the kernel and modules.  This
>       significantly improves support for cross compilation.
> 
>       A nice side effect of putting all the install information in
>       .config is that building a new kernel is as simple as
> 
>         cp previous_config .config
>         make ... defconfig installable && sudo make install

That simplification is appreciated, but I think that

   make -f Makefile-2.5 bzImage

should still be allowed, call it compatibility glue if you like.

For what it's worth, I find it quite natural to have the build
information in the .config and I was able to find my way to it
without reading the docs.  Still - when Makefile-2.5 becomes just
plain Makefile, a lot of fingers are still going to want to type
"make bzImage".

-- 
Daniel
