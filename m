Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293277AbSBWXvc>; Sat, 23 Feb 2002 18:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293275AbSBWXvW>; Sat, 23 Feb 2002 18:51:22 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:43649 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S293277AbSBWXvH>; Sat, 23 Feb 2002 18:51:07 -0500
Date: Sat, 23 Feb 2002 15:50:51 -0800
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] C exceptions in kernel
Message-ID: <20020223235051.GA2412@gnuppy.monkey.org>
In-Reply-To: <200202231011.g1NABaU10984@devserv.devel.redhat.com> <25097.1014467212@ocs3.intra.ocs.com.au> <20020223075002.A23666@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020223075002.A23666@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.27i
From: Bill Huey <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 07:50:02AM -0500, Pete Zaitcev wrote:
> Personally, I have no problem handling current practices.
> But I may see the point of the guy with the try/catch patch.
> Do not make me to defend him though. I am trying to learn
> is those exceptions are actually helpful. BTW, we all know
> where they come from (all of Cutler's NT is written that way),
> but let it not cloud our judgement.

Uh, that's probably not right. If I've been told/remember correctly,
it's a technique that certain old school mainframe OSes use to
implement sophisticate fault recovery of various sorts. As you know,
one basically rewinds to the original point before the block is
called so that you can recover/continue from it.

It's not clear if an OS like Linux could really benefit from it since
everything that is so inheritently hotwired in the kernel, nor is it
clear how something like exceptions would conceptual map onto that
kind of system. Maybe DB/FS stuff would be a good of that stuff if
you have a condition that prevents a write to a disk (etc.l.) and
because they are data structure intensive systems.

But what about the TCP/IP stack ? or things in the bottom half ?

Those things are a bit more sticky and seem less compatible with
exceptions it seems.

bill

