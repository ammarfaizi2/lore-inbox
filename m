Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265084AbSJaHj6>; Thu, 31 Oct 2002 02:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265216AbSJaHj6>; Thu, 31 Oct 2002 02:39:58 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:63340 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S265084AbSJaHj5>; Thu, 31 Oct 2002 02:39:57 -0500
Date: Thu, 31 Oct 2002 09:46:04 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031074604.GE2849@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20021031020836.E576E2C09F@lists.samba.org> <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 06:31:36PM -0800, you [Linus Torvalds] wrote:
> 
> > Crash Dumping (LKCD)
> 
> This is definitely a vendor-driven thing. I don't believe it has any 
> relevance unless vendors actively support it.

I don't think this is just a vendor thing. Currently, linux doesn't have any
way of saving the crash dump when the box crashes. So if it crashes, the
user needs to write the oops down by hand (error prone, the interesting part
has often scrolled off screen), or attach a serial console (then he needs to
reproduce it - not always possible, and actually majority of people (home
users) don't have second box and the cable. Nor the motivation.)

So, imho some kind of way of semi-automatically save the dumps is needed. If
vendors even support it - great - but it has value to mainline kernel as
well, as people can submit more accurate error reports. Besides, if it goes
in mainline, I believe vendors are likely to support it. (Why wouldn't they?
Currently there just isn't a standard way of doing this.)

There are a bunch of patches for this sort of thing (Willy Tarreau's
kmsgdump for dumping to floppy, Ingo's netconsole, Rusty's oopser for
dumping to ide device...), but lkcd is a more general framework, and can
support different ways of dumping.

I know you are not keen on kernel debuggers, but I can't see what's
fundamentally wrong with being able to save the crucial info when a crash
happens...


-- v --

v@iki.fi
