Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266927AbSK2Biz>; Thu, 28 Nov 2002 20:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbSK2Biz>; Thu, 28 Nov 2002 20:38:55 -0500
Received: from zok.sgi.com ([204.94.215.101]:43708 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S266927AbSK2Biy>;
	Thu, 28 Nov 2002 20:38:54 -0500
Date: Fri, 29 Nov 2002 12:45:00 +1100
From: Nathan Scott <nathans@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Thomas Molina <tmolina@copper.net>, linux-kernel@vger.kernel.org,
       Anders Gustafsson <andersg@0x63.nu>, Steve Lord <lord@sgi.com>
Subject: Re: [RELEASE] module-init-tools 0.8
Message-ID: <20021129014500.GB546@frodo.melbourne.sgi.com>
References: <Pine.LNX.4.44.0211272325370.924-100000@lap.molina> <20021129013010.38C262C2BA@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021129013010.38C262C2BA@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 11:59:49AM +1100, Rusty Russell wrote:
> In message <Pine.LNX.4.44.0211272325370.924-100000@lap.molina> you write:
> > With the patch you included, I get the following:
> > 
> > In file included from include/linux/raid/md.h:27,
> >                  from init/do_mounts.c:25:
> > include/linux/module.h:159: parse error before "Elf32_Sym"
> 
> Argh.... Put back the #include <linux/elf.h> at the top of the file.
> It's required for CONFIG_KALLSYMS=y.
> 
> The main reason for separating out moduleloader.h was so modules.h
> didn't include elf.h, because xfs defines AT_GID and AT_UID itself.
> The kallsyms patch put that back.
> 
> We could make module.symtab a void*, but that's just wrong.  I think
> we actually have to solve this clash, rather than hack around it,
> since this is going to be a recurring problem.
> 
> Steve?  Changing the prefix on xfs or elf seems equally painful (xfs
> because it'll be a big patch, elf because it's standardized and been
> like that forever).

We changed XFS when this problem first came up.  Linus hasn't yet
pulled from Christoph's bitkeeper tree though, so we're a bit out
of sync at the moment.

cheers.

-- 
Nathan
