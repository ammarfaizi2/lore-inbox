Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUAQQnu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 11:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266066AbUAQQnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 11:43:50 -0500
Received: from wilma.widomaker.com ([204.17.220.5]:37138 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S266063AbUAQQns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 11:43:48 -0500
Date: Sat, 17 Jan 2004 10:49:05 -0500
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.1 and cdrecord on ATAPI bus
Message-ID: <20040117154905.GB26248@widomaker.com>
References: <20040117031925.GA26477@widomaker.com> <20040117042208.GA8664@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040117042208.GA8664@merlin.emma.line.org>
X-Message-Flag: Microsoft Loves You!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, 17 Jan 2004 @ 05:22 +0100, Matthias Andree said:

> On Fri, 16 Jan 2004, Charles Shannon Hendrix wrote:
> 
> > I'm now running kernel 2.6.1, and using cdrecord with ATAPI is
> > problematic.
> 
> I don't find it is. 

Well, some of us are lucky that way...

> It's rather cdrecord insisting on scanning buses itself and bitching
> about direct device names...

Scanning busses doesn't appear to be the problem.

>From looking at strace, I see it scanning all devices themselves and
then trying ioctl(3,...) on them if they exist.

It isn't complaining about direct device names at all, and it finds the
right one and attempts to use it.

ioctl() fails with an EIO error a few times and cdrecord prints an error
than it can't read the drive.

> Interesting. I use dev=/dev/hdc and it works fine for me (Plextor 48X),
> but then again, I'm also running the latest cdrecord alpha.

% cdrecord -version
Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling

I can try an alpha version, but from running strace on cdrecord, it
seems like Linux is the problem.  Several ioctl() calls are failing just
before cdrecord prints an error message and exits.



-- 
UNIX/Perl/C/Pizza____________________s h a n n o n@wido !SPAM maker.com
