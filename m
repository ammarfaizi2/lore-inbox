Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265023AbSKAONB>; Fri, 1 Nov 2002 09:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265026AbSKAONB>; Fri, 1 Nov 2002 09:13:01 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:22700 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265023AbSKAOM7>; Fri, 1 Nov 2002 09:12:59 -0500
Date: Fri, 1 Nov 2002 07:19:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: Bernd Petrovitsch <bernd@gams.at>, Matt Porter <porter@cox.net>,
       Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021101141919.GE815@opus.bloom.county>
References: <20021031100855.A3407@home.com> <22051.1036083179@frodo.gams.co.at> <20021031194348.A12469@jaquet.dk> <20021031191535.GA815@opus.bloom.county> <20021031202752.B12469@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031202752.B12469@jaquet.dk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 08:27:52PM +0100, Rasmus Andersen wrote:
> On Thu, Oct 31, 2002 at 12:15:35PM -0700, Tom Rini wrote:
> > There currently isn't a CONFIG_TINY / CONFIG_DESKTOP / CONFIG_FOO.  The
> > idea is that all of these changes you're working on to make a smaller
> > kernel shouldn't all be under CONFIG_TINY, but which ones are on / off
> > are read from some sort of template and there's a default 'tiny'
> > template, 'desktop' 'foo', etc template which has some on and some off.
> > 
> > And this is a major concern since many of us who would have to deal with
> > this when it enters the kernel want it to done in a flexible manner
> > initially, not later on.
> 
> OK. This certainly makes sense and I'll be happy to redo my stuff to
> match such a framework. This is not something I have thought a lot
> about until now, though.
> 
> How would you go about implementing this? A central .h file with
> tweakables and a number of templates setting these?

I'm still trying to figure out exactly how to do this so that we don't
clutter up the more generic code.  But some sort of tweaks.h, which
would include <asm/tiny_tweaks.h> or <asm/desktop_tweaks.h> (and maybe
an asm-generic/tiny_tweaks.h for non arch-specific parts).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
