Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292150AbSCIBAn>; Fri, 8 Mar 2002 20:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292233AbSCIBAd>; Fri, 8 Mar 2002 20:00:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18692 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292130AbSCIBAV>; Fri, 8 Mar 2002 20:00:21 -0500
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
To: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 9 Mar 2002 01:15:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a6bjgl$a0j$1@cesium.transmeta.com> from "H. Peter Anvin" at Mar 08, 2002 04:03:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jVSZ-0008FH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems to me that the i386 support has been around mostly on a
> "until we have a reason to do otherwise" basis, but perhaps this is
> the reason?
> 
> There certainly are enough little, nagging reasons... CMPXCHG, BSWAP,
> and especially WP...

They don't really arise in most normal situations. Bswap is trivial to
the extreme. Cmpxchg only comes up on SMP boxes.  Right now the one big
hit is cmpxchg8 if you use direct rendering. And quite frankly if you
use the direct rendering infrastructure on a 386 its going to be a teeny
bit slow anyway 8)

So if anything its just not worth the effort of breaking the 386 setup
either 8). 386 SMP is a different issue but I don't see any lunatics doing
a 386 based sequent port thankfully.

Alan
