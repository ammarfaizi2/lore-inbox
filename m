Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSKNBb1>; Wed, 13 Nov 2002 20:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSKNBa2>; Wed, 13 Nov 2002 20:30:28 -0500
Received: from dp.samba.org ([66.70.73.150]:62085 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261338AbSKNBaZ>;
	Wed, 13 Nov 2002 20:30:25 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: Steve Lord <lord@sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux/elf.h vs linux/module.h [was: 2.5-bk AT_GID clash] 
In-reply-to: Your message of "Wed, 13 Nov 2002 12:17:45 BST."
             <20021113111744.GA10014@gagarin> 
Date: Thu, 14 Nov 2002 12:53:21 +1100
Message-Id: <20021114013718.24B372C292@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021113111744.GA10014@gagarin> you write:
> On Wed, Nov 13, 2002 at 05:07:03AM +1100, Rusty Russell wrote:
> > In message <1037122398.27014.43.camel@jen.americas.sgi.com> you write:
> > > On Tue, 2002-11-12 at 11:16, Rusty Russell wrote:
> > > > This might be kOK too, but in practice I don't think much will be in
> > > > moduleloader.h: asm/module.h only really defines struct
> > > > mod_arch_specific, which is embedded in struct module, and struct
> > > > module needs to be exposed for those inlines...
> > > 
> > > But does everyone who wants to implement a module need to be exposed
> > > to all the details of the elf header?
> > 
> > Well, linux/module.h -> asm/module.h -> linux/elf.h.  Although if you
> > use #define instead of typedef you can break the last link.  Feel free
> > to send a patch to split it into moduleload.h or something, but I
> > think it'll look tiny.
> 
> At least for i386 there is no inclusion of elf.h from asm/module.h, and they
> are already defines.

I know, I wrote them.  But a header should include all the files
needed to use it, as a general rule.

I'm looking at the moduleloader.h patch, and I think it looks sane
(the archs need to #include it, too).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
