Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVC3DXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVC3DXi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 22:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVC3DWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 22:22:38 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57794 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261719AbVC3DA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 22:00:29 -0500
Message-Id: <200503300125.j2U1PFQ9005082@laptop11.inf.utfsm.cl>
To: "Jean Delvare" <khali@linux-fr.org>
cc: akpm@osdl.org, "Adrian Bunk" <bunk@stusta.de>,
       "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a check after use) 
In-Reply-To: Message from "Jean Delvare" <khali@linux-fr.org> 
   of "Tue, 29 Mar 2005 12:46:22 +0200." <xyDqcv4K.1112093182.7253990.khali@localhost> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 29 Mar 2005 21:25:13 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jean Delvare" <khali@linux-fr.org> said:

[Sttributions missing, sorry]

> > >  Think about it. If the pointer could be NULL, then it's unlikely that
> > >  the bug would have gone unnoticed so far (unless the code is very
> > >  recent). Coverity found 3 such bugs in one i2c driver [1], and the
> > >  correct solution was to NOT check for NULL because it just couldn't
> > >  happen.

> > No, there is a third case: the pointer can be NULL, but the compiler
> > happened to move the dereference down to after the check.

> Wow. Great point. I completely missed that possibility. In fact I didn't
> know that the compiler could possibly alter the order of the
> instructions. For one thing, I thought it was simply not allowed to. For
> another, I didn't know that it had been made so aware that it could
> actually figure out how to do this kind of things. What a mess. Let's
> just hope that the gcc folks know their business :)

The compiler is most definitely /not/ allowed to change the results the
code gives.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
