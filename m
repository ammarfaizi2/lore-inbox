Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130523AbRCWLCK>; Fri, 23 Mar 2001 06:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRCWLBv>; Fri, 23 Mar 2001 06:01:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5389 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130532AbRCWLBm>; Fri, 23 Mar 2001 06:01:42 -0500
Subject: Re: [CHECKER] 4 warnings in kernel/module.c
To: yjf@stanford.edu (Junfeng Yang)
Date: Fri, 23 Mar 2001 11:03:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
In-Reply-To: <Pine.GSO.4.31.0103230236500.3192-100000@epic8.Stanford.EDU> from "Junfeng Yang" at Mar 23, 2001 02:41:40 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gPMF-0004U1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, we modified the block checker and run it again on linux 2.4.1. (The
> block checker flags an error when blocking functions are called with
> either interrupts disabled or a spin lock held. )

lock_kernel() isnt a spinlock as such.

> 2. Can functions like kmem_cache_create, kmem_cache_alloc, alloc_page
> block?

They may block unless GFP_ATOMIC is specified in the arguments.

Alan

