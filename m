Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285907AbSALMWT>; Sat, 12 Jan 2002 07:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285972AbSALMWJ>; Sat, 12 Jan 2002 07:22:09 -0500
Received: from codepoet.org ([166.70.14.212]:39843 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S285907AbSALMVw>;
	Sat, 12 Jan 2002 07:21:52 -0500
Date: Sat, 12 Jan 2002 05:21:52 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Felix von Leitner <felix-dietlibc@fefe.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements, round 2
Message-ID: <20020112122152.GA24994@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Felix von Leitner <felix-dietlibc@fefe.de>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020110231849.GA28945@kroah.com> <20020111133150.GI21447@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020111133150.GI21447@codeblau.de>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jan 11, 2002 at 02:31:50PM +0100, Felix von Leitner wrote:
> > How about responses from the dietlibc and uClibc people on the odds of
> > them being able to port to the remaining platforms?
> 
> I think I can speak for both Erik and myself when I say that we don't
> hate architectures and because of that don't support them.  If we get a
> chance (and maybe a little help from someone who knows those platform),
> we will port our libc to that platform.
> 
> Sadly, I don't have the deep pockets to buy myself a hardware lab with a
> VAX to port my libc to it.  So I (and Erik, too, obviously) would need
> at least an account on one of those boxes, with gcc, binutils, strace
> and gdb installed.

Fully agreed.  Porting libc (diet or uClibc) is an issue of
hardware access, access to the instruction set docs for the arch,
access to a gnu toolchain, and (the biggest issue) an issue of
time and motivation.

> In my eyes that is a waste of time, really.
> But it's your time, so don't let that stand in your way ;)

I agree here.  dietlibc is GPL.  uClibc is LGPL.  I think they
both address the problem space pretty well.  Felix and I are
both willing to accept patches.

Lets look at it the other way...  Suppose you start making a
separate klibc.  You skip/eliminate a ton of stuff and next week
someone complains that it's missing, say, the pivot_root syscall.
So you add it.  Then the week after, someone complains that you
are missing varargs.  So you add that too.  Pretty soon, someone
will complain about how printf feature foo is missing, and they
just _need_ SuS2 wordexp compatibility, etc, etc.  Trust me when
I say you are on a very slippery slope, with a awful lot of
redundant work ahead of you.  If you want to pursue it, thats
fine, and I'll even help you a bit.  But I think that soon
enough, you will converge on what dietlibc and uClibc already
have.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
