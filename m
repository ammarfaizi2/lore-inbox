Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSLQGLL>; Tue, 17 Dec 2002 01:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSLQGLL>; Tue, 17 Dec 2002 01:11:11 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:39553
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S264739AbSLQGLJ>; Tue, 17 Dec 2002 01:11:09 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
In-Reply-To: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1040105941.7096.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 17 Dec 2002 00:19:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 00:09, Linus Torvalds wrote:
> On Mon, 16 Dec 2002, Linus Torvalds wrote:
> >
> > On my P4 machine, a "getppid()" is 641 cycles with sysenter/sysexit, and
> > something like 1761 cycles with the old "int 0x80/iret" approach. That's a
> > noticeable improvement, but I have to say that I'm a bit disappointed in
> > the P4 still, it shouldn't be even that much.
> 
> On a slightly more real system call (gettimeofday - which actually matters
> in real life) the difference is still visible, but less so - because the
> system call itself takes more of the time, and the kernel entry overhead
> is thus not as clear.
> 
> For gettimeofday(), the results on my P4 are:
> 
> 	sysenter:	1280.425844 cycles
> 	int/iret:	2415.698224 cycles
> 			1135.272380 cycles diff
> 	factor 1.886637
> 
> ie sysenter makes that system call almost twice as fast.


I'm curious, if this is one of the Dual P4's non-Xeon(say, 2.4 Ghz+?) or
if this is one of the Xeons? There seems to be some perceived disparity
between which performs how. I think the biggest difference on the Xeon's
is the stepping and the cache,(pipeline too?), but not too much else.

[...]
> 			Linus
> 

