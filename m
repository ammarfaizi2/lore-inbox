Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbSKMH3F>; Wed, 13 Nov 2002 02:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbSKMH3F>; Wed, 13 Nov 2002 02:29:05 -0500
Received: from zok.SGI.COM ([204.94.215.101]:11947 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S267124AbSKMH3E>;
	Wed, 13 Nov 2002 02:29:04 -0500
Date: Wed, 13 Nov 2002 18:34:11 +1100
From: Nathan Scott <nathans@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Steve Lord <lord@sgi.com>, Anders Gustafsson <andersg@0x63.nu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5-bk AT_GID clash
Message-ID: <20021113073411.GF513@frodo.melbourne.sgi.com>
References: <1037122398.27014.43.camel@jen.americas.sgi.com> <20021113071630.190EC2C077@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113071630.190EC2C077@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 05:07:03AM +1100, Rusty Russell wrote:
> In message <1037122398.27014.43.camel@jen.americas.sgi.com> you write:
> > 
> > But does everyone who wants to implement a module need to be exposed
> > to all the details of the elf header?
> 
> Well, linux/module.h -> asm/module.h -> linux/elf.h.  Although if you
> use #define instead of typedef you can break the last link.  Feel free
> to send a patch to split it into moduleload.h or something, but I
> think it'll look tiny.
> 
> But IMHO the nameclash needs to be fixed *anyway*, not hacked around,
> or someone else will run over it one day.  AFAICT, changing
> fs/binfmt_elf.c and elf.h to AT_RGID is the simplest.  Both should be
> mildly chastised for using a prefix like AT_ publically.

FWIW, we changed XFS earlier today - it will go to Linus in the
next batch of XFS mods.  We're now using an XFS_AT_* convention
instead.

cheers.

-- 
Nathan
