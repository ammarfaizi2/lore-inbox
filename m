Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265787AbUEULSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265787AbUEULSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 07:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUEULSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 07:18:41 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:5897 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265787AbUEULSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 07:18:38 -0400
Date: Fri, 21 May 2004 21:18:28 +1000
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
Message-ID: <20040521111828.GA870@gondor.apana.org.au>
References: <20040521100734.GA31550@elf.ucw.cz> <E1BR7pl-0000Br-00@gondolin.me.apana.org.au> <20040521111612.GA976@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521111612.GA976@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 01:16:13PM +0200, Pavel Machek wrote:
> 
> > > --- tmp/linux/arch/i386/mm/init.c       2004-05-20 23:08:05.000000000 +0200
> > > +++ linux/arch/i386/mm/init.c   2004-05-20 23:10:50.000000000 +0200
> > > @@ -331,6 +331,13 @@
> > > void zap_low_mappings (void)
> > > {
> > >        int i;
> > > +
> > > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > 
> > Can you please define this for CONFIG_PM_DISK as well? Alternatively,
> > you can do the same as you did in cpu.c and define this for
> > CONFIG_PM.
> 
> That would need few more parts to actually do something usefull on
> pmdisk, right? Lowlevel code needs to know how to switch.

Well once you do this then pmdisk.S can be easily patched to do
the same thing as swsusp.S :)
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
