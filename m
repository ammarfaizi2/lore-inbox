Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbTAZVGG>; Sun, 26 Jan 2003 16:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266989AbTAZVGF>; Sun, 26 Jan 2003 16:06:05 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:17864 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S266987AbTAZVGE>; Sun, 26 Jan 2003 16:06:04 -0500
Date: Sun, 26 Jan 2003 23:08:42 +0100
From: Christian Zander <zander@minion.de>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030126220842.GB394@kugai>
Reply-To: Christian Zander <zander@minion.de>
References: <20030123193540.GD13137@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301261054250.15538-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301261054250.15538-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 11:43:44AM -0600, Kai Germaschewski wrote:
>
> Now, is that so bad? When you're building kernels yourself, you
> obviously have enough room for a full tree anyway. When you're using
> a distribution, you have to install the kernel source rpm anyway, to
> get the headers. For all I know, these days the headers are not
> distributed separately from the rest of the kernel source anymore..
> 

Debian GNU/Linux is a good example of a distribution shipping source
and configured kernel header packages seperately. It seems fair enough
to require a configured source tree installed, however, and I don't
have a strong opinion on this particular question.

> You might say that this is a regression w.r.t 2.4. But actually,
> even in 2.4, you need e.g. Makefile and arch/i386/Makefile to figure
> out the correct flags and things for your compile, and those are not
> headers, either.
> 

Not necessarily.

> This is a good solution to this specific problem. But it does not
> solve the rest, e.g. your Makefile doesn't set -fomit-frame-pointer
> depending on CONFIG_FRAME_POINTER. It doesn't set the proper
> march=x86 flags. IA-64 even needs a special flag just for modules.
> And it'll get even worse with the reintroduction of module symbol
> versioning.
> 
> So the above would work around this specific problem, leaving the
> other more subtle ones unsolved. And if you're using modules which
> have been built in such a fragile way with subtle differences, I
> think it's justified to have your kernel tainted.
> 

External projects may not want to use the build flags unchanged, they
may have good reasons for using their own. It seems sensible to make
the kernel build system available to those who wish to use it, but it
should be optional rather than mandatory. In this specific case, there
is no technical reason to require the use of kbuild.

-- 
christian zander
zander@minion.de
