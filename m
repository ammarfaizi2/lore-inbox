Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132520AbRDNSw3>; Sat, 14 Apr 2001 14:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132521AbRDNSwU>; Sat, 14 Apr 2001 14:52:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32274 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132520AbRDNSwN>; Sat, 14 Apr 2001 14:52:13 -0400
Subject: Re: [PATCH] Re: 8139too: defunct threads
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sat, 14 Apr 2001 19:53:28 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, stewart@dystopia.lab43.org (Rod Stewart),
        linux-kernel@vger.kernel.org
In-Reply-To: <3AD88A00.DF54EC12@colorfullife.com> from "Manfred Spraul" at Apr 14, 2001 07:33:52 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14oVAp-0005Nj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rod's init version (from RH 7.0) doesn't reap children that died before
> it was started. Is that an init bug or should the kernel reap them
> before the execve?

I would say thats an init bug

> The attached patch reaps all zombies before the execve("/sbin/init").

That has an implicit race, a zombie can always appear as we are execing init.
I think init wants fixing

