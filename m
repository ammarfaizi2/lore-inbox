Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289812AbSAKApT>; Thu, 10 Jan 2002 19:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289814AbSAKApE>; Thu, 10 Jan 2002 19:45:04 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:16043
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289812AbSAKAot>; Thu, 10 Jan 2002 19:44:49 -0500
Date: Thu, 10 Jan 2002 17:44:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, felix-dietlibc@fefe.de,
        andersen@codepoet.org
Subject: Re: [RFC] klibc requirements, round 2
Message-ID: <20020111004453.GG13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020110231849.GA28945@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020110231849.GA28945@kroah.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 03:18:49PM -0800, Greg KH wrote:

> Ok, now that we have a general idea that people are going to want to
> stick lots of different types of programs into the initramfs, does this
> change any of the initial requirement list for klibc that I sent out?
> 
> To summarize, here's a partial list of the programs people want to run:
[snip]
> 	- image viewer
> 	- mkreiserfs

I think these are examples of misunderstanding what initramfs _can do_
with what we (might) need a klibc to do.  What we need a klibc for is
the lots of other, existing in kernel code, and related things which we
can't do right now, but could do (IP PNP over pcmcia wasn't possible
when I tried it ages ago, but should be when 2.5.x is over hopefully).
These programs _might_ compile with a klibc, but I wouldn't worry about
it.  uClibc is what should be used for many of these custom applications
of initramfs.  And any of the kernel code pulled out into userland
should end up being able to compile on any libc, since we'll need it in
the final root, so it would probably be in the real roots /sbin too.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
