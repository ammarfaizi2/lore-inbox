Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131396AbRCWTvL>; Fri, 23 Mar 2001 14:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131395AbRCWTvC>; Fri, 23 Mar 2001 14:51:02 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:59127 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S131396AbRCWTuz>; Fri, 23 Mar 2001 14:50:55 -0500
Date: Fri, 23 Mar 2001 11:49:50 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>, <mc@CS.Stanford.EDU>
Subject: Re: [CHECKER] 4 warnings in kernel/module.c
In-Reply-To: <E14gPMF-0004U1-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.31.0103231148280.24215-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Alan Cox wrote:

> > Hi, we modified the block checker and run it again on linux 2.4.1. (The
> > block checker flags an error when blocking functions are called with
> > either interrupts disabled or a spin lock held. )
>
> lock_kernel() isnt a spinlock as such.

Thanks a lot. We just figured out that it is ok to block within
lock_kernel() unlock_kernel() scope. That will help us to eliminate
some false positives.


