Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268005AbTB1P7Z>; Fri, 28 Feb 2003 10:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268006AbTB1P7Y>; Fri, 28 Feb 2003 10:59:24 -0500
Received: from 237.oncolt.com ([213.86.99.237]:228 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S268005AbTB1P7Y>; Fri, 28 Feb 2003 10:59:24 -0500
Subject: Re: Replacement for "make SUBDIRS=...." in 2.5.63?
From: David Woodhouse <dwmw2@infradead.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302251039080.13501-100000@chaos.physics.uiowa.edu>
References: <Pine.LNX.4.44.0302251039080.13501-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1046448358.12902.45.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 28 Feb 2003 16:05:58 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-25 at 17:04, Kai Germaschewski wrote:

> > 	What is the proper way to rebuild just one subdirectory?  How
> > about for building externally provided modules? 
> 
> The proper way is "make vmlinux/modules". If you are sure that nothing 
> changed outside of that directory, make SUBDIRS=... is fine, but since 
> kbuild cannot know that nothing else changed (you just prohibited checking 
> the other dirs), it'll give the warning.

In the case where you're building external modules, this is just fine --
generally you're doing this on purpose. How about disabling the warning
if every element of $(SUBDIRS) starts with a '/'?

> I hope that clarifies things a bit. As I wrote earlier, I'll come up with 
> a proper and simple way to build external modules once I find the time.

If you deprecate 'make SUBDIRS=/my/module/source modules' then please
make sure whatever replacement you come up with also works with 2.0, 2.2
and 2.4 kernels, to avoid gratuitous pain for driver maintainers. :)

-- 
dwmw2

