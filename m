Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262701AbRE3KNc>; Wed, 30 May 2001 06:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbRE3KNV>; Wed, 30 May 2001 06:13:21 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:23961 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262701AbRE3KNK>; Wed, 30 May 2001 06:13:10 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200105301011.MAA17517@sunrise.pg.gda.pl>
Subject: Re: [PATCH] net #3
To: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 30 May 2001 12:11:37 +0200 (MET DST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrewm@uow.edu.au,
        p_gortmaker@yahoo.com, linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <29071.991213917@redhat.com> from "David Woodhouse" at May 30, 2001 10:11:57 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Woodhouse wrote:"
> 
> ankry@green.mif.pg.gda.pl said:
> > -#ifdef CONFIG_ISAPNP 
> > +#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE)) 
> 
> The result here would be a 3c509 module which differs depending on whether 
> the ISAPNP module happened to be compiled at the same time or not. 

I'm just thinking whether the ISA PnP hardware related modules should depend
on isa-pnp.o at all 
(I mean having different behaviour of a the SAME (compiled) module depending
on whether isa-pnp.o is available or not)

It is just adding some persistent pointers for isa-pnp functions to the
kernel and teaching the modules to use request_module(). Probably also some
hacking to keep away from already used ISA PnP hardware during
initialization...

Also implementing "nopnp" option should be mandatory, IMHO.

> The ISAPNP-specific parts of the code aren't large. Please consider
> including them unconditionally instead. 

I see no objection if __init for modules is implemented...

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk

