Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbVKAJI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbVKAJI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVKAJI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:08:28 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:20232 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751267AbVKAJI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:08:27 -0500
Date: Tue, 1 Nov 2005 09:57:40 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 13/20] inflate: (arch) kill silly zlib typedefs
Message-ID: <20051101085740.GR22601@alpha.home.local>
References: <14.196662837@selenic.com> <Pine.LNX.4.62.0510312204400.26471@numbat.sonytel.be> <20051031211422.GC4367@waste.org> <20051101065327.GP22601@alpha.home.local> <Pine.LNX.4.62.0511010850190.2739@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0511010850190.2739@numbat.sonytel.be>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 08:50:43AM +0100, Geert Uytterhoeven wrote:
> On Tue, 1 Nov 2005, Willy Tarreau wrote:
> > But if it's a pointer why don't you declare them unsigned long then ?
> > C defines the long as the integer the right size to store a pointer.
>   ^
> Is it C?

Yes, that's what I read quite a time ago, and it appears that it was an
interpretation of the spec which is not true anymore with LLP64 models :-(

> Since on Wintendo P64 it's not true...

I don't know if x86_64 is LP64 or LLP64 on Linux, but at least my alpha
and sparc64 are LP64, so is another PPC64 I use for code validation.
LPC64 is the recommended model for easier 32 to 64 portability (where
ints are 32 ; long, longlong, ptrs are 64).

There's an interesting reading about this here :

   http://www.usenix.org/publications/login/standards/10.data.html

So Matt, you have to use void* or char* in your types.

> Gr{oetje,eeting}s,
> 
> 						Geert

Thanks Geert for the notification, it was an opportunity to refresh my
thoughts about portability practices. I think it will be time to buy
an x86_64 :-/

Willy

