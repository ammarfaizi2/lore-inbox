Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVKAL1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVKAL1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 06:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVKAL1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 06:27:46 -0500
Received: from witte.sonytel.be ([80.88.33.193]:48832 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750737AbVKAL1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 06:27:45 -0500
Date: Tue, 1 Nov 2005 12:27:36 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Willy Tarreau <willy@w.ods.org>
cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 13/20] inflate: (arch) kill silly zlib typedefs
In-Reply-To: <20051101085740.GR22601@alpha.home.local>
Message-ID: <Pine.LNX.4.62.0511011223410.2739@numbat.sonytel.be>
References: <14.196662837@selenic.com> <Pine.LNX.4.62.0510312204400.26471@numbat.sonytel.be>
 <20051031211422.GC4367@waste.org> <20051101065327.GP22601@alpha.home.local>
 <Pine.LNX.4.62.0511010850190.2739@numbat.sonytel.be> <20051101085740.GR22601@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Willy Tarreau wrote:
> On Tue, Nov 01, 2005 at 08:50:43AM +0100, Geert Uytterhoeven wrote:
> > On Tue, 1 Nov 2005, Willy Tarreau wrote:
> > > But if it's a pointer why don't you declare them unsigned long then ?
> > > C defines the long as the integer the right size to store a pointer.
> >   ^
> > Is it C?
> 
> Yes, that's what I read quite a time ago, and it appears that it was an
> interpretation of the spec which is not true anymore with LLP64 models :-(
> 
> > Since on Wintendo P64 it's not true...
> 
> I don't know if x86_64 is LP64 or LLP64 on Linux, but at least my alpha
> and sparc64 are LP64, so is another PPC64 I use for code validation.
> LPC64 is the recommended model for easier 32 to 64 portability (where
> ints are 32 ; long, longlong, ptrs are 64).

Linux on x86_64 uses LP64, like all other 64-bit platforms Linux runs on.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
