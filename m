Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266144AbSKFVYU>; Wed, 6 Nov 2002 16:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266145AbSKFVYU>; Wed, 6 Nov 2002 16:24:20 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:7434 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266144AbSKFVYT>;
	Wed, 6 Nov 2002 16:24:19 -0500
Date: Wed, 6 Nov 2002 22:29:52 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: mec@shout.net, zippel@linux-m68k.org, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory .so
Message-ID: <20021106212952.GB1035@mars.ravnborg.org>
Mail-Followup-To: mec@shout.net, zippel@linux-m68k.org,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20021106185230.GD5219@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106185230.GD5219@pasky.ji.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 07:52:30PM +0100, Petr Baudis wrote:
>   Hello,
> 
>   this patch (against 2.5.46) introduces two special variables which make it
> actually possible to have .so as the only product of build in some directory
> and to link something against .so being built in another directory. The
> variable host-cshlib-extra makes it possible to explicitly mention shared
> objects to be built and the variable $(<foo>-linkobjs) allows user to specify
> additional objects to link <foo> against, while not creating any dependencies
> of <foo> on the objects.
> 
>   The changes are minimal while dramatically extending possibilities for
> messing with the shared objects and they should have no unwanted side-effects,
> and it appears to actually work for me. Please apply.

There is only one user of shared libaries today, thats Kconfig.
And Kconfig is the only user of C++ as well.

There is quite a lot of added complexity in Makefile.lib + Makefile.build
only to support this. Being the one that introduced it, I would like to
see it go away again.
Rationale behind this is that the current added complexity has an penalty
when compiling a kernel, and I would like to move the complexity to
the only user.

Care to try that approach?

	Sam
