Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310913AbSCMRoU>; Wed, 13 Mar 2002 12:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310917AbSCMRoL>; Wed, 13 Mar 2002 12:44:11 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:34064 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S310913AbSCMRoB>; Wed, 13 Mar 2002 12:44:01 -0500
Message-Id: <200203131842.g2DIgjtb024607@pincoya.inf.utfsm.cl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7 
In-Reply-To: Message from Jeff Garzik <jgarzik@mandrakesoft.com> 
   of "Mon, 11 Mar 2002 20:50:05 EST." <3C8D5ECD.6090108@mandrakesoft.com> 
Date: Wed, 13 Mar 2002 14:42:45 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com>

[...]

> I -do- know the distrinction between hosts and devices.  I think there 
> should be -some- way, I don't care how, to filter out those unknown 
> commands (which may be perfectly valid for a small subset of special IBM 
> drives).  The net stack lets me do filtering, I want to sell you on the 
> idea of letting the ATA stack do the same thing.

The net stack does filtering for handling traffic from _untrusted_ external
sources, either for local consumtion or as a service for dumb machines
downstream, and as a way of limiting outward access to _untrusted_
users. Here we are talking of the ultimate _trusted_ user (root,
CAP_SYS_RAWIO, whatever). It makes no sense for the _kernel_ to get in the
way. Create a userland proggie for prodding IDE drives, and give it ways to
check (as far as terminal paranoia demands, a little, or not at all) as
desired. Unix ultimate simplicity is all about giving root enough rope to
shoot at his own feet.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
