Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSJZQNn>; Sat, 26 Oct 2002 12:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262235AbSJZQNn>; Sat, 26 Oct 2002 12:13:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11003 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262224AbSJZQNm>;
	Sat, 26 Oct 2002 12:13:42 -0400
Message-ID: <3DBAC08B.780FEA05@mvista.com>
Date: Sat, 26 Oct 2002 09:19:23 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] High-res-timers part 2 (x86 platform code) take 6
References: <3DAFB303.4543C579@mvista.com> <20021023093815.GB3416@elf.ucw.cz> <3DBAB90F.CEF29920@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Pavel Machek wrote:
> >
> > Hi!
> >
> > > This patch, in conjunction with the "core" high-res-timers
> > > patch implements high resolution timers on the i386
> > > platforms.  The high-res-timers use the periodic interrupt
> > > to "remind" the system to look at the clock.  The clock
> >
> > This scares me:
> >
> > +#define fail_message \
> > +"High-res-timers:
> > >-<--><-->-<-->-<-->-<--><-->-<-->-<-->-<-->-<-->-<-->-<-->-<\n"\
> > +"High-res-timers: >Failed to find the ACPI pm timer
> > <\n"\
> > +"High-res-timers: >-<--><-->-<-->-<-->-<-->Boot will fail in
> > Calibrate Delay  <\n"\
> > +"High-res-timers: >Supply a valid default pm timer address
> > <\n"\
> > +"High-res-timers: >or get your BIOS to turn on ACPI support.
> > <\n"\
> > +"High-res-timers: >See CONFIGURE help for more information.
> > <\n"\
> > +"High-res-timers:
> > >-<--><-->-<-->-<-->-<--><-->-<-->-<-->-<-->-<-->-<-->-<-->-<\n"
> >
> > Does that mean our boot has now so much junk in it that we start
> > adding ascii art for "important" messages?
> 
> Well, Yes! It does.  However, the problem here is that this
> is detected prior to enabling the console so, unless the
> boot can limp along until that happens, this message will
> not be seen.  I have seen both conditions...

This, of course is the problem, the message appears buried
in the noise prior to the actual boot failure (assuming it
is printed at all).
> 
> I am open to suggestions...
> 
> Thanks for looking.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
