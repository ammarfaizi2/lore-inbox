Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbVI3WRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbVI3WRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbVI3WRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:17:40 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:20838 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030474AbVI3WRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:17:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=SfBvEMpFfrPI/EKXRsfUs9UfpQDz5ns/G3qgQUBW8iYBzpiX+ObOJ5FXxhK4rOHMgX45W2VFulYNJGqXhyz+EBHbcqZQmJpg2BnamCKehLvbmJV9g69vjQO0f7Q0LNPfPl3rhJlMQ6vjlv6V9ZxcROchhnPq7M6UDcRqOwDZ3vo=
Date: Sat, 1 Oct 2005 02:28:44 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel cross-toolchain (Gentoo)
Message-ID: <20050930222343.GA8874@mipter.zuzino.mipt.ru>
References: <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20050930125645.GJ7992@ftp.linux.org.uk> <20050930160911.GA24810@mipter.zuzino.mipt.ru> <20050930160503.GK7992@ftp.linux.org.uk> <20050930175550.GA24071@mipter.zuzino.mipt.ru> <20050930193113.GN7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930193113.GN7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 08:31:13PM +0100, Al Viro wrote:
> On Fri, Sep 30, 2005 at 09:55:50PM +0400, Alexey Dobriyan wrote:
> > On Fri, Sep 30, 2005 at 05:05:03PM +0100, Al Viro wrote:
> > > Umm...  Is crossdev toolchain with target==host the same as native one?
> > 
> > Not sure what do you mean... Native gcc here is 3.3.6.
> > 
> > 	# crossdev -p -v -s1 -t i686-unknown-linux-gnu
> > 
> > will install binutils-2.16.1 and gcc-3.4.4.
> 
> ... then we have a problem.  The point is to get build coverage equivalent
> to native builds.  Cross-toolchain out of sync with native one means PITA
> in that respect.

[if I don't understand something ameba can understand, I preventively
 apologize and ask to explain.]

1) supported compilers are (effectively?):
	2.95.3 + %z patch, 3.3.*, 3.4.*, 4.0.1+.
2) build breakage on one of supported compilers is supposed to be
   reported and fixed.
3) I can easily install gcc 3.4 with one "emerge" invocation. No problem
   at all. After reading some docs to 4.0.$WHATEVER.
4) arm (other archs?) people mostly use cross-compilers (don't have rmk
   quote handy).

At this point I do not understand fundamental difference of "native
build" from cross build. Consequently I do not understand a problem with
native toolchains being different from cross ones. In my case, it is
still FSF GCC, no stack protection, ... patches.

Even more: you (and, to some extent, me), being a cross-compile farmer,
can't test if

	CONFIG_S390=y
	CONFIG_S390X=n
	CONFIG_CHECK_STACK=n	(made up example, pick another config if
				 you _can_ test)

boots and works fine. All you can do is to test is a config builds OK,
leaving the rest to folks who have the hardware.

Again, if I don't understand something very obvious, please, explain.

