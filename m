Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266822AbSKOWPd>; Fri, 15 Nov 2002 17:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266833AbSKOWPd>; Fri, 15 Nov 2002 17:15:33 -0500
Received: from are.twiddle.net ([64.81.246.98]:5766 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S266822AbSKOWPc>;
	Fri, 15 Nov 2002 17:15:32 -0500
Date: Fri, 15 Nov 2002 14:22:26 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: in-kernel linking issues
Message-ID: <20021115142226.B25624@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <20021115045146.A23944@twiddle.net> <20021115212941.7336E2C04C@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021115212941.7336E2C04C@lists.samba.org>; from rusty@rustcorp.com.au on Sat, Nov 16, 2002 at 08:21:32AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 08:21:32AM +1100, Rusty Russell wrote:
> > Are you really REALLY sure you don't want to load ET_DYN or ET_EXEC
> > files (aka shared libraries or executables) instead of ET_REL files
> > (aka .o files)?
> 
> AFAICT, that would hurt some archs.  Of course, you could say "modules
> are meant to be slow" but I don't think that would win you any
> friends 8)

Actually, I've yet to come across one that is adversely affected.
Note that we're putting code _not_ compiled with -fpic into this
shared object.

> Note: "extreme reduction" is probably overstating.  There are only
> about 300 lines of linker code in the kernel (x86).

Note that x86 is the easiest possible case.  You've only got two
relocation types, you don't need to worry about .got, .plt, .opd
allocation, nor sorting sections into a required order, nor
sorting COMMON symbols.


r~
