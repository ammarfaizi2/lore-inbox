Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSKGTiZ>; Thu, 7 Nov 2002 14:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261549AbSKGTiY>; Thu, 7 Nov 2002 14:38:24 -0500
Received: from packet.digeo.com ([12.110.80.53]:36588 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261550AbSKGTiX>;
	Thu, 7 Nov 2002 14:38:23 -0500
Message-ID: <3DCAC2B8.E6271EF1@digeo.com>
Date: Thu, 07 Nov 2002 11:44:56 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Templates and tweaks (for size performance and more)
References: <20021107190910.GC6164@opus.bloom.county> <3DCABE9D.F71530DB@digeo.com> <20021107193330.GE6164@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2002 19:44:56.0025 (UTC) FILETIME=[25FB7C90:01C28696]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> On Thu, Nov 07, 2002 at 11:27:25AM -0800, Andrew Morton wrote:
> > Tom Rini wrote:
> > >
> > > Comments?
> >
> > You missed this little fella:
> >
> >    text    data     bss     dec     hex filename
> >    1735    1120  131104  133959   20b47 kernel/pid.o
> >
> >
> > Have a controversial patch which takes it to:
> >
> >    text    data     bss     dec     hex filename
> >    1614    1120    2080    4814    12ce kernel/pid.o
> 
> My patch isn't about size per-se, it's about tweaking the kernel and
> making it easier to do things like get a small kernel.  Or work on boxes
> with large amounts of memory and not use HIGHMEM, or otherwise have
> tweakable params with N different config options.
> 

Yes.  Replace PIDHASH_SHIFT (in that patch) with TWEAK_PIDHASH_SHIFT.
It must be a power of two.

Those tables are currently 128k even on the teeniest little
uniprocessor build.
