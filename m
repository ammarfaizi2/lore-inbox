Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbTBJPYm>; Mon, 10 Feb 2003 10:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbTBJPYm>; Mon, 10 Feb 2003 10:24:42 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:26309 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S261733AbTBJPYl>; Mon, 10 Feb 2003 10:24:41 -0500
Message-Id: <200302101301.h1AD1DE2001067@eeyore.valparaiso.cl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Frank Davis <fdavis@si.rr.com>, Vineet M Abraham <vmabraham@hotmail.com>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       brand@eeyore.valparaiso.cl
Subject: Re: [PATCH] 2.5.59 : drivers/net/fc/iph5526.c 
In-Reply-To: Your message of "Mon, 10 Feb 2003 11:34:02 +1100."
             <20030210014642.859B12C2C9@lists.samba.org> 
Date: Mon, 10 Feb 2003 14:01:13 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> said:

[...]

> > -	for (i = 0; i < clone_list[i].vendor_id != 0; i++)

i < clone_list[i].vendor_id != 0 is (i < clone_list[i].vendor_id) != 0 is
just i < clone_list[i].vendor_id, so the for is done for i = 0 and possibly
for 1. Getting this effect (if desired) with an if is a load clearer.

Having i twice in the condition is also highly suspicious... is this code
ever executed? It looks like a bad screwup in the condition that went
unnoticed because it was never hit.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
