Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbTBLICJ>; Wed, 12 Feb 2003 03:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbTBLICJ>; Wed, 12 Feb 2003 03:02:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25954 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266962AbTBLICI>; Wed, 12 Feb 2003 03:02:08 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Oleg Drokin <green@namesys.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.60
References: <Pine.LNX.4.44.0302102336530.3543-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Feb 2003 01:11:23 -0700
In-Reply-To: <Pine.LNX.4.44.0302102336530.3543-100000@home.transmeta.com>
Message-ID: <m17kc5yl3o.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Tue, 11 Feb 2003, Oleg Drokin wrote:
> > 
> > One of yours hand merged UML updates/fixes in, and another one broke it badly
> by introducing
> 
> > sigprocmask(). Now there is a conflict between in-kernel sigprocmask() and
> > glibc's sigprocmask() (that UML uses to manage signal delivery to right
> thread).
> 
> > Can we please change the name of in-kernel's sigprocmask() to avoid name
> clash? ;)
> 
> 
> No. I'm not goinmg to start caring about user-land naming in-kernel, that
> way is a slippery slope. This is firmly a UML problem.

Just for throwing out suggestions, UML can easily avoid using
glibc altogether as it is already intimate with the system call layer.

Or it can use the linker to play games with symbol names to move the kernel off
into it's own separate name space.

This sounds like a good opportunity to figure out which makes most sense 
and future proof UML.

Eric
