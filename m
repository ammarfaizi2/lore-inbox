Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSIHTHO>; Sun, 8 Sep 2002 15:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSIHTHO>; Sun, 8 Sep 2002 15:07:14 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1152 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313305AbSIHTHN>;
	Sun, 8 Sep 2002 15:07:13 -0400
Date: Sat, 7 Sep 2002 03:29:58 +0000
From: Pavel Machek <pavel@suse.cz>
To: Anton Blanchard <anton@samba.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.20-pre5] non syscall gettimeofday
Message-ID: <20020907032957.B35@toy.ucw.cz>
References: <1031267553.10830.71.camel@dell_ss3.pdx.osdl.net> <al8ptr@cesium.transmeta.com> <20020906012144.GA6804@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020906012144.GA6804@krispykreme>; from anton@samba.org on Fri, Sep 06, 2002 at 11:21:44AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This sounds like a vsyscall.  Since we have discussed vsyscalls on and
> > off without getting anywhere, I'd like to know how your implementation
> > does it -- the #1 proposal I think was to map in a page at 0xfffff000
> > and have the vsyscall code there.
> 
> Id like to do a similar thing on ppc32 and ppc64. It would be good to
> make some of this generic before everyone implements it their own way.
> 
> Of course the lower level stuff will be arch specific, but some of it
> could be the same (like how do we handle ptracing into the area? Do
> we COW or do we deny it and fix gdb to unsderstand vsyscalls).

It is already implemented on x86-64.

AFAIR putting breakpoints into vsyscall area is not permitted.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

