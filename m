Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUAJTlY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265344AbUAJTjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:39:09 -0500
Received: from waste.org ([209.173.204.2]:13708 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265213AbUAJTiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:38:10 -0500
Date: Sat, 10 Jan 2004 13:37:34 -0600
From: Matt Mackall <mpm@selenic.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: George Anzinger <george@mvista.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: kgdb cleanups
Message-ID: <20040110193734.GK18208@waste.org>
References: <20040109183826.GA795@elf.ucw.cz> <3FFF2304.8000403@mvista.com> <20040110044722.GY18208@waste.org> <3FFFB3D6.1050505@mvista.com> <20040110175607.GH18208@waste.org> <20040110193406.GA241@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110193406.GA241@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 08:34:06PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > >>>Hi!
> > > >>>
> > > >>>No real code changes, but cleanups all over the place. What about
> > > >>>applying?
> > > >>>
> > > >>>Ouch and arch-dependend code is moved to kernel/kgdb.c. I'll probably
> > > >>>do x86-64 version so that is rather important.
> > > >>>
> > > >>>								Pavel
> > > >>
> > > >>A few comments:
> > > >>
> > > >>I like the code seperation.  Does it follow what Amit is doing?  It would 
> > > >>be nice if Amit's version and this one could come together around this.
> > > >>
> > > >>I don't think we want to merge the eth and regular kgdb just yet.  I 
> > > >>would, however, like to keep eth completly out of the stub.  Possibly a 
> > > >>new module which just takes care of steering the I/O to the correct place.
> > > >
> > > >
> > > >I've sent Amit the start of an plug interface for abstracting the
> > > >communication layer. Should be relatively painless and allow for
> > > >starting sessions on the interface of your choice.
> > > >
> > > May I see?
> > 
> > Here's the interface plus the eth side of it:
> 
> Does it work with those patches? (Amid's version does not seem to work
> over ethernet).

The stuff currently in -mm and -tiny works. The "pluggable" bits are
proof of concept at this stage and I've been busy working on other
things - was hoping someone else would run with them.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
