Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbRE3LDt>; Wed, 30 May 2001 07:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262731AbRE3LDj>; Wed, 30 May 2001 07:03:39 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:52751 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262728AbRE3LDe>; Wed, 30 May 2001 07:03:34 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105301102.NAA06481@green.mif.pg.gda.pl>
Subject: Re: [PATCH] net #3
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Wed, 30 May 2001 13:02:25 +0200 (CEST)
Cc: dwmw2@infradead.org (David Woodhouse), alan@lxorguk.ukuu.org.uk (Alan Cox),
        andrewm@uow.edu.au, p_gortmaker@yahoo.com,
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <3B14CDF8.492356F5@mandrakesoft.com> from "Jeff Garzik" at May 30, 2001 06:39:52 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Woodhouse wrote:
> > 
> > ankry@green.mif.pg.gda.pl said:
> > > -#ifdef CONFIG_ISAPNP
> > > +#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
> > 
> > The result here would be a 3c509 module which differs depending on whether
> > the ISAPNP module happened to be compiled at the same time or not.
> 
> In and of itself, that is an acceptable result.  We simply cannot take
> into kernel configuration variations between two kernel builds.  If you
> build your isapnp module with one configuration, and your 3c509 module
> with another config, consider yourself lucky that it works at all.

I think it is better to avoid such a dependency if possible. It will
especially simplify life of people who use precompiled kernels/modules.
And (IMHO) it is possible and quite easy to remove dependency of drivers
like network drivers on isa-pnp. I will try to prepare a test patch for if
when I find some free time...
But it would be probably a 2.5 feature (with possible backport later).

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
