Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288970AbSAITGj>; Wed, 9 Jan 2002 14:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSAITGa>; Wed, 9 Jan 2002 14:06:30 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:18650 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S288970AbSAITGY>;
	Wed, 9 Jan 2002 14:06:24 -0500
Message-Id: <m16OO2K-000OVeC@amadeus.home.nl>
Date: Wed, 9 Jan 2002 19:05:20 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: Athanasius@gurus.tf (Athanasius)
Subject: Re: [PATCH] Athlon XP 1600+ and _mmx_memcpy symbol in modules
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020109182224.GI15688@gurus.tf>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020109182224.GI15688@gurus.tf> you wrote:
> Hi,
>  I've just upraded from my old PII-400 system to an Athlon XP 1600+
> based system so changed from "Pentium-Pro/Celeron/Pentium-II"
> (CONFIG_M686) to "Athlon/Duron/K7" (CONFIG_MK7).  In doing so I suddenly
> saw a LOT of problems with modules and the symbol _mmx_memcpy being
> undefined.

>  I finally kludged/fixed this by changing line 121 of
> arch/i386/kernel/i386_ksyms.c from:

> EXPORT_SYMBOL(_mmx_memcpy);

you forgot to make mrproper ;) (or at least make clean)
yes the makefile for modversions is missing a dependency......
