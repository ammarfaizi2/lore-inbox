Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbRETNfw>; Sun, 20 May 2001 09:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261918AbRETNfm>; Sun, 20 May 2001 09:35:42 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:50441 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261886AbRETNfd>; Sun, 20 May 2001 09:35:33 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105201335.PAA03927@green.mif.pg.gda.pl>
Subject: Re: [PATCH] 2.4.4-ac11 network drivers cleaning
To: kaos@ocs.com.au (Keith Owens)
Date: Sun, 20 May 2001 15:35:35 +0200 (CEST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <12098.990324222@ocs3.ocs-net> from "Keith Owens" at May 20, 2001 12:03:42 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sat, 19 May 2001 17:58:49 -0400, 
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >Finally, I don't know if I mentioned this earlier, but to be complete
> >and optimal, version strings should be a single variable 'version', such
> >that it can be passed directly to printk like
> >
> >	printk(version);
> 
> Nit pick.  That has random side effects if version contains any '%'
> characters.  Make it

It should not. I see no reason for a literal % in the version string.

> 
> 	printk("%s\n", version);
> 
> Not quite as optimal but safer.

It is simpler to remove the %s from version. I don't think any of them
require it. If one add a % he should know what he is doing.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
