Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWHGWXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWHGWXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWHGWXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:23:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932280AbWHGWXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:23:44 -0400
Date: Mon, 7 Aug 2006 15:23:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: arm + sh cross compile suite for amd64 (i386)?
Message-Id: <20060807152338.1307e631.akpm@osdl.org>
In-Reply-To: <20060807210625.GB14327@mars.ravnborg.org>
References: <20060807192708.GA12937@mars.ravnborg.org>
	<20060807204241.GA11510@kroah.com>
	<20060807210209.GA14327@mars.ravnborg.org>
	<20060807210625.GB14327@mars.ravnborg.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 23:06:25 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Mon, Aug 07, 2006 at 11:02:09PM +0200, Sam Ravnborg wrote:
>  
> > So for sh I would expect the following is a better fix:
> 
> Reminds me. Anyone has a pointer to arm+sh gcc + binutils cross-compile
> suite that can run on my amd64 box?
> My usual source: http://developer.osdl.org/dev/plm/cross_compile/
> did have neither sh nor arm :-(
> 

I was somewhat-successful in building those up.  From my notes:

arm:
	eval `cat arm.dat gcc-3.4.5-glibc-2.3.6.dat` sh all.sh --notest

sh4:
	eval `cat sh4.dat gcc-3.4.5-glibc-2.3.6.dat` sh all.sh --notest

when you've struggled with crosstool for long enough, that'll become
meaningful ;)


fwiw, I've uploaded x86 binaries to http://userweb.kernel.org/~akpm/. 
They're a bit flakey but seem to be good enough to get through a defconfig
build.  The main problem is fancy machine-specific binutils options which
are present in the kernel Makefiles but which stock binutils doesn't know
about.


