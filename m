Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266142AbVBDSd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbVBDSd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 13:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264797AbVBDSaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 13:30:55 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:52676 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264938AbVBDS3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 13:29:49 -0500
Message-Id: <200502041713.j14HDkjp006327@laptop11.inf.utfsm.cl>
To: jerome lacoste <jerome.lacoste@gmail.com>
cc: Bernd Eckenfels <ecki-news2005-01@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Huge unreliability - does Linux have something to do with it? 
In-Reply-To: Message from jerome lacoste <jerome.lacoste@gmail.com> 
   of "Fri, 04 Feb 2005 12:28:07 BST." <5a2cf1f60502040328aaf6c9f@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 04 Feb 2005 14:13:46 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.4 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 04 Feb 2005 15:29:31 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> said:
> Bernd Eckenfels <ecki-news2005-01@lina.inka.de> said:
> >> Could a hardware failure look like bad sectors to fsck?

> > A failure of the bus or a former sporadic error can cause defective fs, but
> > normally you have a read error in fsck no structure error.
> > 
> > Are you using hdparm? is the system perhaps overheating or overclocked?

> no overclock
> hdparm is used but I cannot tell you exactly what the config is (now
> machine has been running memtest for 1.5 hour). I don't think I use
> special option: probably the defaults in my config file (mult_sect 16,
> dma on, write_cache off).

There are combinations of IDE + disk that slowly corrupt filesystems with
DMA on, if the default setting is DMA off _don't touch it_. Not all bad
combinations are catched by the code in the kernel (intel + some Western
Digital disk is what drove me up the wall until I disabled DMA).

What machine is this, what disk?

> overheating: perhaps. The machine is hot and running many hours per
> day (usually 12-16). It s running the fans very often, but it's always
> been like that. I've tried to control the fan, but then the
> temperature goes high very quickly. So I let the fans run.

Wise decision.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
