Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWICV3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWICV3o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 17:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWICV3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 17:29:44 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:62666 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751605AbWICV3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 17:29:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YVx0wN3za/ipPVf0UvMHHsSKM6Jq7rCMqsQrdB6Ns+ShHWxHy7Lt+CLfWK+hqvlkS3b7ygg1Tqq4E+BkUzS9pJ7y0P9y1n5Ml8K4FRkA98MiL/SFGrl3kJNCUS0sl5VHIfuDj2o+lEHlMwYfgK6bNRWAFtVJYwwQrjSmBjDRHfw=
Message-ID: <a44ae5cd0609031429x30c74a80l2399f0abf2f1c1a7@mail.gmail.com>
Date: Sun, 3 Sep 2006 14:29:42 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: Fw: Re: 2.6.18-rc5-mm1 + all hotfixes -- BUG: MAX_STACK_TRACE_ENTRIES too low!
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060903212753.GA29095@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060903114229.7f17c94f.akpm@osdl.org>
	 <20060903204426.GA28786@uranus.ravnborg.org>
	 <a44ae5cd0609031416l5c87fe89yef215a1016ee9915@mail.gmail.com>
	 <20060903212753.GA29095@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sun, Sep 03, 2006 at 02:16:05PM -0700, Miles Lane wrote:
> > On 9/3/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > >[ketchup -g 2.6-mm; make defconfig; make menuconfig]
> > >
> > >[sam@neptun mm]$ grep LOCKDEP .config
> > >CONFIG_LOCKDEP_SUPPORT=y
> > >CONFIG_LOCKDEP=y
> > >CONFIG_DEBUG_LOCKDEP=y
> > >[sam@neptun mm]$ make
> > >  CHK     include/linux/version.h
> > >  CHK     include/linux/utsrelease.h
> > >  CHK     include/linux/compile.h
> > >  MODPOST vmlinux
> > >Kernel: arch/i386/boot/bzImage is ready  (#3)
> > >  Building modules, stage 2.
> > >  MODPOST 1 modules
> > >[sam@neptun mm]$ touch kernel/lockdep_internals.h
> > >[sam@neptun mm]$ make
> > >  CHK     include/linux/version.h
> > >  CHK     include/linux/utsrelease.h
> > >  CHK     include/linux/compile.h
> > >  CC      kernel/lockdep.o
> > >  CC      kernel/lockdep_proc.o
> > >
> > >Works for me?
> > >
> > >Miles - can you double check that you have CONFIG_LOCKDEP defined.
> >
> > Ah, I suspect I was being a dufus.  I was looking for the exact
> > filename, since I rarely receive patches for anything other than C
> > files.  I probably overlooked it.  I'm very sorry to have bothered
> > you.  BTW, yes, I had it defined.
>
> No problem.
> Can I request you to do a follow-up post to the mail at lkml
> just so people do not start to mistrust kbuild.
>
> It takes quiet some time to gain trust but only little to loose
> it again so it would be very nice to close this one in public.

Sure.  I didn't notice you had dropped LKML off the CC list in your reply.

Hey everyone, mea culpa.  KBuild is working fine!  :-)

-- 
VGER BF report: U 0.500013
