Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVAaOBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVAaOBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVAaOBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:01:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48652 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261201AbVAaOBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:01:05 -0500
Date: Mon, 31 Jan 2005 15:01:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: inter-module-* removal.. small next step
Message-ID: <20050131140104.GK18316@stusta.de>
References: <20050130180016.GA12987@infradead.org> <1107132112.783.219.camel@baythorne.infradead.org> <1107159869.4221.53.camel@laptopd505.fenrus.org> <20050131135631.GA6694@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050131135631.GA6694@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 02:56:32PM +0100, Jörn Engel wrote:
> On Mon, 31 January 2005 09:24:29 +0100, Arjan van de Ven wrote:
> > On Mon, 2005-01-31 at 00:41 +0000, David Woodhouse wrote:
> > > On Sun, 2005-01-30 at 18:00 +0000, Arjan van de Ven wrote:
> > > > 
> > > > intermodule is deprecated for quite some time now, and MTD is the sole last
> > > > user in the tree. To shrink the kernel for the people who don't use MTD, and
> > > > to prevent accidental return of more users of this, make the compiling of
> > > > this function conditional on MTD.
> > > 
> > > Please get the dependencies right -- it's not core MTD code, but the NOR
> > > chip drivers and the old DiskOnChip drivers which use this. 
> > 
> > that's just a slightly more finegrained thing, not sure if it's worth
> > going that deep, esp since it become 2 deps not one, making a bigger
> > mess than needed.
> 
> How about this one?  It's actually less messy inside kernel/Makefile.
> 
> Completely untested, though.

Your patch doesn't add a Kconfig entry for INTER_MODULE_CRAP.

> Jörn
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

