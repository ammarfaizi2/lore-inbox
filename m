Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279202AbRKAP5D>; Thu, 1 Nov 2001 10:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279231AbRKAP4x>; Thu, 1 Nov 2001 10:56:53 -0500
Received: from [195.63.194.11] ([195.63.194.11]:6416 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S279202AbRKAP4r>;
	Thu, 1 Nov 2001 10:56:47 -0500
Message-ID: <3BE17D30.BCB3F35F@evision-ventures.com>
Date: Thu, 01 Nov 2001 17:49:52 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
In-Reply-To: <E15zF9H-0000NL-00@wagner> <3BE1271C.6CDF2738@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> > No kernel-formatted tables: use a directory.  (eg. kernel symbols
> > become a directory of symbol names, each containing the symbol value).
> >
> > For cases when you don't want to take the overhead of creating a new
> > proc entry (eg. tcp socket creation), you can create directories on
> > demand when a user reads them using:
> >
> >         proc_dir("net", "subdir", dirfunc, NULL);
> >         unproc_dir("net", "subdir");
> >
> > Note that with kbuild 2.5, you can do something like:
> >
> >         proc(KBUILD_OBJECT, "foo", my_foo, int, 0644);
> >
> > And with my previous parameter patch:
> >         PARAM(foo, int, 0444);
> 
> Is this designed to replace sysctl?
> 
> In general we want to support using sysctl and similar features WITHOUT
> procfs support at all (of any type).  Nice for embedded systems
> especially.
> 
> sysctl may be ugly but it provides for a standard way of manipulating
> kernel variables... sysctl(2) or via procfs or via /etc/sysctl.conf.
> 
> AFAICS your proposal, while nice and clean :), doesn't offer all the
> features that sysctl presently does.
> 
>         Jeff

sysctl IS NOT UGLY. Not the sysctl I know from Solaris or BSD. Both are
far more pleasant solutions then the proliferation of ad-hoc,
undocumented
ever changing, redunand, slow, overcomplex in implementation,
(insert a list of random invectives here) interfaces shown under /proc.
And yes I don't give a shit about "cool features" like:

echo "bull shit" >
/proc/this/is/some/random/peace/of/crappy/interface/design

BTW.> /proc/sys is indeed silly, since it's a "second order" interface
to something you can gat your gip on far easier already. And redundant
system
intrefaces are not a nice design.
