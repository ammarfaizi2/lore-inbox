Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbTAMP3I>; Mon, 13 Jan 2003 10:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTAMP3I>; Mon, 13 Jan 2003 10:29:08 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:50831 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261370AbTAMP3H>; Mon, 13 Jan 2003 10:29:07 -0500
Date: Mon, 13 Jan 2003 09:37:54 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Daniel Jacobowitz <dan@debian.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <tridge@samba.org>
Subject: Re: [PATCH] Check compiler version, SMP and PREEMPT.
In-Reply-To: <20030113151901.GA28149@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0301130935490.24477-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Daniel Jacobowitz wrote:

> On Mon, Jan 13, 2003 at 04:13:19PM +1100, Rusty Russell wrote:
> > Linus, please apply if you agree.
> > 
> > Tridge reported getting burned by gcc 3.2 compiled (Debian) XFree
> > modules not working on his gcc 2.95-compiled kernel.  Interestingly,
> > (as Tridge points out) modversions probably would not have caught the
> > change in spinlock size, since the ioctl takes a void*, not a
> > structure pointer...
> 
> > D: and compiler version (spinlocks change size on UP with gcc major,
> > D: at least).
> 
> Why does this happen?  It doesn't look like it should, but I only
> skimmed the headers checking...

I suppose it's due to the

	#if (__GNUC__ > 2)
	[...]

in include/linux/spinlock.h, i.e. it's not at all gcc's fault.

--Kai


