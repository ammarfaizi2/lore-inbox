Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbSKGTrt>; Thu, 7 Nov 2002 14:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261560AbSKGTrt>; Thu, 7 Nov 2002 14:47:49 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:957 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S261558AbSKGTrr>; Thu, 7 Nov 2002 14:47:47 -0500
Date: Thu, 7 Nov 2002 12:54:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Templates and tweaks (for size performance and more)
Message-ID: <20021107195424.GF6164@opus.bloom.county>
References: <20021107190910.GC6164@opus.bloom.county> <3DCABE9D.F71530DB@digeo.com> <20021107193330.GE6164@opus.bloom.county> <3DCAC2B8.E6271EF1@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCAC2B8.E6271EF1@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 11:44:56AM -0800, Andrew Morton wrote:
> Tom Rini wrote:
> > 
> > On Thu, Nov 07, 2002 at 11:27:25AM -0800, Andrew Morton wrote:
> > > Tom Rini wrote:
> > > >
> > > > Comments?
> > >
> > > You missed this little fella:
> > >
> > >    text    data     bss     dec     hex filename
> > >    1735    1120  131104  133959   20b47 kernel/pid.o
> > >
> > >
> > > Have a controversial patch which takes it to:
> > >
> > >    text    data     bss     dec     hex filename
> > >    1614    1120    2080    4814    12ce kernel/pid.o
> > 
> > My patch isn't about size per-se, it's about tweaking the kernel and
> > making it easier to do things like get a small kernel.  Or work on boxes
> > with large amounts of memory and not use HIGHMEM, or otherwise have
> > tweakable params with N different config options.
> > 
> 
> Yes.  Replace PIDHASH_SHIFT (in that patch) with TWEAK_PIDHASH_SHIFT.
> It must be a power of two.
> 
> Those tables are currently 128k even on the teeniest little
> uniprocessor build.

Ah, I see now.  In the next version I'll add that as an additional
patch.  Any comments on the idea itself or how I implemented it or
anything?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
