Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273881AbRKDTYX>; Sun, 4 Nov 2001 14:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRKDTYO>; Sun, 4 Nov 2001 14:24:14 -0500
Received: from unthought.net ([212.97.129.24]:56024 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S273881AbRKDTYI>;
	Sun, 4 Nov 2001 14:24:08 -0500
Date: Sun, 4 Nov 2001 20:24:06 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Tim Jansen <tim@tjansen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104202406.N14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160S2o-1JXpD6C@fmrl05.sul.t-online.com> <20011104195955.K14001@unthought.net> <160Skz-1rDDSyC@fmrl05.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <160Skz-1rDDSyC@fmrl05.sul.t-online.com>; from tim@tjansen.de on Sun, Nov 04, 2001 at 08:19:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 08:19:39PM +0100, Tim Jansen wrote:
> On Sunday 04 November 2001 19:59, you wrote:
> > The idea is that if the userland application does it's parsing wrong, it
> > should either not compile at all, or abort loudly at run-time, instead of
> > getting bad values "sometimes".
> 
> All the XML parser interfaces that I have seen so far allow you to do things 
> that will cause the code to fail when you do stupid things or are not 
> prepared that there may appear unknown elements. Or you use a DTD, and then 
> your code is guaranteed to fail after a change, which may be even worse.

XML is pretty far from light-weight.  And it's only human readable in theory.

I like the *idea*, but XML is the wrong implementation of that idea.  Other than
that I think we could agree   ;)

> 
> One-value-files are a noticable exception, you must be VERY stupid if your 
> code breaks because of an additional file.

hehe, agreed.   The problem then is type information.

Consider:
-------------
int mf = open("/proc/meminfo/totalmem",O_RDONLY);
int32 mem;
read(mf, &mem, sizeof(mem));
-------------

Does this work ?   Yes of course.  But what if I ported my program to
a 64 bit arch...  The program still compiles.  It also runs.  But the
values are no longer correct.   Now *that* is hell.

Same story with ASCII.

I want type information.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
