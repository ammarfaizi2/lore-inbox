Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbUK1XAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbUK1XAy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbUK1XAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:00:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7441 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261589AbUK1XAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:00:44 -0500
Date: Mon, 29 Nov 2004 00:00:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Rusty Russell <rusty@rustcorp.com.au>, David Howells <dhowells@redhat.com>
Cc: vlobanov <vlobanov@speakeasy.net>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, lethal@linux-sh.org,
       kkojima@rr.iij4u.or.jp
Subject: Re: EXPORT_SYMBOL_NOVERS question
Message-ID: <20041128230043.GH4390@stusta.de>
References: <Pine.LNX.4.58.0411030007220.22814@shell2.speakeasy.net> <1101681740.25347.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101681740.25347.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 09:42:20AM +1100, Rusty Russell wrote:
> On Wed, 2004-11-03 at 00:10 -0800, vlobanov wrote:
> > Hi,
> > 
> > I was looking over the /include/linux/module.h file, and the
> > EXPORT_SYMBOL_NOVERS macro caught my eye. To quote the source:
> > 
> >   /* We don't mangle the actual symbol anymore, so no need for
> >    * special casing EXPORT_SYMBOL_NOVERS.  FIXME: Deprecated */
> >   #define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
> > 
> > A quick grep through the tree brought up no usage cases for this macro.
> > Is there any reason to keep it around, instead of cutting it out, as the
> > FIXME comment seems to suggest?
> 
> Yep, it's time.
> 
> Rusty.
> 
> Name: Remove EXPORT_SYMBOL_NOVERS
> Status: Trivial
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> Vadim Lobanov points out that EXPORT_SYMBOL_NOVERS is no longer used;
> in fact, SH still uses it, but once we fix that, the kernel is clean.
> Remove it.
>...

Thaat's true for Linus' tree, but not for -mm.

@David:
arch/frv/kernel/frv_ksyms.c has to be changed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

