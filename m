Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291753AbSCIAEF>; Fri, 8 Mar 2002 19:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291729AbSCIAD4>; Fri, 8 Mar 2002 19:03:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28935 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291717AbSCIADs>; Fri, 8 Mar 2002 19:03:48 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: 8 Mar 2002 16:03:33 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6bjgl$a0j$1@cesium.transmeta.com>
In-Reply-To: <20020308231405.CADDC3FE06@smtp.linux.ibm.com> <Pine.LNX.4.33.0203081532550.4421-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0203081532550.4421-100000@penguin.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> You don't understand. This has nothing to do with lock holders, or 
> anything else.
> 
> I'm saying that we map in a page at a magic offset (just above the stack), 
> and that page contains the locking code.
> 
> For 386 CPU's (where only UP matters), we can trivially come up with a
> lock that doesn't use cmpxchg8b and that isn't SMP-safe. It might even go
> into the kernel every time if it has to - ie it _works_, it just isn't 
> optimal.
> 

Okay, I'll say it and be impopular...

Perhaps it's time to drop i386 support?

It seems to me that the i386 support has been around mostly on a
"until we have a reason to do otherwise" basis, but perhaps this is
the reason?

There certainly are enough little, nagging reasons... CMPXCHG, BSWAP,
and especially WP...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
