Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273030AbTHKSnM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273028AbTHKSlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:41:36 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:29388 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S273027AbTHKSlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:41:23 -0400
Date: Mon, 11 Aug 2003 19:40:47 +0100
From: Dave Jones <davej@redhat.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sort the cache shift options.
Message-ID: <20030811184047.GA3884@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E19mFqr-00068f-00@tetrachloride> <Pine.LNX.4.44.0308112030240.24676-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308112030240.24676-100000@serv>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 08:31:52PM +0200, Roman Zippel wrote:
 > > diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/Kconfig linux-2.5/arch/i386/Kconfig
 > > --- bk-linus/arch/i386/Kconfig	2003-08-06 16:39:02.000000000 +0100
 > > +++ linux-2.5/arch/i386/Kconfig	2003-08-08 00:38:44.000000000 +0100
 > > @@ -322,10 +322,10 @@ config X86_XADD
 > >  
 > >  config X86_L1_CACHE_SHIFT
 > >  	int
 > > -	default "7" if MPENTIUM4 || X86_GENERIC
 > >  	default "4" if MELAN || M486 || M386
 > >  	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
 > >  	default "6" if MK7 || MK8
 > > +	default "7" if MPENTIUM4 || X86_GENERIC
 > >  
 > >  config RWSEM_GENERIC_SPINLOCK
 > >  	bool
 > 
 > The order does matter, in this case we want to override the cpu selection 
 > with X86_GENERIC.

Ohhh. Ok, I see how that works. Bit icky though, and non-obvious
to someone stupid like me.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
