Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSGEBLa>; Thu, 4 Jul 2002 21:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314885AbSGEBL3>; Thu, 4 Jul 2002 21:11:29 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:61650 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S314835AbSGEBL2>;
	Thu, 4 Jul 2002 21:11:28 -0400
Date: Fri, 5 Jul 2002 11:12:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch,rfc] make depencies on header files explicit
Message-Id: <20020705111257.04d026b1.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.33.0207032331010.31929-100000@gans.physik3.uni-rostock.de>
References: <Pine.LNX.4.33.0207032331010.31929-100000@gans.physik3.uni-rostock.de>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Wed, 3 Jul 2002 23:45:19 +0200 (CEST) Tim Schmielau
<tim@physik3.uni-rostock.de> wrote:
>
> It seems to be quite common to assume that sched.h and all the other 
> headers it drags in are available without declaration anyways. Since
> I aim at invalidating this assumption by removing all unneccessary 
> includes, I have started to make dependencies on header files included
> by sched.h explicit.
> This is, again, just a small start, a patch covering the whole include/
> subtree would be approximately 25 times as large. However, before I'll
> dig into this further, I'd like to make sure I haven't missed some
> implicit rules about which headers might be assumed available, or should
> be included by the importing .c file, or something like that.
> So any comments about this project are welcome.

Let me encourage you!  IMHO any source file (and here I include header
files) should include all the header files it depends on.  This gives us
at least some chance of keeping the headers consistant with their usage.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
