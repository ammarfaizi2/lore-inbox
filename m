Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbTBKIwB>; Tue, 11 Feb 2003 03:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267328AbTBKIwA>; Tue, 11 Feb 2003 03:52:00 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:19118 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267327AbTBKIwA>; Tue, 11 Feb 2003 03:52:00 -0500
Message-Id: <200302110901.h1B91cfa013400@eeyore.valparaiso.cl>
To: Valdis.Kletnieks@vt.edu
cc: Rusty Russell <rusty@rustcorp.com.au>, Frank Davis <fdavis@si.rr.com>,
       Vineet M Abraham <vmabraham@hotmail.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] 2.5.59 : drivers/net/fc/iph5526.c 
In-Reply-To: Your message of "Mon, 10 Feb 2003 23:18:36 EST."
             <200302110418.h1B4IbjB002565@turing-police.cc.vt.edu> 
Date: Tue, 11 Feb 2003 10:01:37 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu said:
> On Mon, 10 Feb 2003 14:01:13 +0100, Horst von Brand said:
> > Rusty Russell <rusty@rustcorp.com.au> said:
> > 
> > [...]
> > 
> > > > -	for (i = 0; i < clone_list[i].vendor_id != 0; i++)
> > 
> > i < clone_list[i].vendor_id != 0 is (i < clone_list[i].vendor_id) != 0 is
> > just i < clone_list[i].vendor_id, so the for is done for i = 0 and possibly
> > for 1. Getting this effect (if desired) with an if is a load clearer.
> 
> However, looking at the definition of clone_list[], it's pretty obvious
> that this was intended:
> 
>     for (i=0; clone_list[i].vendor_id != 0; i++) {...
> 
> It's searching through a zero-terminated table of vendor_id's.

It isn't, as written. Something is very wrong in any case, as it should
have blown up somewhere before.

In any case, the != 0 is redundant, idiomatic C is to just go:

     for (i=0; clone_list[i].vendor_id; i++) {...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
